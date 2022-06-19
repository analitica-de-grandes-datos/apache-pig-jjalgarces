/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

Col5 = FOREACH lines GENERATE color;

filtered_color = FILTER Col5 BY NOT (color MATCHES '.*[b].*');

-- dump filtered_color;

STORE filtered_color INTO 'output';
