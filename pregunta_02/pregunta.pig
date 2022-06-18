/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/


-- carga de datos desde la carpeta local

lines = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:int);

-- Se ordena la data
list_orden = ORDER lines BY letter, number ASC;

-- dump list_orden;
STORE list_orden INTO 'output' USING PigStorage(',');
