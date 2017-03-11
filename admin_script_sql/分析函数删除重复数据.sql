/*
用Oracle的分析函数删除重复数据
假设:创建temp1.employees数据时出现了错误其中部分行被输入了两遍。
*/


select c.*, rowid from temp1.employees c;
select ROWID,
       ROW_NUMBER() OVER(PARTITION BY c.employee_id ORDER BY c.employee_id)
  from temp1.employees c;

SELECT ROWID, rn
  FROM (select ROWID,
               ROW_NUMBER() OVER(PARTITION BY c.employee_id ORDER BY c.employee_id) rn
          from temp1.employees c)
 WHERE rn > 1;

DELETE FROM temp1.employees
 WHERE ROWID IN (SELECT ROWID
                   FROM (select ROWID,
                                ROW_NUMBER() OVER(PARTITION BY c.employee_id ORDER BY c.employee_id) rn
                           from temp1.employees c)
                  WHERE rn > 1);
