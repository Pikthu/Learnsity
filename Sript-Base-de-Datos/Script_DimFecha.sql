USE dbLearnsityMultidimensional; -- Asegúrate de estar en la base de datos correcta
GO

-- ===================================================================================
-- SCRIPT PARA POBLAR AUTOMÁTICAMENTE LA TABLA Dim_Fecha
-- ===================================================================================

-- -----------------------------------------------------------------------------------
-- Configuración del Rango de Fechas
-- Modifica estas fechas según tus necesidades.
-- -----------------------------------------------------------------------------------
DECLARE @FechaInicio DATE = '2025-01-01'; -- Fecha desde la cual se generarán los registros
DECLARE @FechaFin DATE = '2025-12-31';   -- Fecha hasta la cual se generarán los registros

-- -----------------------------------------------------------------------------------
-- Configuración Regional para Nombres de Días y Meses
-- Establece el Lunes como el primer día de la semana. Esto es importante para
-- DATEPART(dw, ...) donde Lunes=1, Martes=2, ..., Domingo=7.
-- -----------------------------------------------------------------------------------
SET DATEFIRST 1;

-- -----------------------------------------------------------------------------------
-- Generación de Fechas e Inserción en Dim_Fecha
-- Se utiliza una Expresión Común de Tabla (CTE) Recursiva para generar
-- cada día dentro del rango especificado.
-- -----------------------------------------------------------------------------------
PRINT 'Iniciando la población de Dim_Fecha...';

WITH FechasCTE AS (
    -- Punto de anclaje: la fecha de inicio
    SELECT @FechaInicio AS FechaActual
    UNION ALL
    -- Parte recursiva: añade un día a la fecha anterior hasta alcanzar la fecha fin
    SELECT DATEADD(day, 1, FechaActual)
    FROM FechasCTE
    WHERE DATEADD(day, 1, FechaActual) <= @FechaFin
)
-- Insertar los datos calculados en la tabla Dim_Fecha
INSERT INTO Dim_Fecha (
    ID_Fecha_CS,
    Fecha_Completa,
    Anio,
    Mes,
    Trimestre,
    Nombre_Mes,
    Semana_Anio,
    Dia_Anio,
    Dia_Semana_Numero,
    Nombre_Dia_Semana,
    Es_Fin_De_Semana
)
SELECT
    CONVERT(INT, FORMAT(cte.FechaActual, 'yyyyMMdd')) AS ID_Fecha_CS, -- Clave en formato AAAAMMDD
    cte.FechaActual AS Fecha_Completa,
    YEAR(cte.FechaActual) AS Anio,
    MONTH(cte.FechaActual) AS Mes,
    DATEPART(QUARTER, cte.FechaActual) AS Trimestre,
    -- Para nombres en español, usamos 'es-PE' (Español - Perú).
    -- Si 'es-PE' no está disponible en tu servidor, puedes probar con 'es-ES' (Español - España).
    FORMAT(cte.FechaActual, 'MMMM', 'es-PE') AS Nombre_Mes,
    DATEPART(ISO_WEEK, cte.FechaActual) AS Semana_Anio, -- Semana según el estándar ISO 8601
    DATEPART(DAYOFYEAR, cte.FechaActual) AS Dia_Anio,
    DATEPART(dw, cte.FechaActual) AS Dia_Semana_Numero, -- Con DATEFIRST 1: Lunes=1, ..., Domingo=7
    FORMAT(cte.FechaActual, 'dddd', 'es-PE') AS Nombre_Dia_Semana,
    CASE
        WHEN DATEPART(dw, cte.FechaActual) IN (6, 7) THEN 1 -- Sábado (6) o Domingo (7)
        ELSE 0
    END AS Es_Fin_De_Semana
FROM FechasCTE cte
WHERE NOT EXISTS ( -- Condición para evitar insertar fechas duplicadas si el script se ejecuta más de una vez
    SELECT 1
    FROM Dim_Fecha df
    WHERE df.ID_Fecha_CS = CONVERT(INT, FORMAT(cte.FechaActual, 'yyyyMMdd'))
)
OPTION (MAXRECURSION 0); -- Establece el número máximo de recursiones a ilimitado (0).
                         -- Esencial para rangos de fechas largos. El valor por defecto es 100.

-- -----------------------------------------------------------------------------------
-- Mensajes de Finalización y Verificación
-- -----------------------------------------------------------------------------------
DECLARE @TotalFechasInsertadas INT;
SET @TotalFechasInsertadas = @@ROWCOUNT; -- Captura el número de filas afectadas por el último INSERT

PRINT 'Población de Dim_Fecha completada.';
PRINT 'Rango de fechas procesado: ' + CONVERT(VARCHAR, @FechaInicio, 103) + ' a ' + CONVERT(VARCHAR, @FechaFin, 103);
PRINT 'Total de fechas nuevas insertadas: ' + CONVERT(VARCHAR, @TotalFechasInsertadas);

-- Puedes descomentar la siguiente línea para ver una muestra de los datos insertados:
-- SELECT TOP 10 * FROM Dim_Fecha ORDER BY ID_Fecha_CS DESC;
GO