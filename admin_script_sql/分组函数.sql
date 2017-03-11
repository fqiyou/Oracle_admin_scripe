-- 分组函数
select * from dba_objects;
select c.OWNER ,c.OBJECT_TYPE,c.namespace,sum(1) from dba_objects c group by c.OWNER ,c.OBJECT_TYPE,c.namespace;
select c.OWNER ,c.OBJECT_TYPE,c.namespace,sum(1) from dba_objects c group by grouping sets((c.OWNER ,c.OBJECT_TYPE,c.namespace),(c.OWNER ,c.OBJECT_TYPE),c.OWNER,()) ;
select c.OWNER ,c.OBJECT_TYPE,c.namespace,sum(1) from dba_objects c group by rollup(c.OWNER ,c.OBJECT_TYPE,c.namespace);
select c.OWNER ,c.OBJECT_TYPE,sum(1) from dba_objects c group by cube(c.OWNER ,c.OBJECT_TYPE);
select c.OWNER ,c.OBJECT_TYPE,sum(1) from dba_objects c group by rollup(c.OWNER ,c.OBJECT_TYPE);
select grouping(OWNER),grouping(OBJECT_TYPE),grouping_id(c.OWNER ,c.OBJECT_TYPE),c.OWNER ,c.OBJECT_TYPE,sum(1) from dba_objects c group by rollup(c.OWNER ,c.OBJECT_TYPE);
