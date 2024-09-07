
-- ===========================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-07
 Description: Sript que permite resolver la consulta
	   		  "Calcular la edad de las personas dada su fecha de nacimiento"
*/
-- ===========================================================================

SELECT	id_persona,
		fecha_nac,
		GETDATE() hoy, 
		-- (1)** Los años que han transcurrido desde el año de nacimiento de la persona al día de hoy
		DATEDIFF(YEAR,fecha_nac,GETDATE()) diferenciaanios_nac_hoy,		
		-- (2)** Fecha en que las personas cumplen años este año
		DATEADD(YEAR,DATEDIFF(YEAR,fecha_nac,GETDATE()), fecha_nac) fechacumpleaniosdeesteanio,  
		
		-- A la diferencia de años entre la fecha de nacimiento y hoy, le tenemos que restar un año en caso de que 
		-- que aún no haya pasado el cumpleaños de la persona este año
		-- Esto es nuevamente (1)**
		DATEDIFF(YEAR,fecha_nac,GETDATE()) - (CASE 
											-- Verificamos que la fecha de cumpleaños no sea mayor a hoy
											-- Esto es nuevamente (2)**
											WHEN DATEADD(YEAR,DATEDIFF(YEAR,fecha_nac,GETDATE()), fecha_nac) > GETDATE() 
												-- Si la fecha de cumpleaños es mayor a hoy, la persona aún no ha
												-- cumplido años y debemos restar 1 a la diferencia de años de (1)**
												THEN 1
												-- Si la fecha de cumpleaños no es mayor a hoym la persona ya cumplió 
												-- años y no debemos restar nada a la diferencia de años de (1)**
												ELSE 0 
												END) Edad 

FROM persona 
WHERE DATEPART(MONTH,fecha_nac) = 9 
ORDER BY fecha_nac;

