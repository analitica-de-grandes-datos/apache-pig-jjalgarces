/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

-- for_date = FOREACH lines GENERATE GetDay(ToDate(date,'yyyy/MM/dd:HH:mm:ss'));

-- REGEX_EXTRACT (cadena,regex,índice)

col_date = FOREACH lines GENERATE FLATTEN(REGEX_EXTRACT(date, '([0-9]+)-([0-9]+)-([0-9]+)', 2)) AS DATE_;

-- SelecNNull = FILTER col_date BY (date_ is NOT NULL);

--dump col_date;

STORE col_date INTO 'output';
