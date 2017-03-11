/*
��Oracle�ķ�������ɾ���ظ�����
����:����temp1.employees����ʱ�����˴������в����б����������顣
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
