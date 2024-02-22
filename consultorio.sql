create database consultorio;

use consultorio;

/*
*    1) Criando as tabelas baseadas no diagrama do consultório apresentado
*/

create table pessoas(
	id INT NOT NULL IDENTITY PRIMARY KEY,
    data_nascimento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    estado_civil VARCHAR(10) NOT NULL,
    rg CHAR(9) NOT NULL
);

create table medicos(
	id_pessoa INT NOT NULL PRIMARY KEY,
	crm VARCHAR(8) NOT NULL,
    FOREIGN KEY(id_pessoa) REFERENCES pessoas(id)
);

create table pacientes(
    id_pessoa INT NOT NULL PRIMARY KEY,
    convenio VARCHAR(50),
    FOREIGN KEY(id_pessoa) REFERENCES pessoas(id)
);

create table consultas(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	data DATE NOT NULL,
	diagnostico VARCHAR(50) NOT NULL,
	id_medico INT NOT NULL,
	id_paciente INT NOT NULL,
	FOREIGN KEY(id_medico) REFERENCES medicos(id_pessoa),
	FOREIGN KEY(id_paciente) REFERENCES pacientes(id_pessoa)
);

create table telefones(
	id_pessoa INT NOT NULL,
    ddd CHAR(2) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES pessoas(id),
    PRIMARY KEY(id_pessoa, ddd, telefone)
);

create table exames(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_consulta INT NOT NULL,
    data DATE NOT NULL,
    exame  VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_consulta) REFERENCES consultas(id)
);

create table enderecos(
    id INT NOT NULL IDENTITY,
    id_pessoa INT NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    cep CHAR(8),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_pessoa) REFERENCES pessoas(id),
    PRIMARY KEY (id, id_pessoa)
);

/*
*    2) Inserindo no mínimo 5 linhas para cada tabela
*/

insert into pessoas
values
    ('1985-03-10', 'Masculino', 'Casado', '256146986'),
    ('1992-09-25', 'Feminino', 'Divorciado', '413481037'),
    ('1978-06-07', 'Masculino', 'Solteiro', '251747682'),
    ('2000-12-15', 'Feminino', 'Solteiro', '226163659'),
    ('1999-04-03', 'Feminino', 'Casado', '460239028');

insert into medicos
values
    (1, '583024'),
    (2, '719835'),
    (3, '4002176'),
    (4, '896513'),
    (5, '621490');

insert into pacientes
values
    (6, 'Unimed'),
    (7, 'Bradesco Saúde'),
    (8, 'SulAmérica Saúde'),
    (9, 'Amil'),
    (10, 'Golden Cross');

insert into consultas
values
    ('2024-03-14', 'Hipertensão arterial', 1, 6),
    ('2024-04-28', 'Diabetes mellitus tipo 2', 2, 7),
    ('2024-06-05', 'Hipercolesterolemia', 3, 8),
    ('2024-09-19', 'Anemia ferropriva', 4, 9),
    ('2024-11-10', 'Gastrite crônica', 5, 10);

insert into telefones
values
    (6, '11', '12345678'),
    (7, '21', '98765432'),
    (8, '51', '24681357'),
    (9, '81', '36902468'),
    (10, '98', '75310246');

insert into exames
values
    (1, '2024-03-15', 'Hemograma completo'),
    (2, '2024-04-28', 'Ultrassonografia abdominal'),
    (3, '2024-06-06', 'Teste de glicemia em jejum'),
    (4, '2024-08-22', 'Radiografia de tórax'),
    (5, '2024-11-10', 'Eletrocardiograma');

insert into enderecos
values
    (6, 'Rua das Flores', 234, '12345678', 'Jardim Primavera', 'São Paulo', 'Sãp Paulo'),
    (7, 'Avenida das Palmeiras', 64, '23456789', 'Centro', 'Rio de Janeiro', 'Rio de Janeiro'),
    (8, 'Travessa dos Pinheiros', 57, '34567890', 'Boa Vista', 'Belo Horizonte', 'Minas Gerais'),
    (9, 'Praça das Águias', 78, '45678901', 'Lago Azul', 'Brasília', 'Distrito Federal'),
    (10, 'Alameda dos Girassóis', 52, '56789012', 'Bela Vista', 'Salvador', 'Bahia');

/*
*    3) Escrevendo e executando um select para exibir todos os dados de cada tabela
*/

select * from pessoas;

select * from medicos;

select * from pacientes;

select * from consultas;

select * from telefones;

select * from exames;

select * from enderecos;

/*
*    4) Alterando a tabela de pessoas para adicionar o campo nome
*/

alter table pessoas
    add nome VARCHAR(75) NOT NULL;

/*
*    5) Atualizando os registros da tabela de pessoas adicionando um nome para cada tupla (para cada pessoa)
*/

update pessoas
set nome = 'Calíope'
where id = 1;

update pessoas
set nome = 'Clio'
where id = 2;

update pessoas
set nome = 'Erato'
where id = 3;

update pessoas
set nome = 'Euterpe'
where id = 4;

update pessoas
set nome = 'Melpômene'
where id = 5;

update pessoas
set nome = 'Polímnia'
where id = 6;

update pessoas
set nome = 'Tália'
where id = 7;

update pessoas
set nome = 'Terpsícore'
where id = 8;

update pessoas
set nome = 'Urânia'
where id = 9;

update pessoas
set nome = 'Epimeteu'
where id = 10;
