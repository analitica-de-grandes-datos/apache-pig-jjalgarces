/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

constr = FOREACH lines GENERATE name2, COUNT(TOKENIZE(REPLACE(name2,'',' '))) AS Cant_C2;

list_orden = ORDER constr BY Cant_C2 DESC, name2 ASC;

list_orden2 = LIMIT list_orden 5;

-- dump list_orden2; 

STORE list_orden2 INTO 'output' USING PigStorage(',');
