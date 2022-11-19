/* EJERCICIOS PROPUESTOS - SESION 4 */

/*
 * 1. Crear las siguientes tablas correspondientes a una base de datos con informacion
 *    sobre empleados y proyectos de una empresa:
 *
 *    EMPLEADO (DNI, Nombre, Apellidos, FechaAlta, Salario)
 *    PROYECTO (Codigo, Nombre, Presupuesto, FechaInicio, FechaFin)
 *    TRABAJA_EN (DNI, Cod_Proy, Horas)
 *
 *    Teniendo en cuenta las siguientes restricciones:
 *      - Los atributos DNI y Codigo de proyecto son de tipo entero.
 *      - Los atributos que aparecen subrayados son las claves primarias de cada relacion.
 *      - Ningun atributo de la tabla EMPLEADO podra tener un valor nulo.
 *      - No se permitira que dos empleados coincidan en nombre y apellidos.
 *      - Por defecto, la fecha de alta de un empleado se tomara como la fecha en la que se 
 *        inserte la tupla correspondiente al empleado.
 *      - El salario sera siempre una cantidad entera entre 14400 y 45000. Por defecto se asignara 
 *        un valor de 20000 si no se proporciona uno especifico en el momento de dar el alta.
 *      - Los atributos Presupuesto, FechaIncio y FechaFin de la tabla PROYECTO podran tener un 
 *        valor nulo. El resto de los atributos de esa tabla seran siempre no nulos.
 *      - No se permite que dos proyectos tengan el mismo nombre.
 *      - Por defecto, el atributo FechaInicio tomara el valor correspondiente a la fecha en la que 
 *        se inserte la tupla en la tabla PROYECTO.
 *      - El numero de horas que un empleado trabaja en cada proyecto sera siempre un valor no nulo 
 *        comprendido entre 10 y 40. Por defecto se asignara el valor 10.
 */
create table EMPLEADO (
DNI integer not null primary key,
Nombre varchar(20) not null,
Apellidos varchar(20) not null,
FechaAlta date default sysdate not null,
Salario decimal (7,2) default 20000 not null check (Salario >= 14400 and Salario <= 45000),
constraint EMP_UNIQ unique (Nombre, Apellidos));

create table PROYECTO (
Codigo integer not null primary key,
Nombre varchar(20) not null unique,
Presupuesto decimal (9,2),
FechaInicio date default sysdate,
FechaFin date);

create table TRABAJA_EN (
DNI integer not null references empleado,
Cod_Proy integer not null references proyecto,
Horas integer default 10 not null check (Horas >= 10 and Horas <= 40),
primary key (DNI, Cod_Proy));

/*
 * 2. Comprobar la estructura de las tablas creadas usando el comando desc de sqlplus 
 */
desc EMPLEADO
desc PROYECTO
desc TRABAJA_EN 

/*
 * 3. Insertar los siguientes datos correspondientes a un empleado: Agustin Perez Marcos, con DNI 1231234 y salario 21000. 
 *    Realizar la insercion sin proporcionar valor para el atributo FechaAlta. Comprobar que se ha insertado correctamente 
 *    la tupla con el valor adecuado en FechaAlta.
 */
insert into EMPLEADO (NOMBRE, APELLIDOS, DNI, SALARIO) values ('Agustin', 'Perez Marcos', 1231234, 21000);
select * from EMPLEADO where dni=1231234;

/*
 * 4. Insertar la siguiente informacion correspondiente a un proyecto: 
 *    Codigo=21234, Nombre='PUENTE'. Comprobar la informacion insertada.
 */
insert into PROYECTO (CODIGO, NOMBRE) values (21234, 'PUENTE');
SELECT * FROM PROYECTO WHERE codigo = 21234;

/*
 * 5. Insertar una tupla en TRABAJA_EN Indicando que el empleado Agustin Perez Trabaja 15 horas semanales en el proyecto PUENTE.
 */
insert into TRABAJA_EN values (1231234, 21234, 15);

/*
 * 6. Insertar una tupla en TRABAJA_EN indicando que el empleado con DNI 3214321 trabaja 10 horas en el proyecto PUENTE. ¿Que ocurre?
 */
insert into TRABAJA_EN values (3214321, 21234, 10);

/*
 * 7. Modificar la estructura de la tabla EMPLEADO para que contenga una nueva columna que permita almacenar la titulacion de cada empleado.
 */
alter table EMPLEADO add titulacion varchar(50);

/*
 * 8. Modificar la tabla empleado para eliminar la restriccion que no permite que dos empleados se llamen igual.
 */
alter table EMPLEADO drop constraint EMP_UNIQ;

/*
 * 9. Eliminar la tabla EMPLEADO. ¿Que ocurre?
 */
drop table EMPLEADO;

/*
 * 10. Eliminar todas las tablas creadas en el orden adecuado.
 */
drop table TRABAJA_EN;
drop table EMPLEADO;
drop table PROYECTO;