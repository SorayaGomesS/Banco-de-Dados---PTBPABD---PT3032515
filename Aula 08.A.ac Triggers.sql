-- Questão 01.
-- Ao realizar um curso o aluno ganha créditos.
-- Ao eliminar um curso da lista do aluno, os seus créditos totais deverão ser reduzidos.
-- Construa uma Trigger chamada dbo.lost_credits que atualiza o valor de créditos de um aluno após a retirada de um curso da sua lista. 

CREATE TRIGGER lost_credits
ON takes
AFTER DELETE
AS
BEGIN
    UPDATE student
    SET tot_cred = tot_cred - c.credits
    FROM student s
    JOIN deleted d ON s.ID = d.ID
    JOIN course c ON d.course_id = c.course_id;
END;
