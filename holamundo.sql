show databases;
create database holamundo;
use holamundo;
show tables;
set sql_safe_updates=1;
use holamundo;
							
create table animales(
id int,
tipo varchar(255),
estado varchar(255),
primary key (id)
)engine=InnoDB;
insert into animales (tipo,estado) values ('breinenr','feliz');
insert into animales (tipo,estado) values ('dragon','feliz');
insert into animales (tipo,estado) values ('felipe','triste');
alter table animales modify  id  int auto_increment;
describe animales;
select *from animales where id =1;
select * from animales where estado = 'feliz' and tipo ='dragon';

set sql_safe_updates=0;

update animales set estado = 'feliz' where id = 5 ;
select * from animales;
delete from animales where  id = 5 ;
update animales set tipo = 'breinner' where  id=4;
select tipo  from animales where tipo ="breinner" or tipo = "dragon" ; 

-- nueva tabla 
create table  if not exists usuario(
  id  int not null auto_increment,
  name varchar (50) not null,
  edad int not null,
  email varchar (100) not null,
  primary key (id)
)engine=InnoDB;

 insert into usuario(name,edad,email)
   values ('Breinner',24,'breinner@gmail.com'),
		    ('layla',15,'layla@gmail.com'),
		    ('chapulin',15,'chapulin@gmail.com') ;

select * from usuario;
show tables;
select * from usuario limit 1;
select * from usuario where edad >15;
select * from usuario where edad>=15;
select * from usuario where edad >=20 and email = 'breinner@gmail.com';
select * from usuario  where edad >=20 or email= 'chapulin@gmail.com';
select * from usuario where  email != 'chapulin@gmail.com';
select * from usuario where  edad between 15 and 30;
select * from usuario where  email like '%gmail%';
select * from usuario where email like '%gmail';
select * from usuario where email like 'brei%';
select * from usuario order by edad asc;
select * from usuario order by edad desc;
select  max(edad) as mayor from usuario;
select min(edad) as menor from usuario;
select id, name  as nombre from usuario;

# Creo tabla productos

create  table products(
id int not null auto_increment,
name varchar (50) not null,
 created_by int not null,
  marca varchar(50) not null,
  primary key (id),
  foreign key (created_by) 
  references usuario(id)
)engine=InnoDB;

describe producto;
rename table products to producto;
insert into producto (name,created_by,marca)
values('ipad',1,'apple'),
       ('iphone',1,'apple'),
       ('watch',2,'apple'),
       ('macbook',1,'appple'),
       ('imac',3,'aplle'),
       ('ipad mini',2,'apple');
       select * from producto;
       
       select u.id, u.email, p.name from usuario u left join producto p on u.id= p.created_by;
	   select u.id, u.email, p.name from usuario u right join producto p on u.id=p.created_by;
       select u.id, u.email, p.name from usuario u inner join producto p on u.id=p.created_by;
	   select u.id, u.name,  p.id, p.name from usuario u  cross join producto p;
       select count(id), marca from  producto group by marca; 
       select count(p.id), u.name from producto p left join  usuario u on u.id =p.created_by   group by p.created_by;
     
	select count(p.id), u.name from producto p left join  usuario u 
	on u.id = p.created_by
	group by p.created_by having count(p.id) >1 ;


