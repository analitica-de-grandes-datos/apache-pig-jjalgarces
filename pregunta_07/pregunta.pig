/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lines = LOAD 'data.tsv' AS (Col1:CHARARRAY, B1_2:BAG{T1:TUPLE(Col2:CHARARRAY)}, Col3:MAP[]);

-- Cols1 = FOREACH lines GENERATE Col1;

-- B = GROUP lines BY Col1;

constr = FOREACH lines GENERATE Col1, COUNT(B1_2) AS Cant_C2, COUNT(KEYSET(Col3)) AS Cant_C3;

result = ORDER constr BY Col1, Cant_C2, Cant_C3 ASC;

--dump result;

STORE result INTO 'output' USING PigStorage(',');
