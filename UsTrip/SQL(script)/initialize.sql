////////////////////// createTable //////////////////////////////////////////
CREATE TABLE users (
	user_id			VARCHAR2(30)	NOT NULL,
	nickname		VARCHAR2(20)	NOT NULL,
	passwd			VARCHAR2(20)	NOT NULL,
	birth_date		DATE,
	profile_img		VARCHAR2(40),	
	gender			VARCHAR2(1)		NOT NULL,
	role				NUMBER(1)		DEFAULT '1',
	is_delete			NUMBER(1)		DEFAULT	'1',
PRIMARY KEY(user_id),
UNIQUE(nickname),
UNIQUE(profile_img)
);

CREATE TABLE message (
	msg_no			NUMBER 			NOT NULL,
	sender			VARCHAR2(30) 	NOT NULL REFERENCES users(user_id),
	receiver			VARCHAR2(30)	NOT NULL REFERENCES users(user_id),
	send_date		DATE,
	read_date		DATE,
	msg_content	VARCHAR2(1000),
	is_read			NUMBER(1)		DEFAULT 0,
	receive_del		NUMBER(1)		DEFAULT 0,
	send_del		NUMBER(1)		DEFAULT 0,
PRIMARY KEY(msg_no)
);

CREATE TABLE follow (
	follow_no		NUMBER			NOT NULL,
	fol_user_id		VARCHAR2(30) 	NOT NULL REFERENCES users(user_id),
	target_user_id	VARCHAR2(30)	NOT NULL REFERENCES users(user_id),
	is_following	NUMBER			default 0,
PRIMARY KEY(follow_no)
);

CREATE TABLE travel (					
	trav_no					NUMBER			NOT NULL,		
	USER_ID	       			VARCHAR2(50)	NOT NULL REFERENCES users(user_id),			
	TRAV_TITLE				VARCHAR2(50)	NOT NULL,	
	TRAV_THEME			VARCHAR2(50)	NOT NULL,		
	MEMBER_COUNT	NUMBER	        NOT NULL,		
	START_DATE			DATE	        		NOT NULL,		
	TOTAL_DATE			NUMBER	        NOT NULL,		
	IS_BLOG_START		NUMBER	        DEFAULT '0',		
	THUMB_NAIL			VARCHAR2(50),
	DELETE_FLAG			NUMBER			DEFAULT'0',		
PRIMARY KEY(trav_no),					
UNIQUE(THUMB_NAIL)					
);					

CREATE TABLE city (			
	CITY_NO				NUMBER			NOT NULL,
	trav_no				NUMBER 			REFERENCES travel(trav_no)NOT NULL,	
	CITY_ID				VARCHAR2(50)	NOT NULL,
	PRE_CITY_NO		NUMBER,	
	NEXT_CITY_NO	NUMBER,	
	CITY					VARCHAR2(50)	NOT NULL,
	CITY_X				NUMBER			NOT NULL,
	CITY_Y				NUMBER	       	NOT NULL,
	STAY_DATE			NUMBER	       	NOT NULL,
	STAY_START		DATE	       			NOT NULL,
	STAY_END			DATE	       	 		NOT NULL,
PRIMARY KEY(CITY_NO)					
);			

CREATE TABLE place (				
	PLACE_NO			NUMBER			NOT NULL,	
	CITY_NO				NUMBER 			REFERENCES city(city_no)NOT NULL,	
	trav_no				NUMBER 			REFERENCES travel(trav_no)NOT NULL,	
	PLACE_ID			VARCHAR2(50)	NOT NULL,
	PRE_PLACE_NO	NUMBER,		
	NEXT_PLACE_NO	NUMBER,		
	PLACE				VARCHAR2(50)	NOT NULL,
	PLACE_X				NUMBER	        NOT NULL,
	PLACE_Y				NUMBER	       	NOT NULL,
	VISIT_DATE			DATE        			NOT NULL,	
	MEMO				VARCHAR2(100),		
PRIMARY KEY(PLACE_NO)				
);		

CREATE TABLE blog (
blog_no		NUMBER 		NOT NULL,
trav_no		NUMBER 		NOT NULL REFERENCES travel(trav_no),
city_no		NUMBER 		NOT NULL REFERENCES city(city_no),
place_no	NUMBER 		NOT NULL REFERENCES place(place_no),
review		VARCHAR2(500),
score			NUMBER,
memo		VARCHAR2(200),
place			VARCHAR2(200),
visit_date	DATE,
delete_flag	NUMBER		DEFAULT '0',
PRIMARY KEY (blog_no)
);

CREATE TABLE like_travel (
like_no		NUMBER 			NOT NULL,
trav_no 		NUMBER 			NOT NULL REFERENCES travel(trav_no),
user_id 		VARCHAR2(200)	NULL REFERENCES users(user_id),
PRIMARY KEY (like_no)
);

