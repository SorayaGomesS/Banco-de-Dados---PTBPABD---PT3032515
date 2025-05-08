-- Questão 01. Crie as contas de usuário User_A, User_B, User_C, User_D e User_E.
CREATE LOGIN User_A WITH PASSWORD = 'SorayaGomes12@';
CREATE LOGIN User_B WITH PASSWORD = 'SorayaGomes12@';
CREATE LOGIN User_C WITH PASSWORD = 'SorayaGomes12@';
CREATE LOGIN User_D WITH PASSWORD = 'SorayaGomes12@';
CREATE LOGIN User_E WITH PASSWORD = 'SorayaGomes12@';

CREATE USER User_A FOR LOGIN User_A;
CREATE USER User_B FOR LOGIN User_B;
CREATE USER User_C FOR LOGIN User_C;
CREATE USER User_D FOR LOGIN User_D;
CREATE USER User_E FOR LOGIN User_E;

-- Questão 02. Considere o esquema de banco de dados relacional university.
-- O User_A poderá selecionar ou modificar qualquer relação, exceto CLASSROOM, e pode conceder qualquer um desses privilégios a outros usuários.
USE PTBPABD;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON student TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON advisor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON instructor TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON department TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON course TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON prereq TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON section TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON teaches TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON takes TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON pessoa TO User_A WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON endereco TO User_A WITH GRANT OPTION;

-- Questão 03. Liste as permissões do User_A.
USE PTBPABD;
GO

SELECT 
    princ.name AS Usuario,
    perm.permission_name AS Permissao,
    perm.state_desc AS Tipo_de_Permissao,
    obj.name AS Objeto
FROM 
    sys.database_permissions AS perm
JOIN 
    sys.database_principals AS princ ON perm.grantee_principal_id = princ.principal_id
LEFT JOIN 
    sys.objects AS obj ON perm.major_id = obj.object_id
WHERE 
    princ.name = 'User_A';
