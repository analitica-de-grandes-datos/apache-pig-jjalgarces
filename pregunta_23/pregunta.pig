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
   WHERE 
       color REGEXP '[aeiou]$';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

-- Terminen con vocal
col_color = FOREACH lines GENERATE name, 
                                        FLATTEN(REGEX_EXTRACT_ALL(color, '(.*[aeiou]$)')) 
                                        AS color_;

SelecNNull = FILTER col_color BY (color_ is NOT NULL);

-- dump SelecNNull;
STORE SelecNNull INTO 'output' USING PigStorage(',');
