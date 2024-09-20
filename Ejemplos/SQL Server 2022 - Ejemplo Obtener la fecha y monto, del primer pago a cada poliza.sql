
-- =============================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-19
 Description: Sript que permite resolver la consulta
	   		  "Fecha de pago y monto del primer pago a cada p�liza"
*/
-- =============================================================================

SELECT * 
FROM (
	SELECT	id_poliza,
			fecha_pago,
			cantidadpesos, 
			-- Asignamos una secuencia a los pagos de cada p�liza, ordenados por la fecha en que se realizaron
			ROW_NUMBER() OVER(PARTITION BY id_poliza ORDER BY fecha_pago) orden 
	FROM pago  
	-- Confirmamos que el pago ya se realiz�
	WHERE realizado = 1 
) T1 
-- Nos quedamos solo con el primer pago registrado para cada p�liza
WHERE orden = 1; 