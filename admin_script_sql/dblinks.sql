-- Drop existing database link 
drop public database link DB_orcl;
-- Create database link 
create public database link DB_orcl
  connect to SYSTEM
  identified by fqiyou
  using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.131.66.6)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
-- Drop existing database link 
drop public database link DB_CRM1;
-- Create database link 
create public database link DB_CRM1
  connect to SYSTEM
  identified by fqiyou
  using 'dbcrm1';

select * from v$session@db_orcl;
select * from v$session@dbcrm1;
