####**Sql基础练习02**


----------
* 显示所有在部门 20 和 50 中的雇员的名字和部门号，并以名字按字母顺序排序

```
select FIRST_NAME,DEPARTMENT_ID from employees where DEPARTMENT_ID in (20,50) order by 1;
```
![这里写图片描述](http://img.blog.csdn.net/20160927183814104)

* 列出收入在 \$5,000 和 $12,000 之间，并且在部门 20 或 50 工作的雇员的名字和薪水。将列标题分别显示为 Employee 和 Monthly Salary

```
select FIRST_NAME "Employee", SALARY "Monthly Salary" from employees where SALARY  between  5000 and 12000;
```
![这里写图片描述](http://img.blog.csdn.net/20160927183926105)

* 	显示每一个在 2002年受雇的雇员的名字和受雇日期

```
select FIRST_NAME,HIRE_DATE from employees where to_char(HIRE_DATE,'yyyy') = '2002';
```
![这里写图片描述](http://img.blog.csdn.net/20160927184016058)

* 显示所有没有主管经理的雇员的名字和工作岗位

```
select FIRST_NAME,JOB_ID from employees where MANAGER_ID is null;
```
![这里写图片描述](http://img.blog.csdn.net/20160927184059575)

* 	显示所有有佣金的雇员的名字、薪水和佣金。以薪水和佣金的降序排序数据

```
select FIRST_NAME,SALARY,COMMISSION_PCT from employees where COMMISSION_PCT is not null order by 2 desc,3 desc;
```
![这里写图片描述](http://img.blog.csdn.net/20160927184141856)

* 	显示所有名字中第三个字母是 a 的雇员的名字

```
select FIRST_NAME from employees where FIRST_NAME like '__a%';
```
![这里写图片描述](http://img.blog.csdn.net/20160927184216079)

* 显示所有名字中有一个 a 和一个 e 的雇员的名字

```
select FIRST_NAME from employees where FIRST_NAME like '%a%' and  FIRST_NAME like '%e%';
```
![这里写图片描述](http://img.blog.csdn.net/20160927184251221)

* 显示所有工作是销售代表或者普通职员，并且薪水不等于 $2,500、 $3,500 或 $7,000的雇员的名字、工作和薪水。

```
select FIRST_NAME,JOB_TITLE,SALARY from employees,JOBS where JOB_TITLE in  ('Sales Manager','Sales Representative') and SALARY not in (2500,3500,7000) and JOBS.Job_Id=employees.job_id;
-- 销售代表，普通职员 不知道是哪个 
```
![这里写图片描述](http://img.blog.csdn.net/20160927184401139)

* 	写一个查询显示当前日期，列标签显示为 DATE

```
select to_char(sysdate,'yyyymmdd hh24:mi:ss')  "DATE" from dual;
```
![这里写图片描述](http://img.blog.csdn.net/20160927184438520)

* 对每一个雇员，显示 employee number,last_name,salary 和 salary 增加 15%，并且表示成整数，列标签显示为 New Salary

```
select EMPLOYEE_ID,FIRST_NAME, SALARY,SALARY*1.15 as "New Salary" from employees;
```
![这里写图片描述](http://img.blog.csdn.net/20160927184516702)


----------
注：HR方案