load data
infile 'data.txt'
badfile 'data.bad'
truncate
into table emp
fields terminated by '	'
trailing nullcols
(EMPLOYEE_ID,EMAIL,MANAGER_ID)