
-- =============================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-19
 Description: Sript que permite resolver la consulta
	   		  "Fecha de pago y monto del primer pago a cada póliza"
*/
-- =============================================================================

SELECT * 
FROM (
	SELECT	id_poliza,
			fecha_pago,
			cantidadpesos, 
			-- Asignamos una secuencia a los pagos de cada póliza, ordenados por la fecha en que se realizaron
			ROW_NUMBER() OVER(PARTITION BY id_poliza ORDER BY fecha_pago) orden 
	FROM pago  
	-- Confirmamos que el pago ya se realizó
	WHERE realizado = 1 
) T1 
-- Nos quedamos solo con el primer pago registrado para cada póliza
WHERE orden = 1; 