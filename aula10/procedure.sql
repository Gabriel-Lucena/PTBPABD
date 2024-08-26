-- Feito no MySql Workbench

USE ptbpabd;

DELIMITER $$

CREATE PROCEDURE Tabuada(IN num INT)
BEGIN
    -- Declaração de variáveis
    DECLARE i INT DEFAULT 0;
    DECLARE resultado INT;
    
    -- Declaração de um manipulador para capturar exceções
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Mensagem de erro
        SELECT 'Erro: número escolhido fora do range aceito' AS Mensagem;
    END;
    
    -- Verificação do intervalo do número
    IF num < 1 OR num > 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Número escolhido fora do range aceito';
    END IF;
    
    -- Criar uma tabela temporária para armazenar os resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS TabuadaTemp (
        Linha VARCHAR(50)
    );
    
    -- Limpar a tabela temporária
    TRUNCATE TABLE TabuadaTemp;
    
    -- Loop WHILE para gerar a tabuada
    WHILE i <= 10 DO
        SET resultado = num * i;
        INSERT INTO TabuadaTemp (Linha) VALUES (CONCAT(num, ' X ', i, ' = ', resultado));
        SET i = i + 1;
    END WHILE;
    
    -- Selecionar todos os resultados da tabela temporária
    SELECT * FROM TabuadaTemp;
    
    -- Limpar a tabela temporária após uso
    DROP TEMPORARY TABLE IF EXISTS TabuadaTemp;
END $$

DELIMITER ;

CALL Tabuada(0);

CALL Tabuada(1);

CALL Tabuada(5);

CALL Tabuada(-1);

CALL Tabuada(10);
