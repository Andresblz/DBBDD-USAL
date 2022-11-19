/* EJERCICIOS PROPUESTOS - SESION 2 */

/* FALTAN POR TERMINAR 18 - 22 - 23 */

/*
 * 1. Mostrar el listado de títulos y autores de los libros de la base de datos.
 */
SELECT titulo, nombre, apellido FROM libro l, autor a, escribe e WHERE l.isbn = e.isbn AND a.codigo = e.cod_autor;

/*
 * 2. Obtener los títulos de los libros disponibles en las sucursales de la ciudad de
 *    Salamanca indicando además el código de la sucursal.
 */
SELECT titulo, s.codigo AS Sucur FROM sucursal s, dispone d, libro l WHERE s.codigo = d.cod_suc 
AND l.isbn = d.isbn AND s.poblacion = 'SALAMANCA';

/*
 * 3. Listar los títulos de los libros que están actualmente en préstamo en la sucursal
 *    con código 7.
 */
SELECT DISTINCT titulo FROM libro l, prestamo p WHERE l.isbn = p.isbn AND p.cod_suc = 7 AND fecha_dev IS NULL;

/*
 * 4. Repetir el listado anterior añadiendo el nombre del lector que tiene cada libro.
 */
SELECT titulo, nombre, ape_1, ape_2 FROM libro li, prestamo p, lector le WHERE li.isbn = p.isbn 
AND le.codigo = p.cod_lector AND p.cod_suc = 7 AND fecha_dev IS NULL;

/*
 * 5. Obtener el código de sucursal, título del libro y número de ejemplares asignados
 *    para aquellos casos en los que el número de ejemplares sea mayor que 3.
 */
SELECT cod_suc, titulo, num_ejemplares FROM libro l, dispone d WHERE l.isbn = d.isbn AND num_ejemplares > 3 ORDER BY 1;

/*
 * 6. Seleccionar los autores anteriores al siglo XIX mostrando para cada uno su
 *    nombre, apellidos y nacionalidad.
 */
SELECT a.nombre, apellido, n.nombre FROM autor a, nacionalidad n WHERE cod_nacion = n.codigo AND ano_fall < 1800;

/*
 * 7. Obtener un listado de los libros de la editorial COSMOS mostrando el título del
 *    libro y el nombre y apellidos de su autor.
 */
SELECT titulo, a.nombre, apellido FROM libro l, autor a, escribe es, editorial ed WHERE l.isbn = es.isbn 
AND a.codigo = es.cod_autor AND l.cod_editorial = ed.codigo AND ed.nombre = 'COSMOS';

/*
 * 8. Obtener un listado de los títulos de los libros que ha leído el socio cuyo primer
 *    apellido es TRIGO ordenado por la fecha en la que realizó el préstamo.
 */
SELECT titulo, fecha_ini FROM prestamo p, libro li, lector le WHERE p.isbn = li.isbn AND p.cod_lector = le.codigo 
AND ape_1 = 'TRIGO' ORDER BY 2;

/*
 * 9. Mostrar la localidad de las sucursales en las que ha realizado prestamos
 *    CARLOS LOPEZ CUADRADO
 */
SELECT DISTINCT s.poblacion FROM sucursal s, prestamo p, lector le WHERE s.codigo = p.cod_suc 
AND le.codigo = p.cod_lector AND le.nombre = 'CARLOS' AND ape_1 = 'LOPEZ' AND ape_2 = 'CUADRADO';

/*
 * 10. Listar los nombres de los lectores que han leído libros de MARIO VARGAS
 *     LLOSA.
 */
SELECT DISTINCT le.nombre, le.ape_1, le.ape_2 FROM lector le, prestamo p, escribe e, autor a WHERE le.codigo = p.cod_lector 
AND p.isbn = e.isbn AND e.cod_autor = a.codigo AND a.nombre = 'MARIO' AND a.apellido = 'VARGAS LLOSA';

/*
 * 11. Mostrar los títulos y los nombres de los autores de los libros que han sido
 *     prestados en los dos últimos años.
 */
