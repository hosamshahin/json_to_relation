CREATE DATABASE IF NOT EXISTS Edx;
CREATE DATABASE IF NOT EXISTS EdxPrivate;
USE test;
SET foreign_key_checks = 0;
DROP TABLE IF EXISTS EdxTrackEvent, Answer, InputState, CorrectMap, State, EdxPrivate.Account, LoadInfo;
SET foreign_key_checks = 1;
CREATE TABLE IF NOT EXISTS Answer (
    answer_id VARCHAR(40) NOT NULL PRIMARY KEY,
    problem_id TEXT NOT NULL,
    answer TEXT NOT NULL,
    course_id TEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS CorrectMap (
    correct_map_id VARCHAR(40) NOT NULL PRIMARY KEY,
    answer_identifier TEXT NOT NULL,
    correctness TINYTEXT NOT NULL,
    npoints INT NOT NULL,
    msg TEXT NOT NULL,
    hint TEXT NOT NULL,
    hintmode TINYTEXT NOT NULL,
    queuestate TEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS InputState (
    input_state_id VARCHAR(40) NOT NULL PRIMARY KEY,
    problem_id TEXT NOT NULL,
    state TEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS State (
    state_id VARCHAR(40) NOT NULL PRIMARY KEY,
    seed TINYINT NOT NULL,
    done TINYTEXT NOT NULL,
    problem_id TEXT NOT NULL,
    student_answer VARCHAR(40) NOT NULL,
    correct_map VARCHAR(40) NOT NULL,
    input_state VARCHAR(40) NOT NULL,
    FOREIGN KEY(student_answer) REFERENCES Answer(answer_id) ON DELETE CASCADE,
    FOREIGN KEY(correct_map) REFERENCES CorrectMap(correct_map_id) ON DELETE CASCADE,
    FOREIGN KEY(input_state) REFERENCES InputState(input_state_id) ON DELETE CASCADE
    );
CREATE TABLE IF NOT EXISTS EdxPrivate.Account (
    account_id VARCHAR(40) NOT NULL PRIMARY KEY,
    screen_name TEXT NOT NULL,
    name TEXT NOT NULL,
    anon_screen_name TEXT NOT NULL,
    mailing_address TEXT NOT NULL,
    zipcode TINYTEXT NOT NULL,
    country TINYTEXT NOT NULL,
    gender TINYTEXT NOT NULL,
    year_of_birth TINYINT NOT NULL,
    level_of_education TINYTEXT NOT NULL,
    goals TEXT NOT NULL,
    honor_code TINYINT NOT NULL,
    terms_of_service TINYINT NOT NULL,
    course_id TEXT NOT NULL,
    enrollment_action TINYTEXT NOT NULL,
    email TEXT NOT NULL,
    receive_emails TINYTEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS LoadInfo (
    load_info_id INT NOT NULL PRIMARY KEY,
    load_date_time DATETIME NOT NULL,
    load_file TEXT NOT NULL
    );
CREATE TABLE IF NOT EXISTS EdxTrackEvent (
    _id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    event_id VARCHAR(40) NOT NULL,
    agent TEXT NOT NULL,
    event_source TINYTEXT NOT NULL,
    event_type TEXT NOT NULL,
    ip TINYTEXT NOT NULL,
    page TEXT NOT NULL,
    session TEXT NOT NULL,
    time DATETIME NOT NULL,
    anon_screen_name TEXT NOT NULL,
    downtime_for DATETIME NOT NULL,
    student_id TEXT NOT NULL,
    instructor_id TEXT NOT NULL,
    course_id TEXT NOT NULL,
    sequence_id TEXT NOT NULL,
    goto_from INT NOT NULL,
    goto_dest INT NOT NULL,
    problem_id TEXT NOT NULL,
    problem_choice TEXT NOT NULL,
    question_location TEXT NOT NULL,
    submission_id TEXT NOT NULL,
    attempts INT NOT NULL,
    long_answer TEXT NOT NULL,
    student_file TEXT NOT NULL,
    can_upload_file TINYTEXT NOT NULL,
    feedback TEXT NOT NULL,
    feedback_response_selected TINYINT NOT NULL,
    transcript_id TEXT NOT NULL,
    transcript_code TINYTEXT NOT NULL,
    rubric_selection INT NOT NULL,
    rubric_category INT NOT NULL,
    video_id TEXT NOT NULL,
    video_code TEXT NOT NULL,
    video_current_time TINYTEXT NOT NULL,
    video_speed TINYTEXT NOT NULL,
    video_old_time TINYTEXT NOT NULL,
    video_new_time TINYTEXT NOT NULL,
    video_seek_type TINYTEXT NOT NULL,
    video_new_speed TINYTEXT NOT NULL,
    video_old_speed TINYTEXT NOT NULL,
    book_interaction_type TINYTEXT NOT NULL,
    success TINYTEXT NOT NULL,
    answer_id TEXT NOT NULL,
    hint TEXT NOT NULL,
    hintmode TINYTEXT NOT NULL,
    correctness TINYTEXT NOT NULL,
    msg TEXT NOT NULL,
    npoints TINYINT NOT NULL,
    queuestate TEXT NOT NULL,
    orig_score INT NOT NULL,
    new_score INT NOT NULL,
    orig_total INT NOT NULL,
    new_total INT NOT NULL,
    event_name TINYTEXT NOT NULL,
    group_user TINYTEXT NOT NULL,
    group_action TINYTEXT NOT NULL,
    position INT NOT NULL,
    badly_formatted TEXT NOT NULL,
    correctMap_fk VARCHAR(40) NOT NULL,
    answer_fk VARCHAR(40) NOT NULL,
    state_fk VARCHAR(40) NOT NULL,
    load_info_fk INT NOT NULL,
    FOREIGN KEY(correctMap_fk) REFERENCES CorrectMap(correct_map_id) ON DELETE CASCADE,
    FOREIGN KEY(answer_fk) REFERENCES Answer(answer_id) ON DELETE CASCADE,
    FOREIGN KEY(state_fk) REFERENCES State(state_id) ON DELETE CASCADE,
    FOREIGN KEY(load_info_fk) REFERENCES LoadInfo(load_info_id) ON DELETE CASCADE
    );
SET foreign_key_checks=0;
SET unique_checks=0;
SET autocommit=0;
INSERT INTO LoadInfo (load_info_id,load_date_time,load_file) VALUES 
    ('f00190a1_ad31_47a9_b298_e713664401fb','2013110806081383919694','file:///home/paepcke/EclipseWorkspaces/json_to_relation/json_to_relation/test/data/saveProblemCheck.json');
INSERT INTO Answer (answer_id,problem_id,answer,course_id) VALUES 
    ('8f0b0d9d_26ea_4ce7_8b71_d55a337c50ed','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_16_1','66.3','Medicine-HRP258'),
    ('99a29095_fd42_4a53_9767_75847f8d5ba5','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_3_1','1.58','Medicine-HRP258'),
    ('2c68623d_3422_4fda_89c5_f527010e385f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_12_1','Binary','Medicine-HRP258'),
    ('0995d975_8945_49a8_a2ee_48bddde630fc','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_6_1','choice_2','Medicine-HRP258'),
    ('ebc310dd_020f_4c5b_b503_8228e7814a5f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_17_1','73.9','Medicine-HRP258'),
    ('066d5ac1_de0c_4cae_9b4e_9a3c1a03e679','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_2_1','13.4','Medicine-HRP258'),
    ('c3a11fb3_3284_4b07_a2c5_92c70bca8d42','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_9_1','53','Medicine-HRP258'),
    ('113f0ab8_9f70_426b_84f0_ba06955146f6','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_14_1','choice_3','Medicine-HRP258'),
    ('203c3d99_4267_489d_9d64_9626490f2fd9','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_13_1','choice_0','Medicine-HRP258'),
    ('f116f143_191e_4ef6_ba0d_8cce633db2a3','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_5_1','3','Medicine-HRP258'),
    ('322a2088_a021_47a7_a3c9_bb021aafadcd','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_10_1','1','Medicine-HRP258'),
    ('0b15f08d_6a09_492c_91ef_4fb48a260175','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_19_1','choice_2','Medicine-HRP258'),
    ('7d37b9c3_3781_4442_bae6_622b9115ac52','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_8_1','0.25','Medicine-HRP258'),
    ('18e82ebc_68fd_432b_b651_412fb994ccb9','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_15_1','81','Medicine-HRP258'),
    ('2367e91c_eb91_4461_8467_5a89c10f3267','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_4_1','14','Medicine-HRP258'),
    ('41228e93_1d9c_4e23_83bf_7ce6fa655e4c','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_11_1','Nominal','Medicine-HRP258'),
    ('8ef2ad05_86ae_4791_9e10_07dd34feb1ca','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_18_1','20','Medicine-HRP258'),
    ('1b432532_06d5_4ac9_8249_7ad8c40c5f77','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_7_1','0.47','Medicine-HRP258'),
    ('eeef71ff_bb54_4844_914e_17f03bb54fda','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_16_1','66.3','Medicine-HRP258'),
    ('dc594b9f_3661_4476_ae76_37898a1417f3','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_3_1','1.58','Medicine-HRP258'),
    ('78eae613_e0ad_4a45_966f_8c85b65b0a5c','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_12_1','Binary','Medicine-HRP258'),
    ('0555c9b7_fdc9_4f0d_a249_b713d0d32c33','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_6_1','choice_2','Medicine-HRP258'),
    ('70809d2f_a1ed_4ad0_8f1d_f9aa709c2816','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_17_1','73.9','Medicine-HRP258'),
    ('32d92acc_616a_4cd0_97b2_497c1022d444','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_2_1','13.4','Medicine-HRP258'),
    ('2996d2f9_bcd5_4d78_b62e_52823d0fdb0f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_9_1','53','Medicine-HRP258'),
    ('f8785b90_1452_48d7_81e6_048a4497ee22','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_14_1','choice_3','Medicine-HRP258'),
    ('2eaa97ee_b4ab_46c7_8c7a_60bdb9dea815','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_13_1','choice_0','Medicine-HRP258'),
    ('df53a14f_dbfe_4444_a143_9ff7547347ef','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_5_1','3','Medicine-HRP258'),
    ('33dc0d96_a719_416c_9ddf_2c3fefb64d14','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_10_1','1','Medicine-HRP258'),
    ('6719b3c8_851c_4a17_8f20_de1fb7119450','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_19_1','choice_2','Medicine-HRP258'),
    ('0951c888_9e95_4109_9204_0fdb0d009d07','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_8_1','0.25','Medicine-HRP258'),
    ('13a5d601_3f85_44d4_9413_751b833cec1f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_15_1','81','Medicine-HRP258'),
    ('bfa6398a_ac1a_4b18_8151_c36060fe9f7d','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_4_1','14','Medicine-HRP258'),
    ('f0bc557c_9352_4180_9f09_2a93898fba98','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_11_1','Nominal','Medicine-HRP258'),
    ('079f57f9_16e0_4d6c_a71e_f9328117e1ef','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_18_1','20','Medicine-HRP258'),
    ('8f9518ec_cc2a_41b4_a73d_1487897ee97f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_7_1','0.47','Medicine-HRP258');
INSERT INTO InputState (input_state_id,problem_id,state) VALUES 
    ('f7f4916e_8489_474d_b6c8_dce8ac985235','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_16_1',''),
    ('d7766b48_610c_44cf_87da_abd989fabd01','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_3_1',''),
    ('ae37c31b_7eb4_467f_ab03_7ae2da8d3f17','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_12_1',''),
    ('338293da_1b61_4de9_993c_c5200b861fcb','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_6_1',''),
    ('2bb78ba1_fa18_413a_8326_9f656a231710','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_17_1',''),
    ('be9df80f_74d4_4dd0_b612_6af90d78342e','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_2_1',''),
    ('9b396e0e_6572_4943_8127_2cd5ae2e9968','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_9_1',''),
    ('d752a6f5_071e_49bf_8623_73b5a95bdcfb','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_14_1',''),
    ('53161c4b_6bc9_4789_b8e9_d04cc021c1b2','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_13_1',''),
    ('53d3eca9_aa35_41f8_a8a6_786a3f934778','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_5_1',''),
    ('6721ed9c_9093_45cc_b02b_f9fa27d02028','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_10_1',''),
    ('ba02ce60_94cc_4b2c_b379_f0052d770133','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_19_1',''),
    ('66b664ea_5dbd_4b1e_aeea_1934bb960ab3','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_8_1',''),
    ('38e7098c_3e8f_4f57_8f5f_1ede482a132f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_15_1',''),
    ('c8c4c20a_87a5_4e3b_b7cc_c2967cd25c60','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_4_1',''),
    ('9339e14e_e13f_4f86_a182_536ec478353d','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_11_1',''),
    ('d42fc73f_10cd_469f_a846_d5f8684e7d7f','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_18_1',''),
    ('383ff8e2_b293_43be_b958_9db5a86b6084','i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_7_1','');
INSERT INTO State (state_id,seed,done,problem_id,student_answer,correct_map,input_state) VALUES 
    ('c7f9c7a8_0e46_47bd_961a_e5fbc8c8e6c5',1,'None','','eeef71ff_bb54_4844_914e_17f03bb54fda','','f7f4916e_8489_474d_b6c8_dce8ac985235'),
    ('92d46c39_7e72_4ba0_8746_299a0d5cf110',1,'None','','dc594b9f_3661_4476_ae76_37898a1417f3','','d7766b48_610c_44cf_87da_abd989fabd01'),
    ('ec6c3d4b_144a_4d4c_9197_1041c1525bb0',1,'None','','78eae613_e0ad_4a45_966f_8c85b65b0a5c','','ae37c31b_7eb4_467f_ab03_7ae2da8d3f17'),
    ('83239258_56e5_48da_93bb_b1d5f348175c',1,'None','','0555c9b7_fdc9_4f0d_a249_b713d0d32c33','','338293da_1b61_4de9_993c_c5200b861fcb'),
    ('42738b72_6ddc_4ba1_b4f5_4bf8581e8221',1,'None','','70809d2f_a1ed_4ad0_8f1d_f9aa709c2816','','2bb78ba1_fa18_413a_8326_9f656a231710'),
    ('44649c25_8387_4781_9b63_06f9a033c618',1,'None','','32d92acc_616a_4cd0_97b2_497c1022d444','','be9df80f_74d4_4dd0_b612_6af90d78342e'),
    ('bd196e60_cf1a_4395_ba34_89a19257958f',1,'None','','2996d2f9_bcd5_4d78_b62e_52823d0fdb0f','','9b396e0e_6572_4943_8127_2cd5ae2e9968'),
    ('96717429_c1e4_4bfc_9caa_21e31169acc7',1,'None','','f8785b90_1452_48d7_81e6_048a4497ee22','','d752a6f5_071e_49bf_8623_73b5a95bdcfb'),
    ('bd8bd895_1a65_4ea7_be6d_f0e6a27e9fc8',1,'None','','2eaa97ee_b4ab_46c7_8c7a_60bdb9dea815','','53161c4b_6bc9_4789_b8e9_d04cc021c1b2'),
    ('8bab2541_86d7_405f_ae5c_1ab790192128',1,'None','','df53a14f_dbfe_4444_a143_9ff7547347ef','','53d3eca9_aa35_41f8_a8a6_786a3f934778'),
    ('602932b2_f1ea_4aa5_b22f_19005091e4ef',1,'None','','33dc0d96_a719_416c_9ddf_2c3fefb64d14','','6721ed9c_9093_45cc_b02b_f9fa27d02028'),
    ('85b62250_b00c_4c0c_b048_5725c847eae1',1,'None','','6719b3c8_851c_4a17_8f20_de1fb7119450','','ba02ce60_94cc_4b2c_b379_f0052d770133'),
    ('b06517a1_cd98_4ea8_aaf6_c28fe8259ddd',1,'None','','0951c888_9e95_4109_9204_0fdb0d009d07','','66b664ea_5dbd_4b1e_aeea_1934bb960ab3'),
    ('3923c4cb_498b_4bc4_9e68_083908e485a0',1,'None','','13a5d601_3f85_44d4_9413_751b833cec1f','','38e7098c_3e8f_4f57_8f5f_1ede482a132f'),
    ('96aff122_9b22_48a6_b685_30983708f6c4',1,'None','','bfa6398a_ac1a_4b18_8151_c36060fe9f7d','','c8c4c20a_87a5_4e3b_b7cc_c2967cd25c60'),
    ('2e837618_ab9e_4f0a_b7c9_da4720fdaba1',1,'None','','f0bc557c_9352_4180_9f09_2a93898fba98','','9339e14e_e13f_4f86_a182_536ec478353d'),
    ('7f2e6708_a92a_4f08_8caa_6414ea20fcdb',1,'None','','079f57f9_16e0_4d6c_a71e_f9328117e1ef','','d42fc73f_10cd_469f_a846_d5f8684e7d7f'),
    ('c80e2f28_d904_4aef_9dce_5c1c220670b8',1,'None','','8f9518ec_cc2a_41b4_a73d_1487897ee97f','','383ff8e2_b293_43be_b958_9db5a86b6084');
INSERT INTO EdxTrackEvent (_id,event_id,agent,event_source,event_type,ip,page,session,time,anon_screen_name,downtime_for,student_id,instructor_id,course_id,sequence_id,goto_from,goto_dest,problem_id,problem_choice,question_location,submission_id,attempts,long_answer,student_file,can_upload_file,feedback,feedback_response_selected,transcript_id,transcript_code,rubric_selection,rubric_category,video_id,video_code,video_current_time,video_speed,video_old_time,video_new_time,video_seek_type,video_new_speed,video_old_speed,book_interaction_type,success,answer_id,hint,hintmode,correctness,msg,npoints,queuestate,orig_score,new_score,orig_total,new_total,event_name,group_user,group_action,position,badly_formatted,correctMap_fk,answer_fk,state_fk,load_info_fk) VALUES 
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_16_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','8f0b0d9d_26ea_4ce7_8b71_d55a337c50ed','c7f9c7a8_0e46_47bd_961a_e5fbc8c8e6c5','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_3_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','99a29095_fd42_4a53_9767_75847f8d5ba5','92d46c39_7e72_4ba0_8746_299a0d5cf110','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_12_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','2c68623d_3422_4fda_89c5_f527010e385f','ec6c3d4b_144a_4d4c_9197_1041c1525bb0','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_6_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','0995d975_8945_49a8_a2ee_48bddde630fc','83239258_56e5_48da_93bb_b1d5f348175c','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_17_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','ebc310dd_020f_4c5b_b503_8228e7814a5f','42738b72_6ddc_4ba1_b4f5_4bf8581e8221','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_2_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','066d5ac1_de0c_4cae_9b4e_9a3c1a03e679','44649c25_8387_4781_9b63_06f9a033c618','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_9_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','c3a11fb3_3284_4b07_a2c5_92c70bca8d42','bd196e60_cf1a_4395_ba34_89a19257958f','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_14_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','113f0ab8_9f70_426b_84f0_ba06955146f6','96717429_c1e4_4bfc_9caa_21e31169acc7','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_13_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','203c3d99_4267_489d_9d64_9626490f2fd9','bd8bd895_1a65_4ea7_be6d_f0e6a27e9fc8','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_5_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','f116f143_191e_4ef6_ba0d_8cce633db2a3','8bab2541_86d7_405f_ae5c_1ab790192128','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_10_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','322a2088_a021_47a7_a3c9_bb021aafadcd','602932b2_f1ea_4aa5_b22f_19005091e4ef','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_19_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','0b15f08d_6a09_492c_91ef_4fb48a260175','85b62250_b00c_4c0c_b048_5725c847eae1','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_8_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','7d37b9c3_3781_4442_bae6_622b9115ac52','b06517a1_cd98_4ea8_aaf6_c28fe8259ddd','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_15_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','18e82ebc_68fd_432b_b651_412fb994ccb9','3923c4cb_498b_4bc4_9e68_083908e485a0','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_4_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','2367e91c_eb91_4461_8467_5a89c10f3267','96aff122_9b22_48a6_b685_30983708f6c4','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_11_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','41228e93_1d9c_4e23_83bf_7ce6fa655e4c','2e837618_ab9e_4f0a_b7c9_da4720fdaba1','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_18_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','8ef2ad05_86ae_4791_9e10_07dd34feb1ca','7f2e6708_a92a_4f08_8caa_6414ea20fcdb','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_7_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','1b432532_06d5_4ac9_8249_7ad8c40c5f77','c80e2f28_d904_4aef_9dce_5c1c220670b8','f00190a1_ad31_47a9_b298_e713664401fb'),
    (0,'2ef90b50_4ae0_44aa_a1ee_2ad437121f25','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36','server','save_problem_check','147.32.84.59','x_module','','2013-06-12T09:19:41.439185','','0:00:00','','','Medicine-HRP258','',-1,-1,'i4x-Medicine-HRP258-problem-44c1ef4e92f648b08adbdcd61d64d558_7_1','','','',-1,'','','','',-1,'','',-1,-1,'','','','','','','','','','','incorrect','','','','','',-1,'',-1,-1,-1,-1,'','','',-1,'','','1b432532_06d5_4ac9_8249_7ad8c40c5f77','c80e2f28_d904_4aef_9dce_5c1c220670b8','f00190a1_ad31_47a9_b298_e713664401fb');
COMMIT;
SET foreign_key_checks=1;
SET unique_checks=1;