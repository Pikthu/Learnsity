INSERT INTO Dim_Fecha (ID_Fecha_CS, Fecha_Completa, Anio, Mes, Trimestre, Nombre_Mes, Semana_Anio, Dia_Anio, Dia_Semana_Numero, Nombre_Dia_Semana, Es_Fin_De_Semana)
SELECT
    DATE_FORMAT(d.dt, '%Y%m%d') AS ID_Fecha_CS,
    d.dt AS Fecha_Completa,
    YEAR(d.dt) AS Anio,
    MONTH(d.dt) AS Mes,
    QUARTER(d.dt) AS Trimestre,
    CASE MONTH(d.dt) 
        WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero' WHEN 3 THEN 'Marzo' WHEN 4 THEN 'Abril' 
        WHEN 5 THEN 'Mayo' WHEN 6 THEN 'Junio' WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto' 
        WHEN 9 THEN 'Septiembre' WHEN 10 THEN 'Octubre' WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre' 
    END AS Nombre_Mes,
    WEEK(d.dt, 1) AS Semana_Anio, -- Se cambió WEEKOFYEAR por WEEK() para mayor compatibilidad. El modo 1 inicia la semana en Lunes.
    DAYOFYEAR(d.dt) AS Dia_Anio,
    DAYOFWEEK(d.dt) AS Dia_Semana_Numero, -- 1=Domingo, 2=Lunes, ..., 7=Sábado
    CASE DAYOFWEEK(d.dt)
        WHEN 1 THEN 'Domingo' WHEN 2 THEN 'Lunes' WHEN 3 THEN 'Martes' WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves' WHEN 6 THEN 'Viernes' WHEN 7 THEN 'Sábado'
    END AS Nombre_Dia_Semana,
    IF(DAYOFWEEK(d.dt) IN (1, 7), 1, 0) AS Es_Fin_De_Semana
FROM (
    -- Generador de fechas corregido.
    -- Se crea una secuencia de números del 0 al 364 y se suma como días a la fecha de inicio.
    -- Esto asegura que no haya saltos en los días.
    SELECT
        DATE_ADD('2025-01-01', INTERVAL seq.n DAY) AS dt
    FROM (
        SELECT
            (t1.i + t2.i * 10 + t3.i * 100) AS n
        FROM
            (SELECT 0 AS i UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS t1
            CROSS JOIN
            (SELECT 0 AS i UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS t2
            CROSS JOIN
            (SELECT 0 AS i UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) AS t3
    ) AS seq
    WHERE DATE_ADD('2025-01-01', INTERVAL seq.n DAY) <= '2025-12-31'
) AS d;