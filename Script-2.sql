create table roles(
role_id integer primary key,
role_name varchar not null unique
);

drop table account;
create table account(
account_id integer primary key,
balance numeric not null,
status_id integer not null,
type_id integer not null,
user_id integer NOT NULL,
foreign key (status_id) references accountstatus(status_id) on delete cascade,
foreign key (type_id) references accounttype(type_id) on delete CASCADE,
foreign key (user_id) references users(user_id) on delete cascade
);

drop table accountstatus;
create table accountstatus(
status_id integer primary key,
status varchar not null unique
);

drop table accounttype;
create table accounttype(
type_id integer primary key,
account_type varchar not null unique
);
drop table users ;
create table users(
user_id integer primary key,
user_name varchar(20) not null unique,
user_pass varchar(20) not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
user_email varchar(20) not null,
role_id integer not null, 
foreign key (role_id) references roles(role_id) on delete CASCADE
);

Insert into users(user_id, user_name, user_pass, first_name, last_name, user_email, role_id)
values (222222,'mehmetozden','123456','mehmet','ozden','mehmet@gmail','2');

insert into users (user_id, user_name,user_pass,first_name,last_name, user_email, role_id) values (111111, 'tugba_ozden','password','tugba','ozden','tugbaozden@gmail',1);
update roles set role_id=1 where role_name='admin';
insert into roles values (1,'admin');
insert into roles values (2,'employee');
insert into roles values (3,'standard');
insert into account values(22222,5000,1,1);
insert into accountstatus values(1, 'open');
update accountstatus set  status_id=3 where status='closed';
insert into accountstatus values(2, 'pending');
insert into accountstatus values(3, 'closed');
insert into accounttype  values(1,'checking');
insert into accounttype values(2,'saving');

select * from users;
select * from roles;
select * from account ;
select * from accountstatus;
select * from accounttype;

Select roles.role_id, role_name from roles left join users on(roles.role_id=users.role_id) where users.user_name='tozden';
select * from roles inner join users on (roles.role_id =users.role_id);

SELECT * from account left join accountstatus on(account.status_id=accountstatus.status_id)
left join accounttype on(account.type_id=accounttype.type_id) where accountstatus.status_id=1;

SELECT * from account left join users on(account.user_id=users.user_id) where users.user_id=111111;
select * from users inner join roles on (users.role_id =roles.role_id) where user_id=111111;


SELECT * from account left join accountstatus on(account.status_id=accountstatus.status_id)
left join accounttype on(account.type_id=accounttype.type_id) left join users inner join roles on (users.role_id =roles.role_id) on (account.user_id=users.user_id)  where users.user_id=111111;


insert into users values(44444,'a','bbb','c','d','d@gmail',3);

insert into account values(11111,50000,1,1,44444);
insert into account values(11112,50000,1,1,111111);

