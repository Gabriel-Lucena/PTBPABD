CREATE DATABASE ptbpabd;

USE ptbpabd;

-- Tabela Pessoas
create table pessoas
(
    pes_codigo int not null auto_increment,
    pes_nome   varchar(50)  not null,
    pes_cpf    varchar(12)  not null unique,
    pes_status int 
             check(pes_status in (1,2,3,4)),
    primary key(pes_codigo)
);

-- Tabela Clientes
create table clientes 
( 
    pes_codigo  int not null,
    cli_renda   decimal(7,2),
    cli_credito decimal(7,2),
    primary key(pes_codigo),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
);

-- Tabela Estagiarios
create table estagiarios
(
    pes_codigo int not null,
    est_bolsa  decimal(7,2) 
               check (est_bolsa >= 0),
    primary key(pes_codigo),
    foreign key(pes_codigo) 
            references pessoas(pes_codigo)
);

-- Tabela Funcionarios
create table funcionarios
(
   pes_codigo  int not null,
   fun_salario decimal(7,2) 
               check(fun_salario > 0),
   sup_codigo int,
   primary key(pes_codigo),
   foreign key(pes_codigo) 
           references pessoas(pes_codigo),
   foreign key(sup_codigo) 
           references funcionarios(pes_codigo)
);

-- Tabela Produtos
create table produtos
(
   prd_codigo   int not null auto_increment,
   prd_descricao varchar(50) not null,
   prd_qtd      int, 
   prd_valor    decimal(7,2),
   prd_status   int 
               check(prd_status in (1,2,3,4)),
   primary key(prd_codigo)
);

-- Tabela Pedidos
create table pedidos
(
   ped_numero int not null auto_increment,
   ped_data   datetime,
   ped_valor  decimal(7,2) 
              check(ped_valor > 0),
   ped_status int  
              check(ped_status in (1,2,3,4)),
   fun_codigo int not null,       
   cli_codigo int not null,
   est_codigo int,
   primary key(ped_numero),
   foreign key(fun_codigo) 
          references funcionarios(pes_codigo),
   foreign key(cli_codigo) 
          references clientes(pes_codigo),
   foreign key(est_codigo) 
           references estagiarios(pes_codigo)
);

-- Tabela Itens_Pedidos
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
);

-- Inserts na tabela produtos
insert into produtos (prd_descricao, prd_qtd, prd_valor, prd_status) values 
('Lápis', 100, 0.8, 1),
('Apontador', 100, 2.5, 1),
('Caneta', 100, 1.2, 1),     
('Caderno', 100, 4.5, 1),
('Borracha', 100, 0.85, 1);

select * from produtos;

-- Inserts na tabela pessoas
insert into pessoas (pes_nome, pes_cpf, pes_status) values 
('Batman', '3030', 1),
('SuperMain', '1515', 1),
('SpiderMan', '3131', 1),
('Super Foca', '2020', 1),
('Buslaboo', '007', 1),
('BuschaGalack', '4343', 1),
('Super Prof', '3636', 1),
('Ensina Legal', '3333', 1);

select * from pessoas;

-- Inserts na tabela clientes
insert into clientes (pes_codigo, cli_renda, cli_credito) values 
(1, 10000, 3000),
(2, 15000, 5000);

select * from clientes;

-- Inserts na tabela estagiarios
insert into estagiarios (pes_codigo, est_bolsa) values 
(3, 725),
(5, 500);

select * from estagiarios;

-- Inserts na tabela funcionarios
insert into funcionarios (pes_codigo, fun_salario, sup_codigo) values 
(4, 2500, null),
(6, 1000, 4),
(7, 2500, null),
(8, 1050, 7);

select * from funcionarios;

-- Inserts na tabela pedidos
insert into pedidos (ped_data, ped_valor, ped_status, fun_codigo, cli_codigo, est_codigo) values 
('2009-08-19 10:00:00', null, 1, 6, 1, 3),
('2009-08-19 12:00:00', null, 1, 8, 2, 5),
('2009-08-19 14:00:00', null, 1, 6, 1, 5),
('2009-08-20 10:00:00', null, 1, 8, 1, 3),
('2009-08-20 12:00:00', null, 1, 6, 2, 5),
('2009-08-20 14:00:00', null, 1, 8, 2, 3);

select * from pedidos;

-- Inserts na tabela itens_pedidos
insert into itens_pedidos (ped_numero, prd_codigo, itp_qtd, itp_valor) values 
(1, 1, 10, 0.8),
(1, 2, 10, 2.5),
(1, 3, 10, 1.2),
(1, 4, 10, 4.5),
(1, 5, 10, 0.85),
(2, 1, 5, 0.8),
(2, 2, 5, 2.5),
(2, 3, 5, 1.2),
(2, 4, 5, 4.5),
(3, 2, 3, 2.5),
(3, 3, 3, 1.2),
(3, 4, 3, 4.5),
(4, 3, 2, 1.2),
(4, 5, 2, 0.85),
(5, 5, 1, 0.85);

select * from itens_pedidos;
