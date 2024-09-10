-- =======================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-08-27
 Description: Sript que permite resolver la consulta
	   		  "Total de correos electrónicos por dominio"
*/
-- =======================================================

-- Agrupo y cuento el total de correos por dominio 
SELECT dominio, COUNT(correo) total
FROM (
	SELECT	correo, -- Valor original del correo electrónico
			CHARINDEX('@',correo) posicion, -- Posición en la que se encuentra la @ dentro del valor de correo 
			LEN(correo) longitud,	-- Longitud del valor de correo
			LEN(correo) - CHARINDEX('@',correo) longitudsubcadena,  -- Longitud de la subcadena que debo obtener

			-- Extraigo una subcadena desde la posición siguiente de la @ y hasta el final del valor original de la cadena
			SUBSTRING(correo, CHARINDEX('@',correo) + 1 , LEN(correo) - CHARINDEX('@',correo)) dominio 

	FROM persona 
) T1 
GROUP  BY dominio; 