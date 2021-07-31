use employees;
select * from employees;
select * from dept_emp;
select * from departments;
select * from dept_manager;
select * from salaries;
select * from titles;

# Find the average salaries of all the departments

SELECT 
    d.dept_no, d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        INNER JOIN
    dept_emp de
        INNER JOIN
    salaries s ON s.emp_no = de.emp_no
        AND d.dept_no = de.dept_no
GROUP BY de.dept_no , d.dept_name;

# Find the maximum salaries of all the departments
SELECT 
    d.dept_no, d.dept_name, AVG(s.salary) AS average_salary, MAX(s.salary) AS max_salary
FROM
    departments d
        INNER JOIN
    dept_emp de
        INNER JOIN
    salaries s ON s.emp_no = de.emp_no
        AND d.dept_no = de.dept_no
GROUP BY de.dept_no , d.dept_name;

# Find the second highest salaries of all the departments

SELECT 
    d.dept_no,
    d.dept_name,
    AVG(s.salary) AS average_salary,
    MAX(s.salary) AS max_salary,
    (SELECT 
            max(s.salary)
        FROM
            salaries s) as second_highest
FROM
    departments d
        INNER JOIN
    dept_emp de
        INNER JOIN
    salaries s ON s.emp_no = de.emp_no
        AND d.dept_no = de.dept_no
GROUP BY de.dept_no , d.dept_name;

# Find the count of each title in every department.

SELECT 
    d.dept_no, d.dept_name, t.title, COUNT(t.title)
FROM
    titles t
        INNER JOIN
    dept_emp de
        INNER JOIN
    departments d ON t.emp_no = de.emp_no
        AND de.dept_no = d.dept_no
GROUP BY t.title , de.dept_no;

# Order of query formation
# Select
# where #cannot have aggregate functions
# group by
# having # can have aggregate functions
# order by
# limit

# Display the employee names that appears less than 250 times 

SELECT 
    first_name, COUNT(first_name) AS count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) < 250
ORDER BY first_name ASC;

# select all the employees having an average salary > 100000

SELECT 
    e.first_name, ROUND(AVG(s.salary), 2) AS avg_salary
FROM
    employees e
        INNER JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no
HAVING AVG(s.salary) > 100000
ORDER BY AVG(s.salary);

# aggregate and non aggregate functions cannot be together in the having clause

#Select the employee numbers of all individuals 
#who have signed more than 1 contract after the 1st of January 2000.

SELECT 
    e.first_name, COUNT(de.emp_no) AS contracts
FROM
    employees e
        INNER JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no;

# cross join of emp and dept emp
# can be implemented by using inner join without the on clause

SELECT 
    *
FROM
    departments
        CROSS JOIN
    dept_emp;
    
SELECT 
    *
FROM
    departments
        INNER JOIN
    dept_emp;
    
# find the average salaries for the departments
use employees;
SELECT 
    d.dept_no,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS average_salary
FROM
    departments d
        INNER JOIN
    dept_emp de
        INNER JOIN
    salaries s ON d.dept_no = de.dept_no
        AND s.emp_no = de.emp_no
GROUP BY de.dept_no
having average_salary < 60000;

# Select the employee numbers of all 
# individuals who have signed more than 1 contract 
# after the 1st of January 2000.

#Using where
SELECT 
    e.emp_no, e.first_name, COUNT(de.emp_no) AS contracts_signed
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    de.from_date > '2000-01-01'
GROUP BY de.emp_no
having contracts_signed > 1
ORDER BY contracts_signed DESC;



# Conditions for aggregate functions can be included in the having clause.
# Do not pair aggregate and non aggregate functions in the having clause.
# Aggregate functions cannot be used in the where clause.

# joins

# inner join is the default join

# Retrieve a list with all female employees whose first name is Kellie
use employees;
select * from employees where first_name = 'Kellie' and gender = 'F';

# Retrieve a list with all employees whose first name is either Kellie or Aruna.

select * from employees where first_name =  'Kellie' or first_name =  'Aruna';

# Retrieve a list with all female employees whose first name is either Kellie or Aruna.

select * from employees where gender = 'F' and (first_name = 'Kellie' or first_name = 'Aruna');

# Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.

select * from employees where first_name in ('Denis','Elvis');

# Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.

select * from employees where first_name not in ('John','Mark','Jacob');

# Like and not Like operator

# Working with the “employees” table, use the LIKE operator to select the data about all individuals, whose first name 
# starts with “Mark”; specify that the name can be succeeded by any sequence of characters.

select * from employees where first_name like 'Mark%';

# Retrieve a list with all employees who have been hired in the year 2000.

select * from employees where hire_date like '2000%';

# Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 

select * from employees where emp_no like '1000%';

# between and operators

# Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.

select * from salaries where salary between 66000 and 70000;

# Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.

select * from employees where emp_no not between 10004 and 10012;

# Select the names of all departments with numbers between ‘d003’ and ‘d006’.

select * from departments where dept_no between 'd003' and 'd006';

# Retrieve a list with data about all female employees who were hired in the year 2000 or after.

