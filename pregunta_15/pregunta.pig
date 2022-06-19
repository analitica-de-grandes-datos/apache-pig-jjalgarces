/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

Col5 = FOREACH lines GENERATE name, color;

-- Col5 = FOREACH lines GENERATE CONCAT (name, '@', color);

filtered_color = FILTER Col5 BY (color MATCHES 'blue');
filtered_name = FILTER filtered_color BY (name MATCHES '.*[Z].*');

-- B = FOREACH lines GENERATE CONCAT (name, '@', name2);

-- dump filtered_name;

STORE filtered_color INTO 'output';