SELECT l.titulo, a.nombre, a.apellido, p.fecha_ini, p.fecha_dev FROM prestamo p, libro l, escribe e, autor a
WHERE p.isbn = l.isbn AND l.isbn = e.isbn AND e.cod_autor = a.codigo AND (to_char(sysdate, 'yyyy') - to_char(fecha_ini, 'yyyy')) <= 2
AND fecha_ini IS NOT NULL ORDER BY fecha_ini ASC;

    /*
    * Como la base de datos solo tiene fechas de inicio de prestamo hasta 2011,
    * para comprobar este apartado creamos la misma función pero cambiando el año del
    * actual a 2012, 2011, etc...
    */
    SELECT l.titulo, a.nombre, a.apellido, p.fecha_ini, p.fecha_dev FROM prestamo p, libro l, escribe e, autor a
    WHERE p.isbn = l.isbn AND l.isbn = e.isbn AND e.cod_autor = a.codigo AND (2012 - to_char(fecha_ini, 'yyyy')) <= 2
    AND fecha_ini IS NOT NULL ORDER BY fecha_ini ASC;

/*
 * 12. Mostrar los nombres completos de los lectores que han pedido prestado algún
 *     libro en las sucursales de la provincia de SALAMANCA.
 */
SELECT DISTINCT le.nombre, le.ape_1, le.ape_2 FROM lector le, prestamo p, sucursal s WHERE le.codigo = p.cod_lector 
AND s.provincia = 'SALAMANCA' AND p.fecha_ini IS NOT NULL;

/*
 * 13. Mostrar el número de ejemplares disponibles del libro titulado .A SANGRE
 *     FRIA. de .TRUMAN CAPOTE. en la sucursal de CORIA (CACERES).
 */
SELECT d.num_disponibles, li.titulo, a.nombre, a.apellido FROM dispone d, libro li, escribe e, autor a, sucursal s 
WHERE e.cod_autor = a.codigo AND li.isbn = d.isbn AND d.cod_suc = s.codigo AND li.titulo = 'A SANGRE FRIA' 
AND a.nombre = 'TRUMAN' AND a.apellido = 'CAPOTE' AND s.poblacion = 'CORIA' AND s.provincia = 'CACERES';

/*
 * 14. Obtener el título del libro, el nombre del autor, el nombre de la editorial y la
 *     dirección de las sucursales donde está disponible algún ejemplar del libro con
 *     isbn: 5023300
 */
SELECT DISTINCT l.titulo, a.nombre, a.apellido, ed.nombre, s.direccion FROM libro l, autor a, editorial ed, sucursal s, dispone d, escribe es
WHERE es.cod_autor = a.codigo AND es.isbn = l.isbn AND l.cod_editorial = ed.codigo AND d.cod_suc = s.codigo
AND l.isbn = '5023300' AND d.num_disponibles > 0;

/*
 * 15. Obtener un listado con título y autor de todos los libros de la editorial
 *     CALEIDOSCOPIO.
 */
SELECT l.titulo, a.nombre, a.apellido FROM libro l, autor a, escribe es, editorial ed 
WHERE a.codigo = es.cod_autor AND es.isbn = l.isbn AND l.cod_editorial = ed.codigo AND ed.nombre = 'CALEIDOSCOPIO';

/*
 * 16. Mostrar información sobre los préstamos (título del libro, nombre del autor,
 *     dirección de la sucursal y fechas del préstamo) realizados por el lector PEDRO
 *     CASADO LAFUENTE.
 */
SELECT li.titulo, a.nombre, s.direccion, p.fecha_ini, p.fecha_dev FROM libro li, autor a, escribe e, sucursal s, prestamo p, lector le
WHERE e.cod_autor = a.codigo AND e.isbn = li.isbn AND p.cod_lector = le.codigo AND p.cod_suc = s.codigo
AND le.nombre = 'PEDRO' AND le.ape_1 = 'CASADO' AND le.ape_2 = 'LAFUENTE';

/*
 * 17. Mostrar todos los préstamos realizados (misma información que en el ejercicio
 *     anterior) por los lectores de GUIJUELO.
 */
SELECT li.titulo, a.nombre, s.direccion, p.fecha_ini, p.fecha_dev FROM libro li, autor a, escribe e, sucursal s, prestamo p, lector le
WHERE e.cod_autor = a.codigo AND e.isbn = li.isbn AND p.cod_lector = le.codigo AND p.cod_suc = s.codigo AND le.poblacion = 'GUIJUELO';

/*
 * 18. Mostrar toda la información de los autores (incluir país de origen) que hayan
 *     escrito un libro cuyo título contenga todas las vocales ordenadas
 *     (*A*E*I*O*U*)
 */
SELECT l.titulo, a.nombre, a.apellido, a.ano_nac, a.ano_fall, n.nombre FROM autor a, escribe e, libro l, nacionalidad n
WHERE e.cod_autor = a.codigo AND e.isbn = l.isbn AND a.cod_nacion = n.codigo AND l.titulo LIKE '%A%E%I%O%U%';

