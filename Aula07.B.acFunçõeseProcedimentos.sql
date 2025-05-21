-- Questão 01. Crie um procedimento denominado salaryHistogram, que distribua as frequências dos salários dos Professores em intervalos (Histograma).
-- O número de intervalos será calculado de acordo com o parâmetro de entrada do procedimento. Exemplo: EXEC dbo.salaryHistogram 5;

CREATE OR ALTER PROCEDURE dbo.salaryHistogram
    @num_intervals INT
AS
BEGIN
    DECLARE @min_salary FLOAT, @max_salary FLOAT, @range FLOAT;
    DECLARE @i INT = 0;
    DECLARE @start_range FLOAT, @end_range FLOAT;

    -- Buscar salários mínimo e máximo
    SELECT @min_salary = MIN(salary), @max_salary = MAX(salary)
    FROM instructor;

    -- Evitar divisão por zero
    IF @min_salary = @max_salary
    BEGIN
        PRINT 'Todos os salários são iguais: ' + CAST(@min_salary AS VARCHAR(20));
        RETURN;
    END

    -- Calcular amplitude dos intervalos
    SET @range = (@max_salary - @min_salary) / @num_intervals;

    -- Tabela temporária para armazenar os dados do histograma
    CREATE TABLE #Histogram (
        valorMinimo FLOAT,
        valorMaximo FLOAT,
        total INT
    );

    -- Laço para preencher os intervalos
    WHILE @i < @num_intervals
    BEGIN
        SET @start_range = @min_salary + @i * @range;
        SET @end_range = @start_range + @range;

        -- Incluir o último limite superior apenas no último intervalo
        IF @i = @num_intervals - 1
        BEGIN
            INSERT INTO #Histogram
            SELECT 
                @start_range, 
                @end_range,
                COUNT(*) 
            FROM instructor
            WHERE salary >= @start_range AND salary <= @end_range;
        END
        ELSE
        BEGIN
            INSERT INTO #Histogram
            SELECT 
                @start_range, 
                @end_range,
                COUNT(*) 
            FROM instructor
            WHERE salary >= @start_range AND salary < @end_range;
        END

        SET @i = @i + 1;
    END

    -- Retorna a tabela com os dados 
    SELECT 
        FORMAT(valorMinimo, 'N3') AS valorMinimo,
        FORMAT(valorMaximo, 'N3') AS valorMaximo,
        total
    FROM #Histogram;

    DROP TABLE #Histogram;
END;


EXEC dbo.salaryHistogram 5;
