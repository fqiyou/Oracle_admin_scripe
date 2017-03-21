CREATE TABLE scott.TEST_UNUSED_COLUMNS
(
TEST_1 VARCHAR2(2),
TEST_2 VARCHAR2(2),
TEST_3 VARCHAR2(2),
TEST_4 VARCHAR2(2),
TEST_5 VARCHAR2(2)
);
select * from scott.TEST_UNUSED_COLUMNS;
INSERT INTO scott.TEST_UNUSED_COLUMNS VALUES('A1','A2','A3','A4','A5');
INSERT INTO scott.TEST_UNUSED_COLUMNS VALUES('B1','B2','B3','B4','B5');
select * from scott.TEST_UNUSED_COLUMNS;
alter table scott.test_unused_columns set unused column test_5;
select * from sys.obj$ where name ='TEST_UNUSED_COLUMNS';
select * from sys.col$ where obj#='74427';

update sys.col$ c set c.col#=c.intcol# where c.obj#='74427';
update sys.tab$ c set c.cols=cols+1 where c.obj#='74427';
update sys.col$ c set c.name='TEST_5' where c.obj#='74427' and c.col#=5;
update sys.col$ c set c.property=0 where c.obj#='74427';
commit;
-- ÷ÿ∆Ùdb
