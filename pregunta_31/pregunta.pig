/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:CHARARRAY, name2:CHARARRAY, date:Datetime, color:CHARARRAY, cant:int);

YEARS = FOREACH lines GENERATE GetYear(date) AS year_;

grouped = GROUP YEARS BY year_;

year_count = FOREACH grouped GENERATE group, COUNT(YEARS);

-- dump year_count;

STORE year_count INTO 'output' USING PigStorage(',');
