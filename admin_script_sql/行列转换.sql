/*
create table temp1.hlzh01 (hl_year varchar2(4),hl_month varchar2(2),hl_amount number);
with temp as
 (select '2016','8',2.6 from dual
   union select '2016','9',2.7 from dual
   union select '2016','10',2.8 from dual
   union select '2016','11',2.9 from dual
   union select '2016','12',2.0 from dual
   union select '2016','1',1.6 from dual
   union select '2017','2',1.8 from dual
   union select '2017','3',1.9 from dual)
 select * from temp;
insert into temp1.hlzh01
with temp as 
 (select '2016','8',2.6 from dual
   union select '2016','9',2.7 from dual
   union select '2016','10',2.8 from dual
   union select '2016','11',2.9 from dual
   union select '2016','12',2.0 from dual
   union select '2016','1',1.6 from dual
   union select '2017','2',1.8 from dual
   union select '2017','3',1.9 from dual)
  select * from temp;
*/
select c.*,rowid from temp1.hlzh01 c;
create table  temp1.hlzh02 as
select c.hl_year,
       sum(case when c.hl_month = 1 then c.hl_amount end) m1,
       sum(case when c.hl_month = 2 then c.hl_amount end) m2,
       sum(case when c.hl_month = 3 then c.hl_amount end) m3,
       sum(case when c.hl_month = 4 then c.hl_amount end) m4,
       sum(case when c.hl_month = 5 then c.hl_amount end) m5,
       sum(case when c.hl_month = 6 then c.hl_amount end) m6,
       sum(case when c.hl_month = 7 then c.hl_amount end) m7,
       sum(case when c.hl_month = 8 then c.hl_amount end) m8,
       sum(case when c.hl_month = 9 then c.hl_amount end) m9,
       sum(case when c.hl_month = 10 then c.hl_amount end) m10,
       sum(case when c.hl_month = 11 then c.hl_amount end) m11,
       sum(case when c.hl_month = 12 then c.hl_amount end) m12
  from temp1.hlzh01 c
 group by c.hl_year;

select * from temp1.hlzh01 c pivot(sum(c.hl_amount) for hl_month in(1 as "m1",2,3,4,5,6,7,8,9,10,11,12));
select * from temp1.hlzh02 c unpivot(hl_amount for hl_month 
in(m1 as '1',m2 as '2',m3 as '3',m4 as '4',m5 as '5',m6 as '6',m7 as '7',m8 as '8',m9 as '9',m10 as '10',m11 as '11',m12 as '12'));
