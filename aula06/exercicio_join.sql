-- 1. Selecionar todos os nomes de pessoas envolvidas (estagiário, cliente e funcionário) na compra do produto 3
select p.pes_nome
from pessoas p
inner join clientes c on p.pes_codigo = c.pes_codigo
inner join pedidos pd on c.pes_codigo = pd.cli_codigo
inner join itens_pedidos ip on pd.ped_numero = ip.ped_numero
where ip.prd_codigo = 3

union

select p.pes_nome
from pessoas p
inner join estagiarios e on p.pes_codigo = e.pes_codigo
inner join pedidos pd on e.pes_codigo = pd.est_codigo
inner join itens_pedidos ip on pd.ped_numero = ip.ped_numero
where ip.prd_codigo = 3

union

select p.pes_nome
from pessoas p
inner join funcionarios f on p.pes_codigo = f.pes_codigo
inner join pedidos pd on f.pes_codigo = pd.fun_codigo
inner join itens_pedidos ip on pd.ped_numero = ip.ped_numero
where ip.prd_codigo = 3;


-- 2. Selecionar nome e valor bolsa dos estagiários
select p.pes_nome, e.est_bolsa
from pessoas p
inner join estagiarios e on p.pes_codigo = e.pes_codigo;


-- 3. Selecionar nome e renda de todos os clientes
select p.pes_nome, c.cli_renda
from pessoas p
inner join clientes c on p.pes_codigo = c.pes_codigo;


-- 4. Selecionar salário e nome de todos os funcionários
select p.pes_nome, f.fun_salario
from pessoas p
inner join funcionarios f on p.pes_codigo = f.pes_codigo;


-- 5. Selecione todos os produtos (código, descrição, quantidade) do pedido 1
select prd_codigo, prd_descricao, prd_qtd
from produtos
inner join itens_pedidos on produtos.prd_codigo = itens_pedidos.prd_codigo
where ped_numero = 15;


-- 6. Selecione o nome dos clientes que compraram o produto 1
select p.pes_nome
from pessoas p
inner join clientes c on p.pes_codigo = c.pes_codigo
inner join pedidos pd on c.pes_codigo = pd.cli_codigo
inner join itens_pedidos ip on pd.ped_numero = ip.ped_numero
where ip.prd_codigo = 1;


-- 7. Construa uma consulta que mostre o código do pedido, a data da compra, o nome do cliente, o nome do funcionário, dos pedidos que foram vendidos mais de 5 itens.
select pd.ped_numero, pd.ped_data, pc.pes_nome as nome_cliente, pf.pes_nome as nome_funcionario
from pedidos pd
inner join (
    select ped_numero
    from itens_pedidos
    group by ped_numero
    having sum(itp_qtd) > 5
) ip on pd.ped_numero = ip.ped_numero
inner join pessoas pc on pd.cli_codigo = pc.pes_codigo
inner join pessoas pf on pd.fun_codigo = pf.pes_codigo;


-- 8. Construa uma consulta que mostre o cliente que mais efetuou pedidos
select p.pes_nome, count(pd.ped_numero) as total_pedidos
from pessoas p
inner join clientes c on 
