#!/bin/bash

# Copies latest edxprod database with all its tables from
# Stanford's platform instance table dump machine, and imports
# a selection of tables into local MySQL's db 'edxprod'. Password-less
# login must have been arranged to the remote machine so
# that scp works.
#
# The -n CL option causes the already existing local copy
# of edxapp-latest.sql.gz to be used to find the tables, 
# rather than copying a new one from the backup server.
#
# To add tables that are to be included in the load, modify
# below as follows:
#
#   1. In array variable TABLE, add name of new table
#
# This script uses service script extractTableFromDump.sh
# Stats:
#    courseware_studentmodule loading: ~1hr45min (w/o index building)

EDX_PLATFORM_DUMP_MACHINE=jenkins.prod.class.stanford.edu

USAGE='Usage: '`basename $0`' [-u localUbuntuUser][-p][-pLocalMySQLRootPwd][-n]'

# If -u is omitted, then unix 'whoami' is used.
# If option -p is provided, script will request password for
# local MySQL db's root user. As per MySQL the -p can be
# fused with the pwd on the CL. The MySQL activities all run as
# MySQL user root. The -u localUbuntuUser is only relevant
# if no MySQL root pwd is provided with -p. In that case 
# the given Ubuntu user's home dir is expected to contain
# file .ssh/mysql_root with the password.

# Array of tables to get from edxprod (NOTE: no commas between tables!):
TABLES=(courseware_studentmodule \
        courseware_studentmodulehistory \
        auth_user \
        certificates_generatedcertificate \
        auth_userprofile \
        external_auth_externalauthmap \
        student_anonymoususerid \
        student_courseenrollment\
        submissions_score\
        submissions_scoresummary\
        submissions_studentitem\
        submissions_submission 
       )

MYSQL_PASSWD=''
MYSQL_USERNAME=root
UBUNTU_USERNAME=`whoami`
EDXPROD_DUMP_DIR=/home/dataman/Data/FullDumps/EdxAppPlatformDbs
LOG_FILE=/home/dataman/Data/EdX/NonTransformLogs/refreshEdxprod.log
needLocalPasswd=false
# Want to pull a fresh copy of edxapp-latest.sql.gz from backup server,
# unless find the -n option further down:
COPY_FROM_PLATFORM_BACKUP=1

# Get directory in which this script is running,
# and where its support scripts therefore live:
currScriptsDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ------------------ Process Commandline Options -------------------

# Check whether given -pPassword, i.e. fused -p with a 
# pwd string:

for arg in $@
do
   # The sed -r option enables extended regex, which
   # makes the '+' metachar work. The -n option
   # says to print only if pattern matches:
   MYSQL_PASSWD=`echo $arg | sed -r -n 's/-p(.+)/\1/p'`
   if [ -z $MYSQL_PASSWD ]
   then
       continue
   else
       #echo "MYSQL_PASSWD is:"$MYSQL_PASSWD
       break
   fi
done


# Now check for '-p' without explicit pwd;
# the leading colon in options causes wrong options
# to drop into \? branch:
NEXT_ARG=0

while getopts ":pnu:" opt
do
  case $opt in
    p)
      needLocalPasswd=true
      NEXT_ARG=$((NEXT_ARG + 1))
      ;;
    u)
      MYSQL_USERNAME=$OPTARG
      NEXT_ARG=$((NEXT_ARG + 2))
      ;;
    n)
      COPY_FROM_PLATFORM_BACKUP=0
      NEXT_ARG=$((NEXT_ARG + 1))
      ;;
    \?)
      # If $MYSQL_PASSWD is set, we *assume* that 
      # the unrecognized option was a
      # -pMyPassword, and don't signal
      # an error. Therefore, if $MYSQL_PASSWD
      # is set, and *then* an illegal option
      # is on the command line, it is quietly
      # ignored:
      if [ ! -z $MYSQL_PASSWD ] 
      then 
	  continue
      else
	  echo $USAGE
	  exit 1
      fi
      ;;
  esac
done

# Shift past all the optional parms:
shift ${NEXT_ARG}

# ------------------ Ask for Passwords if Requested on CL -------------------

# Ask for local pwd, unless was given
# a fused -pLocalPWD:
if $needLocalPasswd && [ -z $MYSQL_PASSWD ]
then
    # The -s option suppresses echo:
    read -s -p "Password for "$MYSQL_USERNAME" on local MySQL server: " MYSQL_PASSWD
    echo
elif [ -z $MYSQL_PASSWD ]
then
    # Get home directory of whichever user will
    # log into MySQL, except for root:

    if [[ $MYSQL_USERNAME == 'root' ]]
    then
        HOME_DIR=$(getent passwd `whoami` | cut -d: -f6)
        if test -f $HOME_DIR/.ssh/mysql_root && test -r $HOME_DIR/.ssh/mysql_root
        then
                MYSQL_PASSWD=`cat $HOME_DIR/.ssh/mysql_root`
        fi
    else
        HOME_DIR=$(getent passwd $UBUNTU_USERNAME | cut -d: -f6)
        # If the home dir has a readable file called mysql in its .ssh
        # subdir, then pull the pwd from there:

        if test -f $HOME_DIR/.ssh/mysql && test -r $HOME_DIR/.ssh/mysql
        then
                MYSQL_PASSWD=`cat $HOME_DIR/.ssh/mysql`
        fi
    fi
fi

