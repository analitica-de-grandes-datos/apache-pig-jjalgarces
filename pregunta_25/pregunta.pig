/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT  
       firstname,
       SUBSTRING_INDEX(firstname, 'a', 1)
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

-- SUBSTRING_INDEX: Return a substring of a string before a specified number of delimiter occurs

-- INDEXOF:It returns the first occurrence of the given character in the string, searching forward from the given index

-- col = FOREACH lines GENERATE SUBSTRING (name, 0, 1);

col = FOREACH lines GENERATE INDEXOF(name, 'a', 1);

-- dump col;

STORE col INTO 'output';
