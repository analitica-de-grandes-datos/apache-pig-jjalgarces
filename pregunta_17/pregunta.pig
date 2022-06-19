/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname, color 
   FROM 
       u
   WHERE color IN ('blue','black');

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

Col5 = FOREACH lines GENERATE name, color;

filtered_ = FILTER Col5 BY (color MATCHES 'blue') OR (color MATCHES 'black');

-- dump filtered_;

STORE filtered_ INTO 'output' USING PigStorage(',');
