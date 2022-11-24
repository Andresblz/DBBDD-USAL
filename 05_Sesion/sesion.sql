/* EJERCICIOS PROPUESTOS - SESION 5 */

/*
 * 1. Listar el nombre y apellidos de todos los lectores de la provincia de Cáceres que
 *    tienen una fecha de nacimiento anterior a la de
 *      a. alguno de los lectores de la provincia de Zamora.
 *      b. cualquiera de los lectores de la provincia de Zamora
 */
SELECT nombre, ape_1, ape_2 FROM lector WHERE provincia = 'CACERES' AND to_char(fecha_nac, 'yyyymmdd') < ANY
(SELECT to_char(fecha_nac, 'yyyymmdd') FROM lector WHERE provincia = 'ZAMORA') ORDER BY 1;

SELECT nombre, ape_1, ape_2 FROM lector WHERE provincia = 'CACERES' AND to_char(fecha_nac, 'yyyymmdd') < ALL
(SELECT to_char(fecha_nac, 'yyyymmdd') FROM lector WHERE provincia = 'ZAMORA') ORDER BY 1;

/*
 * 2. Lectores que hayan nacido en una fecha posterior a la de todos los autores (1975).
 */ 
SELECT nombre, ape_1, ape_2 FROM lector
WHERE to_char(fecha_nac, 'yyyy') > ANY (SELECT ano_nac FROM autor) ORDER BY 1;

/*
 * 3. Autores de la nacionalidad de ISABEL ALLENDE y que hayan nacido en el mismo
 *    año que CARMEN POSADAS.
 */
SELECT nombre, apellido FROM autor
WHERE cod_nacion = (SELECT cod_nacion FROM autor WHERE nombre = 'ISABEL' AND apellido = 'ALLENDE')
AND ano_nac = (SELECT ano_nac FROM autor WHERE nombre = 'CARMEN' AND apellido = 'POSADAS');

/*
 * 4. Autores que hayan nacido en una fecha posterior a alguno de los lectores. (1987)
 */
SELECT nombre, apellido, ano_nac FROM autor
WHERE ano_nac > ANY (SELECT to_char(fecha_nac, 'yyyy') FROM lector) ORDER BY 1;

/*
 * 5. Datos de la sucursal/sucursales que tiene el mayor número de préstamos.
 */
SELECT * FROM sucursal WHERE codigo IN
(SELECT cod_suc FROM prestamo GROUP BY cod_suc HAVING COUNT(codigo) =
(SELECT MAX(COUNT(codigo)) FROM prestamo GROUP BY cod_lector));

/*
 * 6. Datos del/los lector/s que realizó durante el año pasado el mayor número de
 *    préstamos
 */
SELECT * FROM lector
WHERE codigo IN (SELECT cod_lector FROM prestamo GROUP BY cod_lector
HAVING COUNT(codigo) = (SELECT MAX(count(codigo)) FROM prestamo GROUP BY cod_lector));

/*
 * 7. Obtener el listado del autor/es con más libros, indicando el número.
 */
SELECT cod_autor, nombre, apellido, count(e.isbn) FROM autor a, escribe e
WHERE a.codigo = cod_autor GROUP BY cod_autor, nombre, apellido
HAVING COUNT(e.isbn) = (SELECT MAX(count(e.isbn)) FROM escribe e GROUP BY cod_autor)

/*
 * 8. Datos del lector de más edad de la red de bibliotecas.
 */
SELECT * FROM lector WHERE fecha_nac >= all (SELECT fecha_nac FROM lector);

/*
 * 9. Datos de los lectores de más edad de cada provincia.
 */
SELECT * FROM lector l1
WHERE fecha_nac >= all (SELECT fecha_nac FROM lector l2 WHERE l1.provincia=l2.provincia);

/*
 * 10. Verifique si existe algún libro que no haya sido nunca cogido en préstamo en alguna
 *     sucursal. Si existe proporcione título del libro y la sucursal/es a la que pertenece.
 */
SELECT * FROM dispone
WHERE isbn IN (SELECT isbn FROM libro l
WHERE NOT EXISTS (SELECT * FROM prestamo WHERE isbn = l.isbn));

/*
 * 11. Verifique si existe algún libro que no haya sido nunca cogido en préstamo en
 *     ninguna sucursal. Si existe proporcione título del libro.
 */
SELECT distinct titulo FROM libro l, dispone d
WHERE l.isbn = d.isbn AND NOT EXISTS (SELECT * FROM prestamo p WHERE p.isbn=d.isbn);

/*
 * 12. Nombre de los autores más antiguos de su nacionalidad, indicando el autor y la
 *     nacionalidad.
 */
SELECT n.nombre, a.nombre, a.apellido FROM autor a join nacionalidad n on n.codigo = a.cod_nacion
WHERE ano_nac <= ALL (SELECT ano_nac FROM autor aa WHERE a.cod_nacion = aa.cod_nacion) ORDER BY 1;

/*
 * 13. Presentar un listado de sucursales indicando el libro que más ejemplares tiene.
 */
SELECT cod_suc, titulo FROM libro l, dispone d1
WHERE l.isbn = d1.isbn AND num_ejemplares = (SELECT MAX(num_ejemplares) FROM dispone d2
WHERE d1.cod_suc = d2.cod_suc);

/*
 * 14. Presentar un listado de todos los lectores que no hayan realizado préstamos.
 */
SELECT * FROM lector l WHERE NOT EXISTS (SELECT * FROM prestamo WHERE l.codigo = cod_lector);

/*
 * 15. Obtener las localidades en las que viven lectores y no existan sucursales.
 */
SELECT l.poblacion FROM lector l WHERE NOT EXISTS (SELECT * FROM sucursal s WHERE s.poblacion = l.poblacion);

/*
 * 16. Nombre de los lectores que han obtenido préstamos en todas las sucursales.
 */
SELECT nombre, ape_1, ape_2 FROM lector l
WHERE NOT EXISTS (SELECT * FROM dispone d
WHERE NOT EXISTS (SELECT * FROM prestamo p
WHERE p.cod_suc = d.cod_suc AND p.cod_lector = l.codigo));

/*
 * 17. Nombre de los lectores que han obtenido préstamos en todas las sucursales de su
 *     provincia de residencia.
 */
SELECT nombre, ape_1, ape_2 FROM lector l
WHERE NOT EXISTS (SELECT * FROM sucursal s
WHERE s.provincia = l.provincia AND NOT EXISTS(SELECT * FROM prestamo p
WHERE p.cod_lector = l.codigo AND s.codigo = p.cod_suc));

/*
 * 18. Listar los ISBN de los libros disponibles en la sucursal 5 en un nº superior al del
 *     libro con ISBN 5024392.
 */
SELECT isbn FROM dispone d
WHERE num_disponibles > 0 AND cod_suc = 5 AND num_disponibles > (SELECT num_disponibles FROM dispone
WHERE isbn = 5024392 AND cod_suc = 5);

/*
 * 19. Presentar un listado de los lectores que tienen más préstamos en cada sucursal
 *     indicando el número de préstamos realizados ordenado por sucursal y listado
 *     alfabético de apellidos y nombre de dichos lectores.
 */
SELECT cod_suc, nombre, ape_1, ape_2, count(p1.codigo) FROM lector l, prestamo p1
WHERE l.codigo = cod_lector GROUP BY nombre, ape_1, ape_2, cod_suc
HAVING COUNT(p1.codigo) = (SELECT MAX(count(codigo)) FROM prestamo p2
WHERE p1.cod_suc = p2.cod_suc GROUP BY cod_lector) ORDER BY cod_suc, ape_1, ape_2, nombre;