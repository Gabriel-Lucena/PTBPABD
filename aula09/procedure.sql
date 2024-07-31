-- Feito no MySql Workbench

-- Stored Procedure para Inserção de Cliente
DELIMITER $$
CREATE PROCEDURE InsertClient (
    IN PesNome VARCHAR(50),
    IN PesCpf VARCHAR(12),
    IN PesStatus INT,
    IN CliRenda DECIMAL(7,2),
    IN CliCredito DECIMAL(7,2)
)
BEGIN
    DECLARE PesCodigo INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    INSERT INTO pessoas (pes_nome, pes_cpf, pes_status) VALUES (PesNome, PesCpf, PesStatus);
    SET PesCodigo = LAST_INSERT_ID();
    INSERT INTO clientes (pes_codigo, cli_renda, cli_credito) VALUES (PesCodigo, CliRenda, CliCredito);
    COMMIT;
END$$
DELIMITER ;

-- Stored Procedure para Inserção de Funcionário
DELIMITER $$
CREATE PROCEDURE InsertEmployee (
    IN PesNome VARCHAR(50),
    IN PesCpf VARCHAR(12),
    IN PesStatus INT,
    IN FunSalario DECIMAL(7,2),
    IN SupCodigo INT
)
BEGIN
    DECLARE PesCodigo INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    INSERT INTO pessoas (pes_nome, pes_cpf, pes_status) VALUES (PesNome, PesCpf, PesStatus);
    SET PesCodigo = LAST_INSERT_ID();
    INSERT INTO funcionarios (pes_codigo, fun_salario, sup_codigo) VALUES (PesCodigo, FunSalario, SupCodigo);
    COMMIT;
END$$
DELIMITER ;

-- Testes das Stored Procedures
-- Teste da Procedure InsertClient
CALL InsertClient('Novo Cliente', '12345678901', 1, 5000.00, 1500.00);

-- Teste da Procedure InsertEmployee
CALL InsertEmployee('Novo Funcionario', '98765432101', 1, 3000.00, NULL);
