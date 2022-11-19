/* EJERCICIOS PROPUESTOS - SESION 3 */

/* CONJUNTOS */

/*
 * 1. Listar los títulos de los libros que no están asignados a sucursales de la ciudad de SALAMANCA.
 */
SELECT l.titulo FROM libro l
MINUS
SELECT l.titulo FROM libro l, dispone d, sucursal s WHERE l.isbn = d.isbn AND d.cod_suc = s.codigo AND s.poblacion = 'SALAMANCA';

/*
 * 2. Obtener los nombres de los lectores que han retirado préstamos en la sucursal 5 o en la 3.
 */
SELECT le1.nombre, le1.ape_1 FROM lector le1, prestamo p1, sucursal s1 WHERE p1.cod_lector = le1.codigo AND p1.cod_suc = s1.codigo AND s1.codigo = 5
UNION
SELECT le2.nombre, le2.ape_1 FROM lector le2, prestamo p2, sucursal s2 WHERE p2.cod_lector = le2.codigo AND p2.cod_suc = s2.codigo AND s2.codigo = 3;

/*
 * 3. Obtener los nombres de los lectores que han retirado préstamos tanto en la sucursal 5 como en la 3.
 */
SELECT le1.nombre, le1.ape_1 FROM lector le1, prestamo p1, sucursal s1 WHERE p1.cod_lector = le1.codigo AND p1.cod_suc = s1.codigo AND s1.codigo = 5
INTERSECT
SELECT le2.nombre, le2.ape_1 FROM lector le2, prestamo p2, sucursal s2 WHERE p2.cod_lector = le2.codigo AND p2.cod_suc = s2.codigo AND s2.codigo = 3;

/*
 * 4. Obtener un listado de los nombres de pila de los lectores que coinciden con nombres de algún escritor.
 */
SELECT nombre FROM lector
INTERSECT 
SELECT nombre FROM autor;

/*
 * 5. Obtener un listado de los títulos de libros de autores de nacionalidad italiana o francesa. 
 */
SELECT l1.titulo, a1.nombre, n1.nombre FROM libro l1, escribe e1, autor a1, nacionalidad n1
WHERE l1.isbn = e1.isbn AND e1.cod_autor = a1.codigo AND a1.cod_nacion = n1.codigo AND n1.nombre = 'ITALIA'
UNION
SELECT l2.titulo, a2.nombre, n2.nombre FROM libro l2, escribe e2, autor a2, nacionalidad n2
WHERE l2.isbn = e2.isbn AND e2.cod_autor = a2.codigo AND a2.cod_nacion = n2.codigo AND n2.nombre = 'FRANCIA'
ORDER BY 3;


/* AGRUPACION */

/*
 * 1. Hallar el número de lectores que no tienen domicilio en Salamanca capital. 
 */
SELECT count(codigo) FROM univ.lector WHERE poblacion != 'SALAMANCA';

SELECT count(*) FROM univ.lector WHERE poblacion != 'SALAMANCA';

/*
 * 2. Indicar el número total de poblaciones en las que hay lectores.
 */
SELECT count(s.poblacion), s.poblacion FROM sucursal s, lector l WHERE l.poblacion = s.poblacion GROUP BY s.poblacion;

/*
 * 3. Calcular la edad máxima, mínima y media de los lectores. 
 */
SELECT max(to_char(sysdate, 'yyyy') - to_char(fecha_nac, 'yyyy')) AS Edad_Max,
min(to_char(sysdate, 'yyyy') - to_char(fecha_nac, 'yyyy')) AS Edad_Min,
avg(to_char(sysdate, 'yyyy') - to_char(fecha_nac, 'yyyy')) AS Edad_Media
FROM lector;

/*
 * 4. Obtener el tiempo medio de préstamo
 */
SELECT avg(to_char(fecha_dev, 'yyyy') - to_char(fecha_ini, 'yyyy'))*365 AS Tiempo_Medio_Dias
FROM prestamo;

/*
 * 5. Obtener la media de días de préstamo de los prestamos pendientes de devolución.
 */
SELECT avg(to_char(sysdate, 'yyyy') - to_char(fecha_ini, 'yyyy'))*365 AS Tiempo_Medio_Dias
FROM prestamo p WHERE p.fecha_dev IS NULL;

/*
 * 6. Obtener el número de obras existentes en la biblioteca.
 *    He especificado para cada dirección la cantidad de libros disponibles que hay.
 */
SELECT count(num_disponibles), s.direccion FROM dispone d, sucursal s WHERE d.cod_suc = s.codigo GROUP BY s.direccion ORDER BY 2;

/*
 * 7. Encontrar cuántas obras han sido prestadas en alguna ocasión. 
 */
SELECT count(l.isbn) FROM libro l, prestamo p WHERE l.isbn = p.isbn AND p.fecha_ini IS NOT NULL;

/*
 * 8. Obtener el número de obras que no han sido prestadas nunca. 
 */
SELECT count(*) FROM libro l, prestamo p, dispone d WHERE l.isbn = d.isbn AND d.cod_suc = p.cod_suc AND p.fecha_ini IS NULL;

/*
 * 9. Obtener el número total de ejemplares que se han adquirido para todas las sucursales. 
 */
SELECT sum(num_ejemplares) FROM libro l, dispone d, sucursal s WHERE l.isbn = d.isbn AND d.cod_suc = s.codigo;