CREATE TABLE image (
image_no 				NUMBER 			NOT NULL,
blog_no 				NUMBER 			NOT NULL REFERENCES blog(blog_no),
ori_img_name 			VARCHAR2(200)  NOT NULL,
server_img_name 	VARCHAR2(200)  NOT NULL,
trav_no					NUMBER 			NOT NULL REFERENCES travel(trav_no),
PRIMARY KEY (image_no)
);

CREATE TABLE hash_tag (
tag_no		NUMBER			NOT NULL,
blog_no		NUMBER 			NOT NULL REFERENCES blog(blog_no),
hash_tag	VARCHAR2(500)	NOT NULL,
PRIMARY KEY (tag_no) 
);

CREATE TABLE BOARD (
	BOARD_NO			NUMBER 				NOT NULL,
	NICKNAME				VARCHAR2(200) 		REFERENCES USERS(NICKNAME),
	TRAV_NO				NUMBER				REFERENCES TRAVEL(TRAV_NO),
	HITS						NUMBER 				DEFAULT '0',
	BOARD_CONTENT	VARCHAR2(4000)		NOT NULL,
	BOARD_TITLE			VARCHAR2(200)		NOT NULL,
	REG_DATE				DATE,
	BOARD_CATEGORY	NUMBER				DEFAULT '0',
	DELETE_FLAG			NUMBER				DEFAULT '0',
PRIMARY KEY(BOARD_NO)
);

CREATE TABLE BOARD_COMMENT (
	COMMENT_NO			NUMBER 			NOT NULL,
	BOARD_NO				NUMBER	 		REFERENCES BOARD(BOARD_NO),
	NICKNAME					VARCHAR2(200)	REFERENCES USERS(NICKNAME),
	PRIVATE_COMMENT	NUMBER 			DEFAULT '0',
	REG_DATE					DATE,
	COMMENT_CONTENT	VARCHAR2(400) 	NOT NULL,
PRIMARY KEY(COMMENT_NO)
);

CREATE TABLE ASSET (
	ASSET_NO				NUMBER 			NOT NULL,
	TRAV_NO				NUMBER			REFERENCES TRAVEL(TRAV_NO),
	BLOG_NO				NUMBER	 		REFERENCES BLOG(BLOG_NO),
	VISIT_DATE				DATE,
	REG_DATE				DATE,
	ASSET_CATEGORY	VARCHAR2(30) 	NOT NULL,
	USAGE					VARCHAR2(200),
	CHARGE					NUMBER 			NOT NULL,
PRIMARY KEY(ASSET_NO)
);


////////////////////// sequence ���� //////////////////////////////////////////
CREATE SEQUENCE seq_trav_no				INCREMENT BY 1 START WITH 1 maxvalue 10000;
CREATE SEQUENCE seq_city_no 				INCREMENT BY 1 START WITH 10001 maxvalue 20000;
CREATE SEQUENCE seq_place_no 				INCREMENT BY 1 START WITH 20001 maxvalue 30000;
CREATE SEQUENCE seq_blog_no				INCREMENT BY 1 START WITH 30001 maxvalue 40000;
CREATE SEQUENCE seq_like_no 				INCREMENT BY 1 START WITH 40001 maxvalue 50000;
CREATE SEQUENCE seq_image_no 			INCREMENT BY 1 START WITH 50001 maxvalue 60000;
CREATE SEQUENCE seq_ASSET_NO 			INCREMENT BY 1 START WITH 60001 maxvalue 70000;
CREATE SEQUENCE seq_BOARD_NO 			INCREMENT BY 1 START WITH 70001 maxvalue 80000;
CREATE SEQUENCE seq_COMMENT_NO 	INCREMENT BY 1 START WITH 80001 maxvalue 85000;
CREATE SEQUENCE seq_msg_no 				INCREMENT BY 1 START WITH 85001 maxvalue 90000;
CREATE SEQUENCE seq_follow_no 			INCREMENT BY 1 START WITH 90001 maxvalue 95000;
CREATE SEQUENCE seq_tag_no 				INCREMENT BY 1 START WITH 95001 maxvalue 99999;


