
-- =========================================================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-13
 Description: Sript que permite resolver la consulta
	   		  "Indicar si las pólizas están vigentes o no con días de vigencia restantes o días que llevan vencidas"
*/
-- =========================================================================================================================


SELECT	id_poliza,
		fecha_fin,
		-- Verificamos si la póliza aún está vigente
		CASE 
			-- En caso de que la fecha fin sea menor a la fecha de hoy, la póliza venció
			WHEN fecha_fin < GETDATE() THEN 'Vencida'
			-- En caso de que la fecha fin sea igual o mayor a la fecha de hoy, la póliza está vigente
			ELSE 'Vigente'
		END vigencia,
		CASE 
			-- Para pólizas vencidas, calculamos los días que han transcurrido desde la fecha que venció al día de hoy
			WHEN fecha_fin < GETDATE() THEN CONCAT(DATEDIFF(DAY,fecha_fin,GETDATE()),' días vencida')
			-- Para pólizas vigentes, calculamos los días que falatan para llegar a la fecha fin desde el día de hoy
			ELSE CONCAt(DATEDIFF(DAY,GETDATE(),fecha_fin),' días restantes') 
		END dias 
FROM poliza 