-- Criando o banco de dados ----------------
create database vendas
go
use vendas
go
 
-- Create Tables ----------------------------

-- Tabela Pessoas ------------------------

create table pessoas
(
    pes_codigo int not null identity,
    pes_nome   varchar(50)  not null,
    pes_cpf    varchar(12)  not null unique,
    pes_status int 
             check(pes_status in (1,2,3,4)),
    primary key(pes_codigo)	
)

-- Tabela Clientes -----------------------

create table clientes 
( 
    pes_codigo  int not null primary key,
    cli_renda   decimal(7,2),
    cli_credito decimal(7,2),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
)


-- Tabela Estagiarios --------------------

create table estagiarios
(
    pes_codigo int not null primary key,
    est_bolsa  decimal(7,2) 
               check (est_bolsa >= 0),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
)


 
-- Tabela Funcionarios--------------------

create table funcionarios
(
   pes_codigo  int not null primary key,
   fun_salario decimal(7,2) 
               check(fun_salario > 0),
   sup_codigo int,
   foreign key(pes_codigo) 
           references pessoas(pes_codigo),
   foreign key(sup_codigo) 
           references funcionarios(pes_codigo)
)

-- Tabela Produtos -----------------------

create table produtos
(
   prd_codigo   int not null identity,
   prd_descricao varchar(50) not null,
   prd_qtd      int, 
   prd_valor    decimal(7,2),
   prd_status   int 
               check(prd_status in (1,2,3,4)),
   primary key(prd_codigo)
)

-- Tabela Pedidos ------------------------

create table pedidos
(
   ped_numero int not null identity,
   ped_data   datetime,
   ped_valor  decimal(7,2) 
              check(ped_valor > 0),
   ped_status int  
              check(ped_status in (1,2,3,4)),
   fun_codigo int not null,       
   cli_codigo int not null,
   est_codigo int,
   foreign key(fun_codigo) 
          references funcionarios(pes_codigo),
   foreign key(cli_codigo) 
          references clientes(pes_codigo),
   foreign key(est_codigo) 
           references estagiarios(pes_codigo),
   primary key(ped_numero)
)


-- Tabela Intes_Pedidos--------------------

create table itens_pedidos
(
   ped_numero int not null,
   prd_codigo int not null,
   itp_qtd    int not null,
   itp_valor  decimal(7,2) not null,
   primary key(ped_numero, prd_codigo),
   foreign key(ped_numero) 
           references pedidos(ped_numero),
   foreign key(prd_codigo) 
           references produtos(prd_codigo)
)

use vendas

--Inserts
insert into produtos values ('Lápis', 100, 0.8, 1)
insert into produtos values ('Apontador', 100, 2.5, 1)
insert into produtos values ('Caneta',100,1.2,1)     
insert into produtos values ('Caderno',100,4.5,1)
insert into produtos values ('Borracha',100,0.85,1)
select * from produtos

-- Inserts Pessoas
insert into pessoas values ('Batman','3030',1)
insert into pessoas values ('SuperMain','1515',1)
insert into pessoas values ('SpiderMan','3131',1)
insert into pessoas values ('Super Foca','2020',1)
insert into pessoas values ('Buslaboo','007',1)
insert into pessoas values ('BuschaGalack','4343',1)
insert into pessoas values ('Super Prof','3636',1)
insert into pessoas values ('Ensina Legal','3333',1)

select * from pessoas


-- Inserts Clientes
insert into clientes values (1,10000,3000)
insert into clientes values (2,15000,5000)
select * from clientes

-- Inserts Estagiários
insert into estagiarios values (3,725)
insert into estagiarios values (5,500)
select * from estagiarios

-- Inserts funcionarios

insert into funcionarios values (4,2500,null)
insert into funcionarios values (6,1000,4)
insert into funcionarios values (7,2500,null)
insert into funcionarios values (8,1050,7)
select * from funcionarios

-- Insert Pedidos
insert into pedidos values 
('08-19-2009 10:00',null,1,6,1,3)

insert into pedidos values
('08-19-2009 12:00',null,1,8,2,5)

insert into pedidos values
('08-19-2009 14:00',null,1,6,1,5)

insert into pedidos values 
('08-20-2009 10:00', null,1,8,1,3)

insert into pedidos values 
('08-20-2009 12:00', null,1,6,2,5)

insert into pedidos values 
('08-20-2009 14:00', null,1,8,2,3)
select * from pedidos


-- Insert itens_pedidos
insert into itens_pedidos values (15,1,10,0.8)
insert into itens_pedidos values (15,2,10,2.5)
insert into itens_pedidos values (15,3,10,1.2)
insert into itens_pedidos values (15,4,10,4.5)
insert into itens_pedidos values (15,5,10,0.85)

