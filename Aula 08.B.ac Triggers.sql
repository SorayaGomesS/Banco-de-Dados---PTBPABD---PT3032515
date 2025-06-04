-- Crie uma Trigger denominada dbo.trigger_prevent_assignment_teaches para impedir que aulas sejam atribuidas a um instrutor que já possui 2 ou mais atribuições no ano.

CREATE TRIGGER dbo.trigger_prevent_assignment_teaches
ON teaches
INSTEAD OF INSERT
AS
BEGIN
    -- Verifica se algum dos professores da inserção já tem 2 ou mais aulas no ano
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN teaches t ON i.ID = t.ID AND i.year = t.year
        GROUP BY i.ID, i.year
        HAVING COUNT(*) + COUNT(t.course_id) > 2
    )
    BEGIN
        RAISERROR ('Esse instrutor já possui 2 ou mais aulas atribuídas nesse ano.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Se estiver tudo certo, realiza a inserção normalmente
        INSERT INTO teaches (ID, course_id, sec_id, semester, year)
        SELECT ID, course_id, sec_id, semester, year FROM inserted;
    END
END;
