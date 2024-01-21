/* EJERCICIOS PROPUESTOS - SESION 1 */

/*
 * 1. Obtener toda la información almacenada en la base de datos, relacionada con los 
 *    autores, sucursales, lectores, libros y editoriales. 
 */
SELECT * FROM autor;
SELECT * FROM lector;
SELECT * FROM sucursal;
SELECT * FROM libro;
SELECT * FROM editorial;

/*
 * 2. Obtener la fecha de nacimiento de cada uno de los lectores ordenados del más 
 *    joven al mayor de ellos. 
 */
SELECT fecha_nac FROM lector ORDER BY fecha_nac DESC;

/*
 * 3. Obtener el ISBN de los libros que están prestados indicando la sucursal y la fecha en 
 *    la que se realizó el préstamo. Ordenar la salida por sucursal y fecha de préstamo.
 */
SELECT isbn, cod_suc, fecha_ini FROM prestamo WHERE fecha_dev IS NOT NULL ORDER BY cod_suc, fecha_ini ASC;

/*
 * 4. Obtener el código y nombre de las editoriales. Incluir entre ambos campos el literal 
 *    NOMBRE. 
 */
SELECT codigo || ' NOMBRE ' || nombre FROM editorial;

/*
 * 5. Obtener primer apellido, segundo apellido y nombre de todos los lectores de la 
 *    biblioteca ordenados primer y segundo apellido. 
 */
SELECT ape_1, ape_2, nombre FROM lector ORDER BY ape_1, ape_2;

/*
 * 6. Obtener un listado de los libros ordenado de menor a mayor antigüedad. 
 */
SELECT * FROM libro ORDER BY ano_edicion DESC;

/*
 * 7. Obtener las distintas poblaciones en las que están domiciliados los lectores, dando el
 *    nombre de la población y la provincia de cada una de ellas. El listado deberá
 *    obtenerse ordenado por nombre de provincia y población. Comparar el resultado que
 *    se hubiera obtenido sin utilizar DISTINCT. 
 */
SELECT DISTINCT poblacion, provincia FROM lector ORDER BY provincia, poblacion;

SELECT poblacion, provincia FROM lector ORDER BY provincia, poblacion;

/*
 * 8. Obtener el domicilio del lector cuyo segundo apellido sea BENITO. 
 */
SELECT direccion FROM lector WHERE ape_2 = 'BENITO';

/*
 * 9. Obtener el nombre completo de los autores con nacionalidad española (Busque
 *    previamente el código correspondiente en la tabla nacionalidad). 
 */
SELECT codigo FROM nacionalidad WHERE nombre = 'ESPANA';

SELECT apellido || ' ' || nombre AS autor FROM autor WHERE cod_nacion = '9';

/*
 * 10. Obtener la dirección postal completa de la sucursal cuyo código es 12 
 */
SELECT direccion || ',' || poblacion || ',' || provincia AS direccion FROM sucursal where codigo = '12';

/*
 * 11. De los diferentes libros de los que disponen las sucursales indicar aquellas
 *     sucursales que tienen más de 3 ejemplares de un mismo libro. Indique el código de
 *     la sucursal, el ISBN del libro y el número de ejemplares con el requisito requerido
 *     (3 o más de 3 ejemplares). 
 */
SELECT cod_suc, isbn, num_ejemplares FROM dispone WHERE num_ejemplares > 3 ORDER BY cod_suc ASC;

/*
 * 12. Obtener el código de los lectores s que han cogido en préstamos el libro de ISBN
 *     5023024 ordenados por sucursal y fecha de préstamo.
 */
SELECT cod_lector FROM prestamo WHERE isbn = '5023024' ORDER BY cod_suc, fecha_ini ASC;

/*
 * 13. Obtener el Código de los autores ya fallecidos, la fecha en la que fallecieron y los
 *     años que tenían. 
 */
SELECT codigo, ano_fall, ano_fall-ano_nac FROM autor WHERE ano_fall IS NOT NULL;

/*
 * 14. Obtener nombre y dos apellidos de los lectores que hayan nacido antes de 1980. 
 */
SELECT nombre, ape_1, ape_2, FROM lector WHERE to_char(fecha_nac, 'yyyy') < 1980;

