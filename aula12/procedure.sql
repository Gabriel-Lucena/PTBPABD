-- Feito no MySql Workbench

DELIMITER //

-- Procedimento armazenado sp_inserir_massa para inserir dados de teste
CREATE PROCEDURE sp_inserir_massa(IN opcao INT)
BEGIN
    DECLARE i INT DEFAULT 1;  -- Variável de controle para o loop
    DECLARE erro BOOLEAN DEFAULT FALSE;  -- Variável para verificar se houve erro

    -- Início da transação
    START TRANSACTION;

    -- Tratamento de erros: Se ocorrer um erro, fazer ROLLBACK
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET erro = TRUE;
        ROLLBACK;
    END;

    -- Bloco principal do procedimento
    IF opcao = 1 THEN
        -- Inserir 5 funcionários
        WHILE i <= 5 DO
            -- Inserindo na tabela pessoas
            INSERT INTO pessoas (pes_nome, pes_cpf, pes_status) 
            VALUES (CONCAT('Funcionario ', i), CONCAT('CPF', i), 1);
            
            -- Inserindo na tabela funcionarios com referência à pessoa inserida
            INSERT INTO funcionarios (pes_codigo, fun_salario, sup_codigo) 
            VALUES (LAST_INSERT_ID(), 1000.00 + (i * 100), NULL);
            
            SET i = i + 1;  -- Incrementa o contador do loop
        END WHILE;

    ELSEIF opcao = 2 THEN
        -- Inserir 5 clientes
        WHILE i <= 5 DO
            -- Inserindo na tabela pessoas
            INSERT INTO pessoas (pes_nome, pes_cpf, pes_status) 
            VALUES (CONCAT('Cliente ', i), CONCAT('CPF', i), 1);
            
            -- Inserindo na tabela clientes com referência à pessoa inserida
            INSERT INTO clientes (pes_codigo, cli_renda, cli_credito) 
            VALUES (LAST_INSERT_ID(), 5000.00 + (i * 1000), 1000.00 + (i * 500));
            
            SET i = i + 1;  -- Incrementa o contador do loop
        END WHILE;

    ELSE
        -- Opção inválida: Gera um erro
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Opção inválida';

    END IF;

    -- Verifica se houve algum erro; se não, faz commit, senão rollback
    IF erro = FALSE THEN
        COMMIT;
    END IF;
END//

DELIMITER ;
