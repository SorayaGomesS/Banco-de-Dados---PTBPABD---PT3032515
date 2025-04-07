-- Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção. Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.
SELECT 
    instructor.ID, 
    instructor.name, 
    COUNT(teaches.course_id) AS num_sections
FROM instructor
LEFT OUTER JOIN teaches ON instructor.ID = teaches.ID
GROUP BY instructor.ID, instructor.name

-- Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.
SELECT 
    ID,
    name,
    (
        SELECT COUNT(*) 
        FROM teaches 
        WHERE teaches.ID = instructor.ID
    ) AS num_sections
FROM instructor

-- Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, junto com o nome dos instrutores ministrando a seção. Se uma seção tiver mais de 1 instrutor, ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum, ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.
SELECT 
    section.course_id,
    section.sec_id,
    teaches.ID AS instructor_ID,
    section.semester,
    section.year,
    ISNULL(instructor.name, '-') AS name
FROM section
LEFT JOIN teaches 
    ON section.course_id = teaches.course_id 
    AND section.sec_id = teaches.sec_id
    AND section.semester = teaches.semester 
    AND section.year = teaches.year
LEFT JOIN instructor 
    ON teaches.ID = instructor.ID
WHERE section.semester = 'Spring'
  AND section.year = 2010;

-- Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma conversão de conceitos (letras) na relação takes para notas numéricas; por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos, um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 
Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como o número de créditos para o curso multiplicado pelos pontos numéricos para a nota que o aluno recebeu.
Dada essa relação e o nosso esquema university, escreva: 
Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.
CREATE TABLE grade_points (
    grade VARCHAR(2) PRIMARY KEY,
    points DECIMAL(3,1)
);

INSERT INTO grade_points (grade, points) VALUES
('A+', 4.0),
('A', 3.7),
('A-', 3.4),
('B+', 3.1),
('B', 2.8),
('B-', 2.5),
('C+', 2.2),
('C', 2.0),
('C-', 1.7),
('D', 1.0),
('F', 0.0);

SELECT 
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    t.grade,
    gp.points,
    c.credits,
    gp.points * c.credits AS pontos_totais
FROM takes t
JOIN student s ON t.ID = s.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade

-- Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”.
CREATE VIEW coeficiente_rendimento AS
SELECT 
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    t.grade,
    gp.points,
    c.credits,
    gp.points * c.credits AS pontos_totais
FROM takes t
JOIN student s ON t.ID = s.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade;

SELECT * FROM coeficiente_rendimento;
