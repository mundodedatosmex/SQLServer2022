
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
		-- (1)** Los a�os que han transcurrido desde el a�o de nacimiento de la persona al d�a de hoy
		DATEDIFF(YEAR,fecha_nac,GETDATE()) diferenciaanios_nac_hoy,		
		-- (2)** Fecha en que las personas cumplen a�os este a�o
		DATEADD(YEAR,DATEDIFF(YEAR,fecha_nac,GETDATE()), fecha_nac) fechacumpleaniosdeesteanio,  
		
		-- A la diferencia de a�os entre la fecha de nacimiento y hoy, le tenemos que restar un a�o en caso de que 
		-- que a�n no haya pasado el cumplea�os de la persona este a�o
		-- Esto es nuevamente (1)**
		DATEDIFF(YEAR,fecha_nac,GETDATE()) - (CASE 
											-- Verificamos que la fecha de cumplea�os no sea mayor a hoy
											-- Esto es nuevamente (2)**
											WHEN DATEADD(YEAR,DATEDIFF(YEAR,fecha_nac,GETDATE()), fecha_nac) > GETDATE() 
												-- Si la fecha de cumplea�os es mayor a hoy, la persona a�n no ha
												-- cumplido a�os y debemos restar 1 a la diferencia de a�os de (1)**
												THEN 1
												-- Si la fecha de cumplea�os no es mayor a hoym la persona ya cumpli� 
												-- a�os y no debemos restar nada a la diferencia de a�os de (1)**
												ELSE 0 
												END) Edad 

FROM persona 
WHERE DATEPART(MONTH,fecha_nac) = 9 
ORDER BY fecha_nac;