////////////////////// �ӽõ����� //////////////////////////////////////////
INSERT INTO users VALUES ( 'eun090878@naver.com', 'eun00', 'dmstjs0000', to_date('1990/04/04', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'champshin@naver.com', 'champshin', 'champshin0', to_date('1992/01/12', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'brianwoo@hanmail.net', 'brianwoo', 'brianwoo0', to_date('1985/07/25', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'peterchoi@gmail.com', 'peterchoi', 'peterchoi0', to_date('1989/10/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'misssong@gmail.com', 'missong', 'missong0', to_date('1979/07/17', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'youBailey@naver.com', 'youBailey30', 'youBailey0', to_date('1992/05/27', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'leedorothy@hanmail.net', 'dorothy88', 'leedorothy0', to_date('1988/01/28', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'fideliobae@naver.com', 'fideliobae', 'fideliobae0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'rrrrrrrina@naver.com', 'rrrrrrrina', 'rrrrrrrina0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'mmelina@naver.com', 'mmelina', 'mmelina0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'philalo@naver.com', 'philalo', 'philalo0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'serenajang@naver.com', 'serenajang', 'serenajang0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'rabiaaaaa@naver.com', 'rabiaaaaa', 'rabiaaaaa0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'olive@naver.com', 'olive', 'olive0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'naarcisse@naver.com', 'naarcisse', 'olive0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'alexalex@nate.com', 'alexalex', 'alexalex0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'bbbbbessie@naver.com', 'bbbbbessie', 'bbbbbessie0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'bonnnnita@hanmail.net', 'bonnnnita', 'bonnnnita0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'camelliahill@nate.com', 'camelliahill', 'camelliahill0', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'caroline05@gmail.com', 'caroline05', 'caroline050', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'connie032@gmail.com', 'connie032', 'connie0320', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'emily367@nate.com', 'emily367', 'emily3670', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'isadora85@naver.com', 'isadora85', 'isadora850', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'jericho429@naver.com', 'jericho429', 'jericho4290', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'johanna37@gmail.com', 'johanna37', 'johanna370', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'kelsey108@nate.com', 'kelsey108', 'kelsey1080', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'lowell792@nate.com', 'lowell792', 'lowell7920', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'marcia508@naver.com', 'marcia508', 'marcia5080', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);
INSERT INTO users VALUES ( 'minnie73@naver.com', 'minnie73', 'minnie730', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'm', 1, 1);
INSERT INTO users VALUES ( 'phyllis154@hanmail.net', 'phyllis154', 'phyllis1540', to_date('1980/03/05', 'yyyy/mm/dd'), NULL, 'f', 1, 1);

INSERT INTO message VALUES ( seq_msg_no.nextval, 'eun090878@naver.com', 'olive@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'eun090878@naver.com', 'fideliobae@naver.com', SYSDATE, null, '�츮 ģ���ؿ�!', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'youBailey@naver.com', 'eun090878@naver.com', SYSDATE, null, '���� �����ҷ���? ', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'youBailey@naver.com', 'olive@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'champshin@naver.com', 'eun090878@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'mmelina@naver.com', 'eun090878@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'philalo@naver.com', 'eun090878@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'philalo@naver.com', 'olive@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'phyllis154@hanmail.net', 'philalo@naver.com', SYSDATE, null, '�ȳ�?', 0, 0, 0 );
INSERT INTO message VALUES ( seq_msg_no.nextval, 'eun090878@naver.com', 'phyllis154@hanmail.net', SYSDATE, null, '�ȳ�?', 0, 0, 0 );

INSERT INTO follow VALUES ( seq_follow_no.nextval,  'eun090878@naver.com', 'olive@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'alexalex@nate.com', 'olive@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'phyllis154@hanmail.net', 'alexalex@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'olive@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'alexalex@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'lowell792@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'lowell792@nate.com', 'olive@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'lowell792@nate.com', 'emily367@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'phyllis154@hanmail.net', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'marcia508@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'isadora85@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'bonnnnita@hanmail.net', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'bbbbbessie@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'jericho429@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'jericho429@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'minnie73@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'alexalex@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'eun090878@naver.com', 'emily367@nate.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'emily367@nate.com', 'eun090878@naver.com', 1 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'eun090878@naver.com', 'naarcisse@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'alexalex@nate.com', 'rabiaaaaa@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'phyllis154@hanmail.net', 'serenajang@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'philalo@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'mmelina@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'minnie73@naver.com', 'rrrrrrrina@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'lowell792@nate.com', 'fideliobae@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'lowell792@nate.com', 'leedorothy@hanmail.net', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'lowell792@nate.com', 'youBailey@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'peterchoi@gmail.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'misssong@gmail.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'johanna37@gmail.com', 'brianwoo@hanmail.net', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'bonnnnita@hanmail.net', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'champshin@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'isadora85@naver.com', 'naarcisse@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'rabiaaaaa@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'serenajang@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'bbbbbessie@naver.com', 'mmelina@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'eun090878@naver.com', 'fideliobae@naver.com', 0 );
INSERT INTO follow VALUES ( seq_follow_no.nextval,  'emily367@nate.com', 'misssong@gmail.com', 0 );