SELECT l.titulo, a.nombre, a.apellido, a.ano_nac, a.ano_fall, n.nombre FROM autor a, escribe e, libro l, nacionalidad n
WHERE e.cod_autor = a.codigo AND e.isbn = l.isbn AND a.cod_nacion = n.codigo AND l.titulo LIKE '[^EIOU]%A%[^EIU]%O%[^IU]%E%U%';

/*
 * 19. Mostrar nombre y apellidos de los lectores que han solicitado un préstamo en la
 *     sucursal de PONFERRADA en el año 2011.
 */
SELECT DISTINCT l.nombre, l.ape_1, l.ape_2, p.fecha_ini FROM lector l, prestamo p, sucursal s WHERE p.cod_lector = l.codigo
AND s.poblacion = 'PONFERRADA' AND to_char(fecha_ini, 'yyyy') = 2011;

/*
 * 20. Mostrar el nombre de las editoriales donde ha publicado .FEDERICO
 *     ANDAHAZI.
 */
SELECT ed.nombre, l.titulo, a.nombre, a.apellido FROM editorial ed, libro l, autor a, escribe es WHERE es.cod_autor = a.codigo
AND es.isbn = l.isbn AND l.cod_editorial = ed.codigo AND a.nombre = 'FEDERICO' AND a.apellido = 'ANDAHAZI';

/*
 * 21. Realizar al menos 5 de los ejercicios anteriores, haciendo uso de la operación
 *     JOIN en el FROM.
 */
/* EJERCICIO 1 */
SELECT titulo, nombre, apellido FROM ((libro l JOIN escribe e ON l.isbn = e.isbn) JOIN autor a ON a.codigo = e.cod_autor);

/* EJERCICIO 7 */
SELECT titulo, nombre, apellido FROM (((libro l JOIN escribe es ON l.isbn = es.isbn) JOIN autor a ON es.cod_autor = a.codigo) 
JOIN editorial ed ON l.cod_editorial = ed.codigo AND ed.nombre = 'COSMOS');

/* EJERCICIO 12 */
SELECT DISTINCT nombre, ape_1, ape_2 FROM ((lector le JOIN prestamo p ON le.codigo = p.cod_lector AND p.fecha_ini IS NOT NULL) 
JOIN sucursal s ON s.provincia = 'SALAMANCA');

/* EJERCICIO 15 */
SELECT l.titulo, a.nombre, a.apellido FROM (((libro l JOIN escribe es ON es.isbn = l.isbn) 
JOIN editorial ed ON l.cod_editorial = ed.codigo AND ed.nombre = 'CALEIDOSCOPIO')
JOIN autor a ON es.cod_autor = a.codigo);

/* EJERCICIO 20 */
SELECT ed.nombre, l.titulo, a.nombre, a.apellido FROM (((libro l JOIN escribe es ON es.isbn = l.isbn)
JOIN editorial ed ON l.cod_editorial = ed.codigo) JOIN autor a ON es.cod_autor = a.codigo 
AND a.nombre = 'FEDERICO' AND a.apellido = 'ANDAHAZI');

/*
 * 22. Obtener un listado de los títulos de los libros asignados a la sucursal número 3,
 *     indicando para cada uno de ellos los códigos de los lectores que lo han tenido en
 *     préstamo. El listado deberá incluir los títulos que no han sido prestados y se
 *     presentará ordenado por título.
 */
SELECT DISTINCT li.titulo, le.codigo, p.fecha_ini, p.fecha_dev, s.codigo FROM libro li, prestamo p, lector le, sucursal s, dispone d
WHERE p.cod_lector = le.codigo AND p.cod_suc = s.codigo AND p.isbn = li.isbn AND s.codigo = '3' AND d.num_disponibles >= 0
ORDER BY li.titulo ASC;

/*
 * 23. Obtener un listado de todos los lectores de la provincia de ZAMORA indicando
 *     los libros que actualmente tienen en préstamo (pendiente de devolución). El
 *     listado deberá incluir el nombre del lector, el título del libro prestado y la fecha
 *     de inicio del préstamo. Se listarán igualmente aquellos lectores de la provincia
 *     indicada que no tengan actualmente ningún préstamo activo.
 */
SELECT le.nombre, le.ape_1, le.ape_2, p.fecha_ini, p.fecha_dev, li.titulo FROM libro li, prestamo p, lector le
WHERE le.codigo = p.cod_lector AND p.isbn = li.isbn AND le.provincia = 'ZAMORA' AND p.fecha_ini IS NOT NULL ORDER BY fecha_dev DESC;