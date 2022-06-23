/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- carga de datos desde la carpeta local

-- lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, Col2:CHARARRAY, Col3:CHARARRAY);
-- bag (una colección de tuplas), bolsa que contiene tuplas con un campo se convierte en una tupla
-- MAP A map is a set of key value pairs.
lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, Col2:CHARARRAY, Col3:MAP[]);


Cols3 = FOREACH lines GENERATE Col3;

-- genera una tabla llamada words con una palabra por registro

-- FLATTEN: Aplana tuplas, bolsas y mapas sin anidar.

letters = FOREACH Cols3 GENERATE FLATTEN(Col3) AS letter;

grouped = GROUP letters BY $0;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(letters);

-- dump wordcount;

STORE wordcount INTO 'output' USING PigStorage(',');
