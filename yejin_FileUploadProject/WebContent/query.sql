create table "BOARD" (
"POST_NUMBER" number primary key,
"AUTHOR" varchar2(20),
"PWD" varchar2(20),
"CONTENT" varchar2(200),
"FILE" varchar(200)
);

create sequence "SEQ_BOARD" start with 1 increment by 1 nomaxvalue nocache nocycle;
