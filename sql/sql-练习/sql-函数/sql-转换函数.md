#### **Sql转换函数**


----------
 * 字符串转换为rowid：
```
SELECT last_name, job_id, salary AS Sal FROM employees;
```
执行成功：
![T1](http://img.blog.csdn.net/20160927155119613)

 *  在下面的语句中有 4 个编码错误，请找出它们
 

```
SELECT employee_id, last_name sal x 12 ANNUAL SALARY FROM employees;
```
改正为：

```
SELECT employee_id, last_name, (salary * 12) "ANNUAL SALARY" FROM employees;
```
![T2](http://img.blog.csdn.net/20160927155834689)

*  显示DEPARTMENTS表的结构。选择表中的所有数据

```
desc departments;
select * from departments;
```
![T3](http://img.blog.csdn.net/20160927160133190)

* 显示 EMPLOYEES 表的结构。创建一个查询，显示每个雇员的 last name, job, code,hire date, employee. employee 显示在第一列， 给 HIRE_DATE 列指定一个别名STARTDATE .

```
desc employees;
select employee_id,last_name,job_id,hire_date startdate from employees;
```
![T4](http://img.blog.csdn.net/20160927160453864)

* 创建一个查询从 EMPLOYEES 表中显示唯一的工作代码

```
select distinct job_id from employees;
```
![T5](http://img.blog.csdn.net/20160927160757135)

*   创建一个查询，显示收入超过 $12,000 的雇员的名字和薪水

```
 select first_name,salary from employees where salary > 12000;
```
![T6](http://img.blog.csdn.net/20160927160944857)

*   将 SQL 语句存到文件中，运行该查询

```
--C:\Users\Y\Documents\T_7.sql
select to_char(sysdate,'yyyymmdd hh24:mi:ss') from dual;
```
![T7](http://img.blog.csdn.net/20160927161435489)

* 创建一个查询，显示雇员号为 176 的雇员的名字和部门号

```
select FIRST_NAME, DEPARTMENT_ID from employees where employee_id = 176;
```
![T8](http://img.blog.csdn.net/20160927161656620)

*   修改 T_9.sql文件，显示所有薪水不在 5000 和 12000 之间的雇员的名字和薪水。将 SQL 语句存到文件 T_9.sql 中

```
-- C:\Users\Y\Documents\T_9.sql
 select FIRST_NAME, SALARY from employees where SALARY not between  5000 and 12000;
```
![T9](http://img.blog.csdn.net/20160927162311872)

*   显示受雇日期在 2002年 2 月 1 日 和 2003 年 5 月 1 日之间的雇员的名字、岗位和受雇日期，按受雇日期顺序排序查询结果

```
select FIRST_NAME,JOB_ID,HIRE_DATE from employees where HIRE_DATE between  to_date('20020201','yyyymmdd') and to_date('20030501','yyyymmdd') order by 3;
```
![T10](http://img.blog.csdn.net/20160927163145090)


----------
注：HR方案