insert into itens_pedidos values (16,1,5,0.8)
insert into itens_pedidos values (16,2,5,2.5)
insert into itens_pedidos values (16,3,5,1.2)
insert into itens_pedidos values (16,4,5,4.5)

insert into itens_pedidos values (17,2,3,2.5)
insert into itens_pedidos values (17,3,3,1.2)
insert into itens_pedidos values (17,4,3,4.5)

insert into itens_pedidos values (18,3,2,1.2)
insert into itens_pedidos values (18,5,2,0.85)

insert into itens_pedidos values (19,5,1,0.85)
select * from itens_pedidos

-- 8.Consultar duas pessoas que possuem nome com alguma subpalavra 'super'

select top 2 * from pessoas where pes_nome like '%super%'

-- 9.Consultar as pessoas com letra b na a inicial do nome.

select * from pessoas where pes_nome like 'b%'

-- 10.Consultar as pessoas que possuem a letra p como sendo a terceira letra do nome.

select * from pessoas where pes_nome like '__p%'

-- 11.Consultar o valor médio dos produtos.

select avg(prd_qtd) from produtos

-- 12.Consultar o maior valor de venda de produto.

select max(itp_qtd) as max_quantidade from itens_pedidos

-- 13.Consultar o menor valor de venda de produto.

select min(itp_qtd) as min_quantidade from itens_pedidos

-- 14.Consultar o valor médio de produto, bem como o maior valor, o menor valor e a quantidade de produtos cadastrados.

select avg(prd_valor) as valor_media, max(prd_valor) as maximo_valor, min(prd_valor) as minimo_valor
        , sum(prd_qtd) as quantidade_total from produtos

-- 15.Consultar as pessoas com o código 1 ou 7.

select * from pessoas where pes_codigo = 1 or pes_codigo = 7

-- 16.Consultar as pessoas com o código 1 e 7.

select * from pessoas where pes_codigo = 1 and pes_codigo = 7

-- 17.Consultar as pessoas que possuem os códigos 1,2 e 5.

select * from pessoas where pes_codigo in (1, 2, 5)

-- 18.Consultar as pessoas que possuem código entre 3 e 6.

select * from pessoas where pes_codigo between 3 and 6

-- 19.Consultar os supervisores.

select * from funcionarios where sup_codigo is not null

-- 20.Consultar somente os funcionários.

select * from funcionarios where sup_codigo is null

-- 21.Consultar todos os pedidos do cliente 2.

select * from pedidos where cli_codigo = 2

-- 22.Consultar todos os pedidos do cliente 2 que foram vendidos pelo funcionário 6.

select * from pedidos where cli_codigo = 2 and fun_codigo = 6

-- 23.	Consultar os pedidos que foram solicitados pelo cliente 2, registrados pelo funcionário 8 e conferidos pelo estagiário 5.

select * from pedidos where cli_codigo = 2 and fun_codigo = 8 and est_codigo = 5

-- 24.	Consultar a quantidade de itens vendidos

select sum(itp_qtd) as quantidade_total from itens_pedidos

-- 25.	Consultar a quantidade de pedidos do cliente 1.

select count(*) as quantidade_pedidos from pedidos where cli_codigo = 1

-- 26.	Consultar a quantidade de itens vendidos relacionada ao pedido 2.

select count(*) as quantidade_itens from itens_pedidos where ped_numero = 2

-- 27.	Consultar quantos pedidos foram registrados pelo funcionário 6

select count(*) as quantidade_pedidos from pedidos where fun_codigo = 6

-- 28.	Consultar quantas vezes o produto 3 foi vendido.

select sum(itp_qtd) as quantidade_vendida from itens_pedidos where prd_codigo = 3

-- 29.	Consultar todas as pessoas.

select * from pessoas

-- 30.	Consultar todos os dados dos clientes.

select * from clientes

-- 31.	Consultar nome, CPF, renda e crédito de todos os clientes.
select pes_nome, pes_cpf, cli_renda, cli_credito from pessoas join clientes
        on pessoas.pes_codigo = clientes.pes_codigo

-- 32.	Consultar os produtos (descrição) e as quantidades vendidas no pedido 1.

select prd_descricao, itp_qtd from itens_pedidos join produtos
        on itens_pedidos.prd_codigo = produtos.prd_codigo where ped_numero = 1

-- 33.	Consultar os produtos (descrição), quantidades vendidas, valores unitários e o valor de cada item do pedido 2.

select prd_descricao, itp_qtd, prd_valor, itp_qtd * prd_valor as valor_total
        from itens_pedidos join produtos on itens_pedidos.prd_codigo = produtos.prd_codigo
        where ped_numero = 2

-- 34.	Consultar número, data, nome do funcionário, nome do cliente e nome do estagiário de cada pedido.

