-- 40. Consultar o total vendido do Produto 4

select sum(pedidos.itp_qtd) as Total_Vendido from
    itens_pedidos as pedidos where
        prd_codigo = 4;

-- 41. Consultar o valor total de cada pedido.

select ped_numero, sum(pedidos.itp_qtd * pedidos.itp_valor) as
    Valor_Total from itens_pedidos as pedidos
        group by ped_numero;
