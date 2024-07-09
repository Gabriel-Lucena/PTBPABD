-- Feito no MySql Workbench

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

select ped_numero from itens_pedidos group by ped_numero
    having sum(itp_qtd) > 3;

-- 49. Consultar o produto mais vendido em quantidade de itens.

select prd_codigo, sum(itp_qtd) as quantidade_total from
    itens_pedidos group by prd_codigo
        order by quantidade_total desc limit 1;

-- 50. Consultar os pedidos (ped_numero, ped_data) que possuem mais do que 3 itens.  Usar exists.

select p.ped_numero, p.ped_data
from pedidos p
where exists (
    select 1
    from itens_pedidos ip
    where ip.ped_numero = p.ped_numero
    group by ip.ped_numero
    having sum(ip.itp_qtd) > 3
);

-- 51. Consultar as pessoas que são clientes. Usar exists.

select pes_nome
from pessoas p
where exists (
    select 1
    from clientes c
    where c.pes_codigo = p.pes_codigo
);


-- 52. Consultar os clientes que possuem pedidos com valor total acima de R$ 20,00. Usar exists.

select c.pes_codigo
from clientes c
where exists (
    select 1
    from pedidos p
    join itens_pedidos ip on p.ped_numero = ip.ped_numero
    where p.cli_codigo = c.pes_codigo
    group by p.ped_numero
    having sum(ip.itp_qtd * ip.itp_valor) > 20.00
);


-- 53. Consultar a data do sistema, e separadamente o ano, mês, dia, hora e minutos.

select
    now() as data_sistema,
    year(now()) as ano,
    month(now()) as mes,
    day(now()) as dia,
    hour(now()) as hora,
    minute(now()) as minuto;


-- 54. Consultar o valor total do pedido 1.

select sum(itp_qtd * itp_valor) as valor_total
from itens_pedidos
where ped_numero = 1;

-- 55. Consultar o total vendido do produto 3

select sum(itp_qtd) as total_vendido
from itens_pedidos
where prd_codigo = 3;
