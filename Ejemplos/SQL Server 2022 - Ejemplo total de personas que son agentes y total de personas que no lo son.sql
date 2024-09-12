-- =====================================================================================
/*
 Author: MundoDeDatosMex
 Create date: 2024-09-11
 Description: Sript que permite resolver la consulta
	   		  "Total de personas que son agentes y total de personas que no lo son"
*/
-- =====================================================================================

-- Caso 1 UNION 
-- Contamos las personas que no han sido agentes y las etiqueto
SELECT COUNT(persona.id_persona) Total, 'NO SON AGENTES' Tipo_Persona
FROM persona LEFT JOIN agente ON persona.id_persona = agente.id_persona 
WHERE id_agente IS NULL 
UNION 
-- Contamos las personas que han sido agentes y las etiqueto
SELECT COUNT(persona.id_persona), 'AGENTES'
FROM persona LEFT JOIN agente ON persona.id_persona = agente.id_persona 
WHERE id_agente IS NOT NULL 
UNION 
-- Contamos las personas únicas que han sido agentes y las etiqueto
SELECT COUNT(DISTINCT(persona.id_persona)), 'PERSONAS AGENTES'
FROM persona LEFT JOIN agente ON persona.id_persona = agente.id_persona 
WHERE id_agente IS NOT NULL 


-- Caso 2 CASE y GROUP BY 
-- Contamos personas totales y personas únicas dada su clasificación
SELECT clasificacion,COUNT(id_persona) total_personas,COUNT(DISTINCT(id_persona)) total_persona_unicas
FROM (
	-- Clasificamos a las personas entre si han sido o no agentes 
	SELECT CASE
				WHEN id_agente IS NULL THEN 'NO AGENTE'
				ELSE 'AGENTE'
		   END clasificacion,
		   persona.id_persona 
	FROM persona LEFT JOIN agente ON persona.id_persona = agente.id_persona 
) T1 
GROUP BY clasificacion