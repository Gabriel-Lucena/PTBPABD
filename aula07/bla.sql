-- 40. Consultar o total vendido do Produto 4

select count(pedidos.prd_codigo) from itens_pedidos as pedidos where 
    prd_codigo = 4;

-- 41. Consultar o valor total de cada pedido.

select ped_codigo, pedidos.itp_qtd * pedidos.itp_valor from itens_pedidos as pedidos;