select ped_numero, ped_data,
        (select pes_nome from pessoas where pes_codigo = fun_codigo) as nome_funcionario,
        (select pes_nome from pessoas where pes_codigo = cli_codigo) as nome_cliente,
        (select pes_nome from pessoas where pes_codigo = est_codigo) as nome_estagiario
from pedidos

-- 35.	Consultar código, nome, salário e o nome do supervisor de cada funcionário.

select f.pes_codigo, f.pes_nome, f.fun_salario, s.pes_nome as supervisor from funcionarios as f
        left join funcionarios as s on f.sup_codigo = s.pes_codigo

-- 36.	 Consultar o valor de cada item vendido.

select prd_descricao, itp_valor from itens_pedidos join produtos
        on itens_pedidos.prd_codigo = produtos.prd_codigo

-- 37.	Consultar o total vendido (faturado) até o momento.

select sum(itp_qtd * itp_valor) as total_faturado from itens_pedidos

-- 38.	Consultar o total da folha de pagamento dos supervisores.

select sum(fun_salario) as total_folha_supervisores from funcionarios where sup_codigo is not null

-- 39.	Consultar o valor total do pedido 1.

select sum(itp_qtd * itp_valor) as valor_total_pedido_1 from itens_pedidos where ped_numero = 1

-- 40.	Consultar o total vendido do Produto 4

select sum(itp_qtd) as total_vendido_produto_4 from itens_pedidos where prd_codigo = 4

-- 41. consultar o valor total de cada pedido.

select ped_numero, sum(itp_qtd * itp_valor) as valor_total_pedido
from itens_pedidos
group by ped_numero;

-- 42. consultar o total vendido do produto 3 em cada pedido.

select ped_numero, sum(itp_qtd) as total_vendido_produto_3
from itens_pedidos
where prd_codigo = 3
group by ped_numero;

-- 43. consultar os pedidos com valor total acima de R$ 30,00 reais.

select ped_numero, sum(itp_qtd * itp_valor) as valor_total_pedido
from itens_pedidos
group by ped_numero
having sum(itp_qtd * itp_valor) > 30;

-- 44. consultar a quantidade de itens por pedido.

select ped_numero, count(*) as quantidade_itens
from itens_pedidos
group by ped_numero;

-- 45. consultar a quantidade de vezes que cada produto foi vendido.

select prd_codigo, sum(itp_qtd) as total_vendido
from itens_pedidos
group by prd_codigo;

-- 46. consultar quantos pedidos cada cliente solicitou.

select cli_codigo, count(*) as quantidade_pedidos
from pedidos
group by cli_codigo;

-- 47. consultar quantos pedidos cada funcionário registrou.

select fun_codigo, count(*) as quantidade_pedidos_registrados
from pedidos
group by fun_codigo;

-- 48. consultar os pedidos que possuem mais do que 3 itens.

select ped_numero
from itens_pedidos
group by ped_numero
having count(*) > 3;

-- 49. consultar o produto mais vendido em quantidade de itens.

select prd_codigo, sum(itp_qtd) as total_vendido
from itens_pedidos
group by prd_codigo
order by total_vendido desc
limit 1;

-- 50. consultar os pedidos (ped_numero, ped_data) que possuem mais do que 3 itens. usar exists.

select ped_numero, ped_data
from pedidos p
where exists (
    select 1
    from itens_pedidos
    where ped_numero = p.ped_numero
    group by ped_numero
    having count(*) > 3
);

-- 51. consultar as pessoas que são clientes. usar exists.

select *
from pessoas p
where exists (
    select 1
    from clientes c
    where c.pes_codigo = p.pes_codigo
);

-- 52. consultar os clientes que possuem pedidos com valor total acima de R$ 20,00. usar exists.

select p.pes_codigo, p.pes_nome
from pessoas p
where exists (
    select 1
    from pedidos pe
    join itens_pedidos ip on pe.ped_numero = ip.ped_numero
    where pe.cli_codigo = p.pes_codigo
    group by pe.ped_numero
    having sum(ip.itp_qtd * ip.itp_valor) > 20
);

-- 53. consultar a data do sistema, e separadamente o ano, mês, dia, hora e minutos.

select getdate() as data_atual,
       year(getdate()) as ano,
       month(getdate()) as mes,
       day(getdate()) as dia,
       datepart(hour, getdate()) as hora,
       datepart(minute, getdate()) as minutos;

-- 54. consultar o valor total do pedido 1.

select ped_numero, sum(itp_qtd * itp_valor) as valor_total_pedido_1
from itens_pedidos
where ped_numero = 1
group by ped_numero;

-- 55. consultar o total vendido do produto 3.

select prd_codigo, sum(itp_qtd) as total_vendido_produto_3
from itens_pedidos
where prd_codigo = 3
group by prd_codigo;