select * from employees where gender = 'F' and hire_date > '2000-01-01';

# distinct keyword

# Obtain a list with all different “hire dates” from the “employees” table.

select distinct (hire_date) from employees;

# How many male and how many female managers do we have in the ‘employees’ database?

SELECT 
    e.gender, COUNT(e.gender)
FROM
    employees e
        INNER JOIN
    dept_manager de ON e.emp_no = de.emp_no
GROUP BY gender;

# Union and Union all



# Stored Routine

# Functions
# Can be used in a select statement as it returns a single value
# A Function has to return something, therefore DML operations cannot be performed using a function
SET GLOBAL log_bin_trust_function_creators = 1;

delimiter $$
create function avg_dept_salary(dept_no int) returns decimal(8,2) 
begin
declare average_salary decimal(8,2);
SELECT 
    AVG(s.salary)
INTO average_salary FROM
    dept_emp de
        INNER JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    de.dept_no = dept_no
GROUP BY de.dept_no; 
return average_salary;
end$$
delimiter ;


#Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee.

delimiter $$
create function emp_info(fname varchar(255), lname varchar(255)) returns  decimal(8,2)
begin
declare salary decimal(8,2);
SELECT 
    MAX(s.salary)
INTO salary FROM
    salaries s
        INNER JOIN
    employee e ON s.emp_no = e.emp_no
WHERE
    e.first_name = fname
        AND e.last_name = lname
GROUP BY s.emp_no having max(from_date);
return salary;
end $$
delimiter ;
# Chirstian Koblick
# #ERROR : Error Code: 1418. This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
#SOLVED USING BELOW AND FUNCTION SUCCESSFULLY CREATED

SET GLOBAL log_bin_trust_function_creators = 1;



# Stored Procedures
# Can have multiple in and out parameters
# Cannot be used in a select statement

delimiter $$
create procedure hire_date(in employee_no integer)
begin
select hire_date from employees where emp_no = employee_no;
end$$
delimiter ;

call hire_date(10005)

#Create a procedure that will provide the average salary of all employees.

delimiter $$
create procedure avg_salaries()
begin
select emp_no,avg(salary) as average_salary from salaries group by emp_no;
end$$
delimiter ;

#Create a procedure called ‘emp_info’ that uses as parameters the 
# first and the last name of an individual, and returns their employee number.
drop procedure emp_info;
delimiter $$

create procedure emp_info(in first_name varchar(255), in last_name varchar(255),out employee_no integer)
begin
select emp_no into employee_no from employees where first_name = first_name and last_name = last_name;
end$$
delimiter ;

# Using Case

SELECT 
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
# obtain a result set containing the employee number, first name, and last name of all 
# employees with a number higher than 109990. Create a fourth column in the query, indicating 
# whether this employee is also a manager, 
# according to the data provided in the dept_manager table, or a regular employee. 


SELECT 
    emp_no,
    CASE
        WHEN
            emp_no IN (SELECT 
                    emp_no
                FROM
                    dept_manager)
        THEN
            'manager'
        ELSE 'regular employee'
    END AS employee_type
FROM
    employees
WHERE
    emp_no > 109990;
 
#Extract a dataset containing the following information about the managers: 
# employee number, first name, and last name. Add two columns at the end – 
# one showing the difference between the maximum and minimum salary of that employee, 
# and another one saying whether this salary raise was higher than $30,000 or NOT.

SELECT 
    d.emp_no,
    e.first_name,
    e.last_name,
    (MAX(salary) - MIN(salary)) AS raise,
    CASE
        WHEN (MAX(salary) - MIN(salary)) > 30000 THEN 'higher than 30k'
        ELSE 'lower than 30k'
    END AS raise_info
FROM
    dept_manager d
        INNER JOIN
    employees e
        INNER JOIN
    salaries s ON d.emp_no = e.emp_no
        AND e.emp_no = s.emp_no
GROUP BY s.emp_no;

# Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column,
# called “current_employee” saying “Is still employed” if the employee is
# still working in the company, or “Not an employee anymore” if they aren’t.
use employees;
SELECT 
    e.emp_no,
    first_name,
    last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        INNER JOIN
    dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100;

# Create procedure and function that take first name and last name as input and gives the emp no as the output

delimiter $$
create procedure emp_info1(in fname varchar(255), in lname varchar(255), out empno integer)
begin
select emp_no into empno from employees where first_name = fname and last_name = lname;
end $$
delimiter ;

delimiter $$ 
create function emp_info1(fname varchar(255), lname varchar(255)) returns integer
begin
declare empno integer;
SELECT 
    emp_no
INTO empno FROM
    employees
WHERE
    first_name = fname AND last_name = lname;
return empno;
end $$
delimiter ;

SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, dm.dept_no
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;

# Left Join

# Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees
# whose last name is Markovitch. See if the output contains a manager with that name.  

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    CASE
        WHEN
            e.emp_no IN (SELECT 
                    emp_no
                FROM
                    dept_manager)
        THEN
            'manager'
        ELSE 'employee'
    END AS employee_type
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    last_name = 'Markovitch';

