-- Feito no MySQL Workbench

-- Criação da view

CREATE VIEW VW_PEDIDOS AS
SELECT 
    p.ped_numero AS Numero_Pedido,
    p.ped_data AS Data_Pedido,
    f.pes_nome AS Nome_Funcionario,
    c.pes_nome AS Nome_Cliente,
    e.pes_nome AS Nome_Estagiario
FROM 
    pedidos p
JOIN 
    funcionarios f ON p.fun_codigo = f.pes_codigo
JOIN 
    clientes c ON p.cli_codigo = c.pes_codigo
LEFT JOIN 
    estagiarios e ON p.est_codigo = e.pes_codigo;

-- Select usando a view

SELECT * FROM VW_PEDIDOS;

-- Realizando um select usando a view para verificar três produtos diferentes

SELECT 
    vw.Numero_Pedido,
    vw.Data_Pedido,
    vw.Nome_Funcionario,
    vw.Nome_Cliente,
    vw.Nome_Estagiario,
    ip.prd_codigo AS Produto_ID,
    ip.itp_qtd AS Quantidade,
    ip.itp_valor AS Valor_Item
FROM 
    VW_PEDIDOS vw
JOIN 
    itens_pedidos ip ON vw.Numero_Pedido = ip.ped_numero
WHERE 
    ip.prd_codigo IN (1, 2, 3);

