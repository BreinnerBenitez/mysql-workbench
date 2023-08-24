
#    					GRACIAS POR ESTAR AQUI = BREINNER BENITEZ :)
show databases; 
create database LAMARDEN;
USE LAMARDEN;
create table if not exists Vendedor(
Codigo int auto_increment primary key not null,
Nombre varchar(50) not null,
Direccion varchar (50) not null,
Telefono int not null,
Edad int not null
)engine=InnoDB;
create table if not exists Ventas(
Codigo int not null,
Fecha Date not null,
Libro varchar (50) not null,
Cantidad int  not null,
Ciudad Varchar (50) not null,
foreign key (Codigo)
 references Vendedor(Codigo)
)engine=InnoDB;

insert into Vendedor(Nombre,Direccion,Telefono,Edad)
values ('GOMEZ CARLOS','Calle 44 #19-42',2117878, 22),
       ('NAVAS IVAN','Calle 24#13a 51',2415891, 33),
	    ('RUIZ ANGELA','CARRERA 5 # 20-99',2457459, 44),
         ('ARANA LUISA','CALLE 26 # 7- 53',2111111, 55);
insert into Ventas(Codigo,Fecha,Libro,Cantidad,Ciudad)
 values (1,'20180202','WINDOWS',125,'VILLAVO'),
	    (2,'20180204','WORD',145,'BOGOTA'),
		(3,'20180205','EXCEL',189,'BOGOTA'),
		(4,'20180208','ACCESS',217,'TUNJA'),
		(4,'20180212','ACCESS',324,'GIRARDOT'),
		(3,'20180218','EXCEL',235,'TUNJA'),
		(1,'20180221','WORD',189,'GIRARDOT'),
		(3,'20180227','WINDOWS',223,'VILLAVO'),
		(2,'20180301','POWERPOINT',198,'TUNJA'),
		(4,'20180505','WINDOWS',305,'GIRARDOT'),
		(1,'20180310','POWERPOINT',502,'BOGOTA');
        
        # CONSULTAS
        
show databases;
use lamarden;    
show tables;
select * from ventas;
select * from ventas where libro ="WINDOWS" or libro ="EXCEL" ORDER BY libro, Cantidad  ,ciudad; 
select libro, avg(Cantidad) as media_Articulo from ventas Group by libro  having  libro="WINDOWS" or libro="ACCESS" ORDER BY media_Articulo; 
select libro, max(cantidad) as cantidadma from ventas  group by libro having libro ="WORD" ;
select libro,fecha, DATE_format(now(),"%D-%M") as fecha_actual, datediff(now(),fecha) as diferencia from ventas where libro="WORD";



 select libro ,cantidad from ventas where Cantidad> (select avg(cantidad) from ventas); #escalonadas
 select libro , cantidad from ventas where cantidad>= any (select Cantidad from ventas where libro="WORD");
 select Cantidad from ventas where libro="WORD";


update ventas set Cantidad=Cantidad+10 where libro="WINDOWS";
update ventas set Libro="WORD" where libro="WORDD";
create table  ventas2 select * from ventas where Libro = "WORD";   
insert into ventas select Codigo,Fecha,Libro,Cantidad,Ciudad from ventas2;
select *  from ventas2;
alter table  ventas2 add column pureblo varchar (15);
alter table  ventas2 change column pureblo pueblo varchar(20);

#TRIGGER DESPUES DE INSERTAR

create table if not exists reg_libro(
codigo varchar (25),
libro varchar(30),
insertado datetime
)engine=InnoDB;

create trigger ventas_ai
after insert on ventas 
for each row
insert into reg_libro(codigo,libro,insertado) values(new.codigo,new.libro,now());


# TRIGGER  ANTES DE ACTUALIZACION DE TABLA VENTAS
create table if not exists ventas3(
anterior_codigo int(11),
anterior_fecha date,
anterior_libro varchar(50),
anterior_cantidad int (11),
anterior_ciudad varchar(50),
nuevo_codigo int(11),
nuevo_fecha date,
nuevo_libro varchar(50),
nuevo_cantidad int (11),
nuevo_ciudad varchar(50),
usuario varchar(52),
fecha_modi date

)engine=innodb;

create trigger actualiza_ventasBU before update on ventas
for each row insert into ventas3(anterior_codigo,anterior_fecha,anterior_libro,anterior_cantidad,
anterior_ciudad,nuevo_codigo,nuevo_fecha,nuevo_libro,nuevo_cantidad,nuevo_ciudad,usuario,fecha_modi)
values(old.codigo,old.fecha,old.libro,old.cantidad,old.ciudad,new.codigo,new.fecha,new.libro,new.cantidad,
new.ciudad,current_user(),now());  #  GUARDA REGISTROS ACTUALIZADOS EN ENTIDAD VENTAS3 CON USUARIO Y FECHA ACTUAL

update ventas set Cantidad=23 where Cantidad=217 ;
select * from ventas;
show tables; 

# TRIGGER DESPUES DE ELIMINACION DE UN REGISTRO
create table ventas_eliminados(
 codigo int,
 fecha date,
 libro varchar(20),
 cantidad int(11),
 ciduad varchar(25)
)engine=innodb;

create trigger eliminaventAD after delete on ventas
for each row
insert into ventas_eliminados(codigo,fecha,libro,cantidad,ciudad)
values (old.codigo,old.fecha,old.libro,old.cantidad,old.ciudad);

describe ventas_eliminados;
alter table ventas_eliminados change ciduad ciudad varchar (25);
delete  from ventas where Cantidad  = 23;
select * from ventas_eliminados;
alter  table ventas_eliminados add column (usuario varchar(50),fecha_modi date);

drop  trigger eliminaventAD;
create trigger eliminaventAD after delete on ventas
for each row
insert into ventas_eliminados(codigo,fecha,libro,cantidad,ciudad,usuario,fecha_modi)
values (old.codigo,old.fecha,old.libro,old.cantidad,old.ciudad,current_user(),now());
select * from ventas;
delete  from ventas where Cantidad  = 243;
select * from ventas_eliminados;

# PORCEDIMIENTOS ALMACENADOS

create procedure muestra_ventas()
select * from ventas where Ciudad ="BOGOTA";
call muestra_ventas();

create procedure actualiza_ventas(codi int,ciu Varchar(25) )
update ventas set ciudad=ciu where codigo=codi;
call actualiza_ventas(1,"CANDELARIA");
select *  from ventas;

DELIMITER //
create procedure calculaedad(ano_na int)
	begin 
		declare ano_actual int default 2023;
        declare edad int;
        
        SET  edad=ano_actual-ano_na;
        
        select edad;
	END;//
 DELIMITER ;
 
#call  calculaedad(2000);
   
DELIMITER //
create trigger revisa_ventasBU before update  on ventas for each row 
    begin
		if (new.Cantidad<0) then
        
			set new.Cantidad=0;
			
		elseif (new.Cantidad>1000) then 
        
			set new.Cantidad=1000;
            
         end if;   
	end; //

	DELIMITER ;
    show triggers;
    drop trigger actualiza_ventasBU; # lo borro para poder seguir practicando :D  y no funcionarlo
	update ventas set cantidad=0 where cantidad =145;
    update ventas set cantidad=2000 where cantidad =0;
	update ventas set cantidad=20 where cantidad =1000;
	update ventas set cantidad=-20 where cantidad =20;  
	update ventas set cantidad=145 where cantidad =0;  #  cambia a 145 nuevamente - Trigger BU
    
    # vistas mirar
    create view mirar as select * from ventas;
    
     

# set sql_safe_updates=0;
