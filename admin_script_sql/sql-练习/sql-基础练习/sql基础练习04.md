#### **Sql基础练习04**


----------

* 创建一个在部门 80 中的所有工作岗位的唯一列表，在输出中包括部门的地点

```
select decode(departments.department_id,80,department_name,null),employees.* from employees,departments where departments.DEPARTMENT_ID = employees.department_id;
```
![这里写图片描述](http://img.blog.csdn.net/20160927211914497)

* 显示所有在其 last name 中有一个小写 a 的雇员的 last name 和 department name

```
select last_name,department_name from employees,departments where employees.department_id = departments.department_id and last_name like '%a%';
```
![这里写图片描述](http://img.blog.csdn.net/20160927211948944)

* 	写一个查询显示那些工作在 Toronto 的所有雇员的 last name、 job、 department number 和 department name

```
select last_name,job_id,DEPARTMENTS.department_id,department_name from employees,DEPARTMENTS where DEPARTMENTS.DEPARTMENT_ID = employees.department_id and  LOCATION_ID in(select LOCATION_ID from LOCATIONS where CITY in ('Toronto'));
```
![这里写图片描述](http://img.blog.csdn.net/20160927212024499)

* 显示雇员的 last name 和 employee number 连同他们的经理的 last name 和manager number，列标签为 employee、 emp、 manager 和 mgr

```
select e1.LAST_NAME as "employee",e1.EMPLOYEE_ID as "emp",e2.LAST_NAME as "manager",e2.EMPLOYEE_ID as "mgr" from employees e1,employees e2 where e1.MANAGER_ID = e2.EMPLOYEE_ID(+);
```
![这里写图片描述](http://img.blog.csdn.net/20160927212058812)

* 创建一个查询显示所有与被指定雇员工作在同一部门的雇员的 last names、department numbers。给每列一个适当的标签

```
select e1.LAST_NAME as "employee",e1.department_id as "emp" from employees e1,employees e2 where e1.department_id = e2.department_id and e1.LAST_NAME <> e2.LAST_NAME and e2.LAST_NAME = 'Jones';
```
![这里写图片描述](http://img.blog.csdn.net/20160927212126616)

* 写一个查询显示与 zlotkey 在同一部门的雇员的 last name 和 hire date,结果中不包括 zlotkey

```
select e1.LAST_NAME as "employee",e1.department_id as "emp" from employees e1,employees e2 where e1.department_id = e2.department_id and e1.LAST_NAME <> e2.LAST_NAME and e2.LAST_NAME = 'Zlotkey';
```
![这里写图片描述](http://img.blog.csdn.net/20160927212209501)

* 创建一个查询显示所有薪水高于平均薪水的雇员的雇员号和名字，按薪水的升序排序

```
select employee_id,last_name from employees where SALARY > (select avg(SALARY) from employees) order by SALARY;
```
![这里写图片描述](http://img.blog.csdn.net/20160927212240273)

* 显示所有部门地点号（ department location ID）是 1700 的雇员的 last name、departtment number 和 jobID

```
select last_name,job_id,DEPARTMENT_ID from employees where DEPARTMENT_ID in( select DEPARTMENT_ID from departments where LOCATION_ID = 1700);
```
![这里写图片描述](http://img.blog.csdn.net/20160927212307664)

* 	显示在 Executive 部门的每个雇员的 department number、 last name 和 jobID

```
select last_name , job_id from employees where DEPARTMENT_ID in ( select DEPARTMENT_ID from departments where DEPARTMENT_NAME = 'Executive');
```
![这里写图片描述](http://img.blog.csdn.net/20160927212341941)


----------

注： hr方案