/*
 * 15. Obtener un listado de los lectores que a lo largo de este año superan los 23 años. 
 */
SELECT nombre, ape_1, ape_2 FROM lector WHERE to_char(fecha_nac, 'yyyy') = to_char(sysdate, 'yyyy') - 23;

/*
 * 16. Obtener un listado ordenado alfabéticamente de todos los lectores registrados en la
 *     base de datos que tienen domicilio en Zamora. 
 */
SELECT * FROM lector WHERE poblacion = 'ZAMORA';

/*
 * 17. Obtener los libros disponibles en la sucursal con código 5. 
 */
SELECT ISBN FROM univ.dispone WHERE cod_suc = '5';

/*
 * 18. Obtener el código y nombre de los libros con más de 12 años de edición. 
 */
SELECT ISBN, titulo FROM libro WHERE ano_edicion < to_char(sysdate, 'yyyy') - 12;

/*
 * 19. Obtener los lectores cuyo domicilio habitual está en las provincias de Salamanca o
 *     Ávila. 
 */
SELECT * FROM lector WHERE provincia = 'SALAMANCA' OR provincia = 'AVILA';

/*
 * 20. Obtener los préstamos que no han sido devueltos indicando el código de préstamo,
 *     código de lector y fecha de inicio del préstamo. Ordénese la salida por sucursal. 
 */
SELECT codigo, cod_lector, fecha_ini FROM prestamo WHERE fecha_dev IS NULL ORDER BY cod_suc;

/*
 * 21. Obtener el nombre de los profesores pertenecientes las nacionalidades española,
 *     francesa o británica (Busque previamente los códigos correspondientes en la tabla
 *     nacionalidad). 
 */
SELECT nombre, apellido FROM autor WHERE cod_nacion = '9' OR cod_nacion = '11' OR cod_nacion = '25';

/*
 * 22. Obtener un listado que incluya el código, nombre y provincia de los lectores que no
 *     vivan ni en la provincia de Salamanca ni en la de Zamora. 
 */
SELECT codigo, nombre, provincia FROM lector WHERE provincia != 'SALAMANCA' AND provincia != 'ZAMORA';

/*
 * 23. Obtener el nombre y apellido de aquellos lectores cuyo primer apellido empiece por
 *     M. 
 */
SELECT nombre, ape_1, ape_2 FROM lector WHERE ape_1 LIKE 'M%';

/*
 * 24. Obtener el nombre de los lectores cuyo apellido empiece por G e incluya alguna Z. 
 */
SELECT nombre FROM lector WHERE (ape_1 LIKE 'G%' AND ape_1 LIKE '%Z%') OR (ape_2 LIKE 'G%' AND ape_2 LIKE '%Z%');

/*
 * 25. Obtener el nombre y apellidos de aquellos lectores que tengan un primer apellido de
 *     7 letras. 
 */
SELECT nombre, ape_1, ape_2 FROM lector WHERE length(ape_1) = 7;

/*
 * 26. Seleccionar los lectores que tengan edades comprendidas entre los 26 y los 36 años.
 *     Ordenar de mayor a menor edad. 
 */
SELECT nombre, ape_1, ape_2, fecha_nac FROM lector WHERE (to_char(sysdate, 'yyyy') - to_char(fecha_nac, 'yyyy') BETWEEN 26 and 36) ORDER BY fecha_nac DESC;

/*
 * 27. Seleccionar los autores que no son españoles. 
 */
SELECT nombre, apellido FROM autor WHERE cod_nacion != '9';

/*
 * 28. Mostrar los nombres, apellidos y edad de los autores vivos que no son españoles y
 *     que tienen más de 70 años o menos de 50. 
 */
SELECT nombre, apellido, (to_char(sysdate, 'yyyy') - ano_nac) AS edad FROM autor WHERE ano_fall IS NULL AND cod_nacion != '9' AND (to_char(sysdate, 'yyyy') - ano_nac) NOT BETWEEN 50 and 70;

/*
 * 29. Obtener los datos de los préstamos que, o bien son de la sucursal 5 y han sido
 *     devueltos, o bien son de la sucursal 10 y aún están en vigor. 
 */
SELECT * FROM prestamo WHERE (cod_suc = '5' AND fecha_dev IS NOT NULL) OR (cod_suc = '10' AND fecha_dev IS NULL);