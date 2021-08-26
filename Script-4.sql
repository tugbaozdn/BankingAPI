
--OnetoMany One location can have many departmants.
drop table location;
create table dlocation(
location_id serial primary key,
adress varchar(50),
city varchar(15)
);

drop table department;
create table department(
department_id serial primary key,
department_name varchar(20),
--many to one ->should be foreignkey
location_id int references dlocation(location_id)
);

drop table employee;
create table employee(
employee_id  serial primary key,
first_name varchar(20),
last_name varchar(20),
email varchar(30),
phone varchar(20),
hireDate date,
department_id int references department(department_id),
job_id int references job(job_id)
);

drop table job;
create table job(
job_id serial primary key,
jobtitle varchar(20),
min_salary numeric,
max_salary numeric
--onetoMany job-employee
);


drop table privilege;
create table privilege(
pri_id SERIAL primary key,
name_privilege varchar(20)
--many to many between roles and privilege
);

--join table
--admin can read, write and update
--read privilege can sign to all roles  
drop table roles_privilege;
create table roles_privelege(
role_id int references roles(roles_id), 
privilege_id int references privilege(pri_id)
);

drop table roles;
create table roles(
roles_id serial primary key,
role_name varchar(20)
);

drop table users;
create table users(
user_id serial primary key,
first_name varchar(20),
last_name varchar(20),
user_name varchar(20) unique not null,
email varchar(20),
pass_word varchar(20)
);

--ALTER TABLE table_name 
--ADD COLUMN column_name datatype column_constraint;

alter table users add column role_id int not null;
--ALTER TABLE child_table
--ADD CONSTRAINT constraint_fk
--FOREIGN KEY (fk_columns)
--REFERENCES parent_table(parent_key_columns)
--ON DELETE CASCADE;

alter table users add constraint role_fk foreign key (user_id) references roles(roles_id) on delete cascade;
--BEGIN;
 
--CREATE TABLE uProfiles (
      --  uid int8 PRIMARY KEY,
        --payload jsonb NOT NULL
--);
 
--CREATE TABLE Users (
      --  uid int8 PRIMARY KEY,
       -- uname text NOT NULL,
       -- FOREIGN KEY (uid) REFERENCES uProfiles (uid)
--);
 
--ALTER TABLE uProfiles 
    --ADD FOREIGN KEY (uid) REFERENCES Users (uid);
 
--INSERT INTO Users VALUES (1, 'Pavlo Golub');
 
--INSERT INTO uProfiles VALUES (1, '{}');
 
--COMMIT;
drop table password_reset_token;
create table password_reset_token(
--one to one
reset_id int primary key references users(user_id),
token_pass varchar(60)
--oneto one user
--user_id int references users(user_id);
);



drop table verificationToken;
create table verificationToken(
verify_id int primary key references users(user_id),
token_verify varchar(60),
expiryDate date
);


drop table article;
create table article(
aricle_id serial primary key,
title varchar(250),
publish_date date,
content bytea 
);

insert into article values(default,'SOAP Web Services',current_date,null);

select aricle_id, title, publish_date from article;

insert into employee values(default, 'Tugba','Ozden','tugba@gmail.com','2158739494','2/12/2020');
insert into department values(default,'Software Engineer',1);
insert into department values(default,'Software Engineer',2);
insert into department values(default,'Software Engineer',3);


insert into dlocation values(default, '625 lancaster ave 19099', 'Pittsburgh');
insert into dlocation values(default, 'Balconode dr 19020', 'Newyork');
insert into dlocation values(default, '717 General Booth Blvd VA 23451', 'Virginia');

insert into job values(default,'Java Programmer',45.000,120.000);
insert into job values(default, 'Mulesoft Developer',45.000,150.000);
insert into job values(default, 'Web Developer', 40.000,85.000);

select * from employee  left outer join job on (employee.job_id=job.job_id) where first_name = 'Tugba';
select e.first_name, e.last_name, e.email, e.phone, e.hiredate, j.jobtitle, d.department_name 
from employee e inner join job j  on (e.job_id=j.job_id) inner join department d on (e.department_id=d.department_id) 
where first_name = 'Tugba';
select e.employee_id, e.first_name, e.last_name, e.email, e.phone, e.hiredate, j.jobtitle, d.department_name
				from employee e inner join job j  on (e.job_id=j.job_id) inner join department d on (e.department_id=d.department_id)
				where first_name = 'Tugba';
			
			
select u.first_name, u.last_name, u.role_id  from users u left outer join roles r on (u.role_id=r.roles_id) where u.user_id =2;			
insert into users values(default, 'Tugba','Ozden','tugbaozdn','pass','tugba@gmail.com',1);
			
insert into roles values(1,'Admin');
insert into roles values(2,'User');
insert into roles values(3,'Super_User');

insert into privilege values(1,'READ');
insert into privilege values(2,'WRITE');
insert into privilege values(3,'UPDATE');

select e.employee_id, e.first_name, e.last_name, e.email, e.phone, e.hiredate, j.job_id, d.department_id 
				from employee e inner join job j on (e.job_id=j.job_id) inner join department d on (e.department_id=d.department_id) 
				where employee_id = 4;
			
select u.user_id, u.first_name, u.last_name, u.user_name, u.pass_word,u.email, r.roles_id 
				from users u inner join roles r on (u.role_id=r.roles_id);
	
select aricle_id, title, publish_date from article where title like '?';

--ALTER TABLE table_name 
--RENAME COLUMN column_name TO new_column_name;

alter table roles rename column roles_id to role_id;

ALTER TABLE public.users ADD CONSTRAINT role_fk FOREIGN KEY (role_id) REFERENCES roles(role_id);
			
			


