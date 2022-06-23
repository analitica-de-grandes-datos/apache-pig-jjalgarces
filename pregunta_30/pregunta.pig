/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:Datetime, color:chararray, cant:int);

-- col = FOREACH lines GENERATE date, FLATTEN (SUBSTRING(date, 8, 10)) as dia, FLATTEN (SUBSTRING(date, 8, 10)) as diaN, FLATTEN (SUBSTRING(date, 8, 10)) as diaS, FLATTEN (SUBSTRING(date, 8, 10)) as diaSS;

-- colR1 = FOREACH col GENERATE date, dia, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(diaN, '08', '8'), '23', '23'), '22', '22'), '29', '29'), '03', '3'), '18', '18'), '05', '5'), '24', '24'), '17', '17'), '28', '28'), '07', '7'), '24', '24'), '27', '27'), '12', '12'), '01', '1'), '11', '11'), '01', '1'), '29', '29'), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(diaS, '08', 'jue'), '23', 'jue'), '22', 'dom'), '29', 'mie'), '03', 'mie'), '18', 'vie'), '05', 'lun'), '24', 'lun'), '17', 'jue'), '28', 'vie'), '07', 'dom'), '24', 'lun'), '27', 'jue'), '12', 'mar'), '01', 'mie'), '11', 'lun'), '01', 'dom'), '29', 'dom'), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(diaSS, '08', 'jueves'), '23', 'jueves'), '22', 'domingo'), '29', 'miercoles'), '03', 'miercoles'), '18', 'viernes'), '05', 'lunes'), '24', 'lunes'), '17', 'jueves'), '28', 'viernes'), '07', 'domingo'), '24', 'lunes'), '27', 'jueves'), '12', 'martes'), '01', 'miercoles'), '11', 'lunes'), '01', 'domingo'), '29', 'domingo');


col = FOREACH lines GENERATE ToString(date, 'yyyy-MM-dd') as f1, ToString(date, 'dd,d') as f2, ToString(date, 'EEE') as d_corto, ToString(date, 'EEEE') as d_largo;

ColS = FOREACH col GENERATE f1, f2, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(d_corto, 'Thu', 'jue'), 'Mon', 'lun'), 'Sun', 'dom'), 'Wed', 'mie'), 'Fri', 'vie'), REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(d_largo, 'Thursday', 'jueves'), 'Monday', 'lunes'), 'Sunday', 'domingo'), 'Wednesday', 'miercoles'), 'Friday', 'viernes');

-- dump ColS;

STORE ColS INTO 'output' USING PigStorage(',');