#**********
#echo 'MySQL uid: '$MYSQL_USERNAME
#echo 'MySQL pwd: "'$MYSQL_PASSWD'"'
#echo 'Ubuntu uid: '$UBUNTU_USERNAME
#exit 0
# *********

# ------------------ Signin-------------------
echo `date`": Begin refreshing edxprod."  | tee --append $LOG_FILE
echo "----------"
# ------------------ Copy full edxprod dump from prod machine to datastage -------------------

if [[ COPY_FROM_PLATFORM_BACKUP -eq 1 ]]
then
    echo `date`": Begin copying edxapp-latest.sql.gz from backup server."
    scp $EDX_PLATFORM_DUMP_MACHINE:/data/dump/edxapp-latest.sql.gz \
	$EDXPROD_DUMP_DIR/
fi

# ------------------ Ensure Existence of Local Database -------------------

mysql -u root -p$MYSQL_PASSWD -e "CREATE DATABASE IF NOT EXISTS edxprod;"


# ------------------ Extract and Load Tables from Dump File -------------------

# Path to the just copied large edxprod mysqldump file:
DUMP_FILE=$EDXPROD_DUMP_DIR/edxapp-latest.sql.gz

# For each table we want, use script extractTableFromDump.sh
# to pull out the table restoration commands into a separate
# .sql file, load the file into database edxprod on the
# datastage MySQL server, and build the indexes that came
# with the tables:

for TABLE in ${TABLES[@]} 
do
    echo `date`": Extracting table $TABLE."  | tee --append $LOG_FILE
    $currScriptsDir/extractTableFromDump.sh $DUMP_FILE $TABLE > $EDXPROD_DUMP_DIR/$TABLE.sql

    # Because MySQL is soooo slow loading tables
    # with a primary index, modify the table
    # courseware_studentmodule.sql to drop the
    # primary index before loading:
    if [[ $TABLE == 'courseware_studentmodule' ]]
    then
	echo "Adding DROP INDEX PRIMARY ON courseware_studentmodule to .sql export..." | tee --append $LOG_FILE
	cat $EDXPROD_DUMP_DIR/courseware_studentmodule.sql 
	                                                   | sed 's/^-- Dumping data for table `courseware_studentmodule`/DROP INDEX `PRIMARY` ON courseware_studentmodule;/' \
                                                           | sed 's/^  `id` int(11) NOT NULL AUTO_INCREMENT/  `id` int(11) NOT NULL/' \
                  > $EDXPROD_DUMP_DIR/courseware_studentmoduleNoPrimaryIndex.sql
        TABLE=courseware_studentmoduleNoPrimaryIndex
	echo "Done adding the DROP INDEX." | tee --append $LOG_FILE
    fi

    # Same with courseware_studentmodulehistory:
    if [[ $TABLE == 'courseware_studentmodulehistory' ]]
    then
	echo "Adding DROP INDEX PRIMARY ON courseware_studentmodulehistory to .sql export..." | tee --append $LOG_FILE
	cat $EDXPROD_DUMP_DIR/courseware_studentmodulehistory.sql | sed 's/^-- Dumping data for table `courseware_studentmodulehistory`/DROP INDEX `PRIMARY` ON courseware_studentmodulehistory;/' \
                                                                  | sed 's/^  `id` int(11) NOT NULL AUTO_INCREMENT/  `id` int(11) NOT NULL/' \
                  > $EDXPROD_DUMP_DIR/courseware_studentmodulehistoryNoPrimaryIndex.sql
        TABLE=courseware_studentmodulehistoryNoPrimaryIndex
	echo "Done adding the DROP INDEX." | tee --append $LOG_FILE
    fi

    echo `date`": Loading table $TABLE."  | tee --append $LOG_FILE
    mysql -u root -p$MYSQL_PASSWD edxprod < $EDXPROD_DUMP_DIR/$TABLE.sql
done

# Now create the true_enrollment table, which only
# contains rows for learners that fully enrolled, i.e.
# answered the confirmation email, and who do not
# receive one or more entries in student_courseenrollment just
# because they accessed course material in an internal course
# that was marked as internal, but allowed public access.

newTblCmd="DROP TABLE IF EXISTS true_courseenrollment;
	   CREATE TABLE true_courseenrollment (
	     user_id int(11) NOT NULL,
	     course_display_name varchar(255) NOT NULL,
	     created datetime DEFAULT NULL,
	     mode varchar(100) NOT NULL,
	     KEY true_courseenrollment_uid (user_id),
	     KEY true_courseenrollment_course_id (course_display_name),
	     KEY true_courseenrollment_created (created)
	   ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
	   ALTER TABLE true_courseenrollment DISABLE KEYS;
	   INSERT INTO true_courseenrollment
	   SELECT student_courseenrollment.user_id,
	          course_id AS course_display_name,
	          created,
	          mode
	   FROM student_courseenrollment LEFT JOIN 
	        (SELECT user_id
	         FROM auth_userprofile
	        WHERE nonregistered = 0
	        ) AS TrueRegistrations
	     ON student_courseenrollment.user_id = TrueRegistrations.user_id
	     WHERE student_courseenrollment.is_active = 1;
	   ALTER TABLE true_courseenrollment ENABLE KEYS;
         "
echo $newTblCmd | mysql -u root -p$MYSQL_PASSWD edxprod

# ------------------ Signout -------------------
echo `date`": Finished refreshing edxprod tables."  | tee --append $LOG_FILE
echo "----------"
