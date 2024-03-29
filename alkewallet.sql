create schema wallet;
use wallet;

create table usuario (
user_id int auto_increment primary key,
nombre varchar(50),
correo varchar(100),
contrasena varchar(50),
saldo int
);

create table transaccion (
transaction_id int auto_increment primary key,
sender_user_id int,
receiver_user_id int,
importe int,
transaction_date date,
foreign key (sender_user_id)
	references usuario (user_id),
foreign key (receiver_user_id)
	references usuario (user_id)
);

create table moneda (
currency_id int auto_increment primary key,
currency_name varchar(50),
currency_symbol varchar(10)
);

/*Para poder conectar transaccion con moneda*/
alter table transaccion
add column currency_id int not null;
alter table transaccion
add constraint fk_departamento foreign key (currency_id)
	references moneda(currency_id);
    
/*Poblar tablas*/
insert into usuario (nombre, correo, contrasena, saldo)
values ("Juan Perez", "juan.p@correo.com", "pass123", 1500000),
		("Maria Carrasco", "m.carrasco@correo.com", "123pass", 2600000),
        ("Rodolfo Muñoz", "rodolfo444@correo.com", "rm444", 900000);
 
 insert into moneda (currency_name, currency_symbol)
 values ("Peso chileno", "CLP$"),
		("Dolar", "US$"),
        ("Euro", "€");
 
insert into transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id)
values (1, 2, 15000, "2024-03-28", 1),
		(2, 3, 22000, "2024-03-24", 2),
		(3, 1, 11000, "2024-03-26", 3);

/*Consulta para obtener el nombre de la moneda elegida por un
usuario específico*/
select u.user_id, u.nombre, m.currency_name
from transaccion t 
inner join moneda m on m.currency_id = t.currency_id
inner join usuario u on u.user_id = t.sender_user_id
where user_id = 2;

/*Consulta para obtener todas las transacciones registradas*/
select * from transaccion;

/*Consulta para obtener todas las transacciones realizadas por un
usuario específico*/
select t.transaction_id, t.sender_user_id, u.nombre, t.importe
from transaccion t
inner join usuario u on u.user_id = t.sender_user_id
where user_id = 3;

/*Sentencia DML para modificar el campo correo electrónico de un
usuario específico*/
update usuario
set correo = "nuevo.rodolfo@correo.com"
where user_id = 3;

select * from usuario; /*Para corroborar que esté el nuevo correo*/

/*Sentencia para eliminar los datos de una transacción (eliminado de
la fila completa)*/
delete from transaccion
where transaction_id = 1;

select * from transaccion; /*Para corroborar que se eliminó la fila*/