-- ===================================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-05
 Description: Sript que permite resolver la consulta
	   		  "Clasificador basado en la cantidad total pagada por poliza y por el promedio de esta"
*/
-- ===================================================================================================

/*
Poliza C  - del 25% del promedio 
Poliza B  25% del promedio al promedio + 25% del promedio 
Poliza A  + del promedio + 25%


	Poliza C		|			Poliza B		|			Poliza A
$0.01	->    - 25% del promedio			
				25% del promedio			promedio + 25%				
											+ promedio + 25%			$n


20 pesos = 1 dólar
*/

SELECT id_poliza,	CASE
						WHEN totalpesos < (promedio * .25) THEN 'Poliza C' 
						WHEN totalpesos >= (promedio * .25) AND totalpesos <= (promedio * 1.25) THEN 'Poliza B' 
						WHEN totalpesos > (promedio * 1.25) THEN 'Poliza A' 
					END clasificacion,
		totalpesos, 
		promedio,
		promedio * .25 clasificacionc, 
		promedio * 1.25 clasificacionb
FROM (
	-- Consulta base + columna promedio calculada
	SELECT id_poliza,SUM(montopesos) totalpesos, (
													-- Calculo del promedio 
													SELECT AVG(totalpesos) promedio 
													FROM (
														-- Consulta base, obtengo el monto pagado por poliza
														SELECT id_poliza,SUM(montopesos) totalpesos
														FROM (
															-- Calculamos cantidades en pesos mexicanos
															SELECT id_pago, id_poliza, cantidad, CASE 
																									WHEN pago.id_cmoneda = 1 THEN cantidad * 20 
																									WHEN pago.id_cmoneda = 2 THEN cantidad 
																									ELSE 0 
																								 END montopesos 
															FROM pago JOIN cmoneda ON pago.id_cmoneda = cmoneda.id_cmoneda
															) T1 
														GROUP BY id_poliza 
														-- Consulta base
														) T2 
													-- Calculo del promedio 
												 ) promedio 
	FROM (
		-- Calculamos cantidades en pesos mexicanos 
		SELECT id_pago, id_poliza, cantidad, CASE 
												WHEN pago.id_cmoneda = 1 THEN cantidad * 20 
												WHEN pago.id_cmoneda = 2 THEN cantidad 
												ELSE 0 
											 END montopesos 
		FROM pago JOIN cmoneda ON pago.id_cmoneda = cmoneda.id_cmoneda
		) T1 
	GROUP BY id_poliza 
	-- Consulta base + columna promedio calculada
) T2


