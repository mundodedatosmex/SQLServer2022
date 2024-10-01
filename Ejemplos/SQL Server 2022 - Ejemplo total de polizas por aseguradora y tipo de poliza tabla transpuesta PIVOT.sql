
-- ===================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-30
 Description: Sript que permite resolver la consulta
	   		  "Total de pólizas por aseguradora y tipo de póliza transpuesta"
*/
-- ===================================================================================

SELECT nombre_aseguradora, gastos, VEHICULO, casa, vida 
FROM (
	SELECT *
	FROM (
		-- Generamos el conjunto de datos que alimentará a PIVOT
		SELECT id_aseguradora, 'GASTOS' tipo, id_poliza_ap_gm id
		FROM poliza T1 JOIN poliza_ap_gm T2 ON T1.id_poliza = T2.id_poliza 
		UNION ALL 
		SELECT id_aseguradora, 'VEHICULO', id_poliza_vehiculo
		FROM poliza T1 JOIN poliza_vehiculo T2 ON T1.id_poliza = T2.id_poliza 
		UNION 
		SELECT id_aseguradora, 'CASA', id_poliza_vivienda
		FROM poliza T1 JOIN poliza_vivienda T2 ON T1.id_poliza = T2.id_poliza 
		UNION 
		SELECT id_aseguradora, 'VIDA', id_poliza_vida
		FROM poliza T1 JOIN poliza_vida T2 ON T1.id_poliza = T2.id_poliza 
	) SOURCE 
	PIVOT 
	(	
		COUNT(id) -- Valor que se asignará a la entrada (id_aseguradora,tipo)
		FOR tipo IN (GASTOS,VEHICULO,CASA,VIDA) -- Columnas que se generarám
	) RESULT
) T1 
JOIN 
-- Obtenemos el nombre de la aseguradora 
aseguradora T2 ON T1.id_aseguradora = T2.id_aseguradora; 