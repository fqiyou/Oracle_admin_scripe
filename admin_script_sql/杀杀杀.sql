--�鿴����ͼƷѿ��Ƿ�����
SELECT A.SID,a.* FROM V$LOCK A WHERE A.BLOCK > 0 AND a.TYPE IN ('TX','DX');

select a.SQL_HASH_VALUE,a.* from gv$session a where a.SID='7197';

select b.SQL_HASH_VALUE, b.BLOCKING_SESSION,b.SID, b.*, a.*
  from gv$session b, gV$LOCK A
 WHERE A.BLOCK > 0
   AND a.TYPE IN ('TX', 'DX')
   and a.SID = b.SID;
   
select t.*
  from dba_hist_active_sess_history t
 where t.sample_time >= to_date('20161111 13:00:00', 'yyyymmdd hh24:mi:ss')
 and t.sample_time < to_date('20161111 14:00:00', 'yyyymmdd hh24:mi:ss')
 and t.event like '%%'
 ;

--���Ч��ִ��Ч�ʵ��µ�SQL
SELECT a.sql_id,a.SQL_HASH_VALUE,COUNT(1) FROM v$session a WHERE a.status = 'ACTIVE'
AND a.SQL_HASH_VALUE <> '0' GROUP BY a.sql_id,a.SQL_HASH_VALUE ORDER BY 2 DESC;


--����kill session���
SELECT 'alter system kill session ''' || A.SID || ',' || A.SERIAL# || ''';',
       A.LOGON_TIME,a.PROGRAM,a.EVENT
  FROM V$SESSION A
 WHERE a.SQL_HASH_VALUE in ('3972025795')
 ORDER BY A.LOGON_TIME;
--����hashvalue�ҵ���Ӧ��sql���
--2003290022
SELECT * FROM v$sqltext a WHERE a.HASH_VALUE = '3972025795'
ORDER BY a.PIECE;
select * from v$sql_plan a where a.SQL_ID='44pp063qc0mf3';
select * from dba_hist_sql_plan a where a.sql_id='44pp063qc0mf3';
--�����Щ������
SELECT b.OBJECT_NAME,c.MACHINE,c.SID,c.SERIAL# 
FROM v$locked_object a,dba_objects b,v$session c
WHERE a.object_id = b.object_id
AND a.session_id = c.sid ;
--����sid�ҵ����ݿ������϶�Ӧ�Ľ��̺�spid
SELECT b.SPID,a.OSUSER,a.PROGRAM FROM v$session a,v$process b
WHERE a.PADDR = b.ADDR AND a.SID = '4284';
--�鿴SQLִ��
select * from v$session_longops a where a.SOFAR<>a.TOTALWORK


