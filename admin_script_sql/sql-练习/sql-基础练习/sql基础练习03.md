####　**Sql基础练习03**


----------

 * 写一个查询用首写字母大写，其它字母小写显示雇员的 last name, 显示名字的长度，对所有名字开始字母是 J、 A 或 M 的雇员，给每列一个适当的标签，用雇员的 last name排序结果

```
select NLS_INITCAP(LAST_NAME),length(LAST_NAME),decode(substr(LAST_NAME,0,1),'A','A','M','M','0') from employees order by 1;
```
![这里写图片描述](http://img.blog.csdn.net/20160927201911868)


*	对每一个雇员，显示其 last name, 并计算从雇员受雇日期到今天的月数，列标签MONTHS＿WORKED，按受雇月数排序结果，四舍五入月数到最靠近的整数月

```
select LAST_NAME,round(months_between(sysdate,HIRE_DATE)) as "MONTHS＿WORKED" from employees;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202029886)

 * 创建一个查询显示所有雇员的 last name 和 salary.格式化为 15 个字符长度，用$左填充，列标签 SALARY
 

```
select LAST_NAME, lpad(salary,15,'$') as "SALARY" from employees;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202140402)

* 	显示每一个雇员的 last name, hire date 和雇员开始工作的周日，列标签 DAY，用星期一作为周的起始日排序结果

```
select LAST_NAME, decode(to_number(to_char(HIRE_DATE,'D')) -1,0,7,to_number(to_char(HIRE_DATE,'D')) - 1) as "WORKE" from employees order by 2;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202233810)


* 创建一个查询显示雇员的 last names 和 commission(佣金)比率。如果雇员没有佣金显示“No Commission”列标签 COMM

```
select LAST_NAME,nvl2(COMMISSION_PCT,to_char(COMMISSION_PCT),'No Commission') as "COMM" from employees ;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202320359)

* 显示所有雇员的最高、最低、合计和平均薪水，列标签分别为： maximum、 minmum、 sum、average。四舍五入结果为最近的整数average。四舍五入结果为最近的整数

```
select max(salary) as "MAX", min(salary) as "MIN",sum(salary) as "SUM",round(avg(salary)) as "AVERAGE" from employees ;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202358324)

* 对上面的问题显示每种工作类型的最低、最高、合计、平均薪水

```
select job_id,max(salary) as "MAX", min(salary) as "MIN",sum(salary) as "SUM",round(avg(salary)) as "AVERAGE" from employees group by job_id;
```
![这里写图片描述](http://img.blog.csdn.net/20160927202440579)

* 	显示每一个工作岗位的人数

```
select JOB_ID,count(EMPLOYEE_ID) from  employees group by JOB_ID ;
```
![这里写图片描述](http://img.blog.csdn.net/20160927203429797)

* 	显示经理人数

```
select count(EMPLOYEE_ID) from  employees where JOB_ID like '%MAN' ;
```
![这里写图片描述](http://img.blog.csdn.net/20160927203503563)

* 	最高与最低薪水之间的差

```
select max(salary)- min(salary) as "MAX - MIN" from employees;
```
![这里写图片描述](http://img.blog.csdn.net/20160927203533611)

* 查询显示每个部门的名字、地点、人数和部门中所有雇员的平均薪水。四舍五入薪水到两位小数

```
select departments.department_name,STREET_ADDRESS,round(avg(salary),2) as "avg",count(employees.department_id) from employees,departments,locations where locations.location_id = departments.location_id and employees.department_id =departments.department_id group by employees.department_id ,DEPARTMENT_NAME,STREET_ADDRESS;
```
![这里写图片描述](http://img.blog.csdn.net/20160927203627736)

* 写一个查询显示所有雇员的 last name, department number and department name

```
select last_name,departments.department_id,department_name from employees,departments where  employees.department_id = departments.department_id;
```
![这里写图片描述](http://img.blog.csdn.net/20160927203706331)


----------
注：hr方案