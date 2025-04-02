-- Questão 01. Crie uma relação a partir da união das tabelas student e takes
SELECT * from student JOIN takes on student.ID = takes.ID ;

-- Questão 2. Contar a quantidade de cursos realizados pelos alunos do departamento de Civil Eng. 
-- Ordenar de maneira descendente a quantidade de cursos associada aos alunos.
SELECT ID, name, total_courses 
FROM (
    SELECT student.ID, student.name, COUNT(takes.course_id) AS total_courses
    FROM student
    JOIN takes ON student.ID = takes.ID
    WHERE student.dept_name = 'Civil Eng.'
    GROUP BY student.ID, student.name
) AS student_courses
ORDER BY total_courses DESC;

-- Questão 3. Criar uma view chamada 'civil_eng_students' a partir da relação construída na Questão 2.
CREATE VIEW civil_eng_students AS
SELECT ID, name, total_courses 
FROM (
    SELECT student.ID, student.name, COUNT(takes.course_id) AS total_courses
    FROM student
    JOIN takes ON student.ID = takes.ID
    WHERE student.dept_name = 'Civil Eng.'
    GROUP BY student.ID, student.name
) AS student_courses;

SELECT * FROM civil_eng_students ORDER BY total_courses DESC;
