/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- carga de datos desde la carpeta local

lines = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:int);

Col3 = FOREACH lines GENERATE number; 

Col3 = DISTINCT Col3;

-- selecciona las primeras 5 palabras
s = LIMIT Col3 5;

-- dump s;

STORE list_orden INTO 'output' USING PigStorage(',');
