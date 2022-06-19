/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, B1_2:BAG{T1:TUPLE(Col2:CHARARRAY)}, Col3:MAP[]);

rows = FOREACH lines GENERATE FLATTEN(B1_2) AS letter, FLATTEN(Col3) AS key;

groupep = GROUP rows BY (letter, key);

result = FOREACH groupep GENERATE group, COUNT(rows);

-- dump result; 

STORE wordcount INTO 'output' USING PigStorage(',');
