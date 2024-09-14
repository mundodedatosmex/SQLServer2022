
-- =========================================================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-13
 Description: Sript que permite resolver la consulta
	   		  "Indicar si las p�lizas est�n vigentes o no con d�as de vigencia restantes o d�as que llevan vencidas"
*/
-- =========================================================================================================================


SELECT	id_poliza,
		fecha_fin,
		-- Verificamos si la p�liza a�n est� vigente
		CASE 
			-- En caso de que la fecha fin sea menor a la fecha de hoy, la p�liza venci�
			WHEN fecha_fin < GETDATE() THEN 'Vencida'
			-- En caso de que la fecha fin sea igual o mayor a la fecha de hoy, la p�liza est� vigente
			ELSE 'Vigente'
		END vigencia,
		CASE 
			-- Para p�lizas vencidas, calculamos los d�as que han transcurrido desde la fecha que venci� al d�a de hoy
			WHEN fecha_fin < GETDATE() THEN CONCAT(DATEDIFF(DAY,fecha_fin,GETDATE()),' d�as vencida')
			-- Para p�lizas vigentes, calculamos los d�as que falatan para llegar a la fecha fin desde el d�a de hoy
			ELSE CONCAt(DATEDIFF(DAY,GETDATE(),fecha_fin),' d�as restantes') 
		END dias 
FROM poliza 