/* Numero de ejemplares en cada sucursal */
SELECT s.codigo, sum(num_ejemplares) FROM libro l, dispone d, sucursal s WHERE l.isbn = d.isbn AND d.cod_suc = s.codigo GROUP BY s.codigo ORDER BY s.codigo;

/*
 * 10. Obtener la media de edad alcanzada por los autores fallecidos. 
 */
SELECT avg(ano_fall - ano_nac) AS Media_Edad FROM autor WHERE ano_fall IS NOT NULL;

/*
 * 11. Obtener la edad del lector más longevo. 
 */
SELECT l1.nombre, l1.ape_1, l1.ape_2, l1.fecha_nac FROM lector l1, lector l2 GROUP BY l1.nombre, l1.ape_1, l1.ape_2, l1.fecha_nac
HAVING to_char(l1.fecha_nac, 'yyyymmdd') = min(to_char(l2.fecha_nac, 'yyyymmdd'));

/*
 * 12. Obtener el total de préstamos realizados por cada sucursal en el año 2007. 
 */
SELECT cod_suc AS Suc, count(*) AS Total_Prestamos FROM univ.prestamo
WHERE to_char(fecha_ini, 'yyyy') = 2007 GROUP BY cod_suc ORDER BY cod_suc;

/*
 * 13. Obtener un listado con el código de todos los lectores que realizaron préstamos el año 96. 
 */
SELECT cod_lector FROM univ.prestamo WHERE to_char(fecha_ini, 'yyyy') = 1996 GROUP BY cod_lector;

SELECT DISTINCT cod_lector FROM univ.prestamo WHERE to_char(fecha_ini, 'yyyy') = 1996;

/*
 * 14. Obtener el número de autores por nacionalidades de los que se tiene ejemplares en la biblioteca. 
 */
SELECT n.nombre Nacion, count(a.codigo) Num_Autores FROM univ.nacionalidad n JOIN univ.autor a ON n.codigo = a.cod_nacion
GROUP BY n.codigo, n.nombre;

/*
 * 15. Hacer un listado con el número de ejemplares en préstamo en cada sucursal. 
 */
SELECT cod_suc, count(codigo) FROM univ.prestamo WHERE fecha_dev IS NULL GROUP BY cod_suc ORDER BY cod_suc;

SELECT cod_suc, sum(num_ejemplares - num_disponibles) FROM univ.dispone GROUP BY cod_suc ORDER BY cod_suc;

/*
 * 16. Obtener los títulos de los libros y el número total de ejemplares en el conjunto de las sucursales. 
 */
SELECT titulo, sum(num_ejemplares) FROM univ.libro l JOIN univ.dispone d ON l.isbn = d.isbn GROUP BY l.isbn, titulo;

/*
 * 17. Obtener un listado de sucursales y el número de ejemplares de los que dispone. 
 */
SELECT s.codigo, sum(num_ejemplares) FROM univ.sucursal s LEFT JOIN univ.dispone d 
ON s.codigo = d.cod_suc GROUP BY s.codigo ORDER BY 2;

/*
 * 18. Indicar para los años 2000 a 2005 el número de lectores que realizaron préstamos cada uno de esos años. 
 */
SELECT to_char(fecha_ini, 'yyyy'), count(*) FROM univ.prestamo WHERE to_char(fecha_ini, 'yyyy') BETWEEN 2000 AND 2005
GROUP BY to_char(fecha_ini, 'yyyy') ORDER BY 1;

/*
 * 19. Obtener los títulos de todos los libros indicando el número total de préstamos de cada uno. 
 */
SELECT l.titulo, count(*) FROM libro l, prestamo p WHERE p.isbn = l.isbn AND p.fecha_ini IS NOT NULL GROUP BY l.titulo ORDER BY 2;

/*
 * 20. Obtener los títulos de los libros que hayan tenido más de 5 préstamos, indicando
 *     el número total de préstamos de cada libro. 
 */
SELECT titulo, count(p.codigo) FROM univ.libro l JOIN univ.prestamo p ON l.isbn = p.isbn
GROUP BY l.isbn, titulo HAVING count(p.codigo) > 5;

/*
 * 21. Obtener los nombres y apellidos de los lectores de la ciudad de Salamanca que
 *     tienen en este momento más de un libro en préstamo. 
 */
SELECT nombre, ape_1, ape_2 FROM univ.lector l JOIN univ.prestamo p ON l.codigo = p.cod_lector
WHERE fecha_dev IS NULL AND poblacion = 'SALAMANCA'
GROUP BY l.codigo, nombre, ape_1, ape_2 HAVING count(*) > 1;

/*
 * 22. Obtener, para cada título, el número medio de ejemplares de ese título en todas
 *     las sucursales. 
 */
SELECT titulo, avg(num_ejemplares) AS Media_Ejemplares FROM univ.libro l LEFT JOIN univ.dispone d ON l.isbn = d.isbn
GROUP BY l.isbn, titulo;

/*
 * 23. Obtener el libro más recientemente editado.
 */
SELECT l1.isbn, l1.titulo FROM libro l1, libro l2 GROUP BY l1.isbn, l1.titulo, l1.ano_edicion
HAVING l1.ano_edicion = max(l2.ano_edicion);