/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (id:int, name:chararray, name2:chararray, date:chararray, color:chararray, cant:int);

-- todate_data = foreach lines generate ToDate(date,'yyyy-MM-dd') as (date_time:DateTime);

-- getday_data = foreach todate_data generate(date_time), GetMonth(date_time), GetDay(date_time);


col = FOREACH lines GENERATE date, FLATTEN (SUBSTRING(date, 5, 7)) as mes, FLATTEN (SUBSTRING(date, 5, 7)) as mesN, FLATTEN (SUBSTRING(date, 5, 7)) as mesS;


colR1 = FOREACH col GENERATE date, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(mes, '07', 'jul'), '05', 'may'), '04', 'abr'), '01', 'ene'), '10', 'oct'), '02', 'feb'), '12', 'dic'), '08', 'ago'), mesN, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(mesS, '07', '7'), '05', '5'), '04', '4'), '01', '1'), '10', '10'), '02', '2'), '12', '12'), '08', '8');

-- colR1 = FOREACH col GENERATE date, REPLACE(mes,'7','jul') OR REPLACE(mes,'5','may'); 


-- REPLACE(mes,'5','may'), REPLACE(mes,'4','abr'), REPLACE(mes,'01','ene');

-- dump colR1;

STORE colR1 INTO 'output' USING PigStorage(',');
