/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- carga de datos desde la carpeta local

-- lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, Col2:CHARARRAY, Col3:CHARARRAY);
-- bag (una colección de tuplas), bolsa que contiene tuplas con un campo se convierte en una tupla
lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, B1_2:BAG{T1:TUPLE(Col2:CHARARRAY)}, Col3:CHARARRAY);


Cols2 = FOREACH lines GENERATE B1_2;

-- genera una tabla llamada words con una palabra por registro
letters = FOREACH Cols2 GENERATE FLATTEN(B1_2) AS letter;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP letters BY letter;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(letters);

-- dump wordcount;

STORE wordcount INTO 'output' USING PigStorage(',');
