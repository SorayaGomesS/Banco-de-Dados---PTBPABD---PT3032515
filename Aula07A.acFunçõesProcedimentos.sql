-- Questão 01. Crie um procedimento chamado student_grade_points segundo os critérios abaixo:
-- a. Utilize como parâmetro de entrada o conceito. Exemplo: A+, A-, ...
-- b. Retorne os atributos das tuplas: Nome do estudante, Departamento do estudante, Título do curso, Departamento do curso, Semestre do curso, Ano do curso, Pontuação alfanumérica, Pontuação numérica.
-- c. Filtre as tuplas utilizando o parâmetro de entrada.

CREATE PROCEDURE student_grade_points
    @grade CHAR(2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.name AS Nome_Estudante,
        s.dept_name AS Departamento_Estudante,
        c.title AS Titulo_Curso,
        c.dept_name AS Departamento_Curso,
        t.semester AS Semestre_Curso,
        t.year AS Ano_Curso,
        t.grade AS Pontuacao_Alfanumerica,
        g.points AS Pontuacao_Numerica
    FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    JOIN grade_conversion g ON t.grade = g.grade
    WHERE t.grade = @grade;
END;

-- Questão 02.Crie uma função chamada return_instructor_location segundo os critérios abaixo:
-- a. Utilize como parâmetro de entrada o nome do instrutor.
-- b. Retorne os atributos das tuplas: Nome do instrutor, Curso ministrado, Semestre do curso, Ano do curso, prédio e número da sala na qual o curso foi ministrado
-- c. Exemplo: SELECT * FROM dbo.return_instructor_location('Gustafsson');

CREATE FUNCTION dbo.return_instructor_location(@instructor_name NVARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT 
        i.name AS Nome_Instrutor,
        c.title AS Curso_Ministrado,
        s.semester AS Semestre,
        s.year AS Ano,
        s.building AS Predio,
        s.room_number AS Numero_Sala
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN section s ON t.course_id = s.course_id 
                   AND t.sec_id = s.sec_id 
                   AND t.semester = s.semester 
                   AND t.year = s.year
    JOIN course c ON s.course_id = c.course_id
    WHERE i.name = @instructor_name
);
