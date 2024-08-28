-- =======================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-08-27
 Description: Sript que permite resolver la consulta
	   		  "De qué color tengo más prendas"
*/
-- =======================================================

-- De qué color tengo más prendas 
/*
1	cuántas prendas tengo por color
2	cuál total es el mayor 
3	qué color/es tiene/n o corresponde/n con el total encontrado en 2
*/ 

-- 3 Identifico el color del que existe un total de prendas igual que el mayor identificado
SELECT color 
FROM closet 
GROUP BY color 
HAVING COUNT(Idprenda) = (	-- 2 Obtengo el mayor de los totales de prendas por color
							SELECT MAX(total) 
							FROM (
								-- 1 genero una tabla con el total de prendas por color
								SELECT color,COUNT(IdPrenda) total 
								FROM closet 
								GROUP BY color 
								) T1
							)