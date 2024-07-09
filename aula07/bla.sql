-- 40. Consultar o total vendido do Produto 4

select sum(pedidos.itp_qtd) as Total_Vendido from
    itens_pedidos as pedidos where
        prd_codigo = 4;

-- 41. Consultar o valor total de cada pedido.

select ped_numero, sum(pedidos.itp_qtd * pedidos.itp_valor) as
    Valor_Total from itens_pedidos as pedidos
        group by ped_numero;

-- 42. Consultar o total vendido do produto 3 em cada pedido.

select ped_numero, sum(pedidos.itp_qtd) as Total_Vendido_3 from
    itens_pedidos as pedidos where prd_codigo = 3 group by ped_numero;

-- 43. Consultar os pedidos com valor total acima de R$ 30,00 reais.

select ped_numero, sum(pedidos.itp_qtd * pedidos.itp_valor) as
    Valor_Total_Pedido from itens_pedidos as pedidos group by ped_numero
        having sum(pedidos.itp_qtd * pedidos.itp_valor) > 30.00;

-- 44. Consultar a quantidade de itens por pedido.

select ped_numero, sum(pedidos.itp_qtd) as Quantidade_Itens from
    itens_pedidos as pedidos group by ped_numero;

-- 45. Consultar a quantidade de vezes que cada produto foi vendido.

select prd_codigo, sum(pedidos.itp_qtd) as Quantidade_Itens from
    itens_pedidos as pedidos group by prd_codigo;

-- 46. Consultar quantos pedidos cada cliente solicitou.

select cli_codigo, count(cli_codigo) from pedidos group by cli_codigo;

-- 47. Consultar quantos pedidos cada funcionário registrou.

select fun_codigo, count(fun_codigo) from pedidos group by fun_codigo;

-- 48. Consultar os pedidos que possuem mais do que 3 itens.

-- 49. Consultar o produto mais vendido em quantidade de itens.

-- 50. Consultar os pedidos (ped_numero, ped_data) que possuem mais do que 3 itens.  Usar exists.

-- 51. Consultar as pessoas que são clientes. Usar exists.

-- 52. Consultar os clientes que possuem pedidos com valor total acima de R$ 20,00. Usar exists.

--53. Consultar a data do sistema, e separadamente o ano, mês, dia, hora e minutos.

-- 54. Consultar o valor total do pedido 1.

-- 55. Consultar o total vendido do produto 3
