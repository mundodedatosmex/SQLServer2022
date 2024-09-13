-- =============================================================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-12
 Description: Sript que permite resolver la consulta
	   		  "Porcentaje que representa cada pago a una póliza respecto al monto total que se ha pagado por la póliza"
*/
-- =============================================================================================================================

SELECT	T1.id_pago, 
		T1.id_poliza,
		T1.fecha_pago,
		T1.cantidadpesos,
		T2.totalpoliza,
		(T1.cantidadpesos * 100) / T2.totalpoliza porcentaje -- Calculo el porcentaje con una regla de 3 
FROM (
	-- Obtengo el id de pago que se ha realizado a qué póliza (id_poliza), el monto en pesos del pago y la fecha en que se realizó el pago
	SELECT	id_pago,
			id_poliza,
			cantidadpesos,
			fecha_pago
	FROM pago
	) T1 
	-- Ambas tablas tienen el atributo id_poliza
	JOIN 
	(
	-- Obtengo el total que se ha pagado para cada una de las pólizas (agrupo por id_poliza)
	SELECT	id_poliza,
			SUM(cantidadpesos) totalpoliza 
	FROM pago 
	GROUP BY id_poliza
	) T2 ON T1.id_poliza = T2.id_poliza -- Relaciono mis tablas resultado a través de id_poliza
ORDER BY T1.id_poliza , T1.fecha_pago
