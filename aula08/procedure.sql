-- Feito no MySql Workbench

-- Muda o delimitador para '//' para definir a procedure
DELIMITER //

-- Procedure para Inserção de Pedidos
CREATE PROCEDURE inserir_pedido(
    IN p_ped_data DATETIME,
    IN p_ped_valor DECIMAL(7,2),
    IN p_ped_status INT,
    IN p_fun_codigo INT,
    IN p_cli_codigo INT,
    IN p_est_codigo INT
)
BEGIN
    INSERT INTO pedidos (ped_data, ped_valor, ped_status, fun_codigo, cli_codigo, est_codigo)
    VALUES (p_ped_data, p_ped_valor, p_ped_status, p_fun_codigo, p_cli_codigo, p_est_codigo);
END;
//

-- Procedure para Atualização de Pedidos
CREATE PROCEDURE atualizar_pedido(
    IN p_ped_numero INT,
    IN p_ped_data DATETIME,
    IN p_ped_valor DECIMAL(7,2),
    IN p_ped_status INT,
    IN p_fun_codigo INT,
    IN p_cli_codigo INT,
    IN p_est_codigo INT
)
BEGIN
    UPDATE pedidos
    SET ped_data = p_ped_data,
        ped_valor = p_ped_valor,
        ped_status = p_ped_status,
        fun_codigo = p_fun_codigo,
        cli_codigo = p_cli_codigo,
        est_codigo = p_est_codigo
    WHERE ped_numero = p_ped_numero;
END;
//

-- Procedure para Deleção de Pedidos
CREATE PROCEDURE deletar_pedido(
    IN p_ped_numero INT
)
BEGIN
    DELETE FROM itens_pedidos WHERE ped_numero = p_ped_numero;
    DELETE FROM pedidos WHERE ped_numero = p_ped_numero;
END;
//

-- Restaura o delimitador padrão
DELIMITER ;

-- Consultas de Verificação
-- Testando a procedure de inserção de pedidos
CALL inserir_pedido('2024-07-24 10:00:00', 150.00, 1, 6, 1, 3);
CALL inserir_pedido('2024-07-24 12:00:00', 200.00, 2, 8, 2, 5);

-- Verificando os pedidos inseridos
SELECT * FROM pedidos;

-- Testando a procedure de atualização de pedidos
CALL atualizar_pedido(1, '2024-07-25 10:00:00', 175.00, 2, 6, 1, 3);

-- Verificando os pedidos após a atualização
SELECT * FROM pedidos;

-- Testando a procedure de deleção de pedidos
CALL deletar_pedido(2);

-- Verificando os pedidos após a deleção
SELECT * FROM pedidos;

-- Testando a inserção de itens de pedido para verificar a deleção em cascata
INSERT INTO itens_pedidos (ped_numero, prd_codigo, itp_qtd, itp_valor) VALUES 
(1, 1, 10, 0.80),
(1, 2, 5, 2.50);

-- Verificando os itens de pedidos
SELECT * FROM itens_pedidos;

-- Deletando o pedido com itens associados
CALL deletar_pedido(1);

-- Verificando os pedidos e itens de pedidos após a deleção
SELECT * FROM pedidos;
SELECT * FROM itens_pedidos;
