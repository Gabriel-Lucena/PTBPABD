create database consultorio;

use consultorio;

create table pessoas(
	id INT NOT NULL IDENTITY PRIMARY KEY,
    data_nascimento DATE NOT NULL,
    genero BIT NOT NULL,
    estado_civil VARCHAR(10) NOT NULL,
    rg CHAR(9) NOT NULL
);

create table medicos(
	id_pessoa INT NOT NULL IDENTITY PRIMARY KEY,
	crm VARCHAR(8) NOT NULL,
    FOREIGN KEY(id_pessoa) REFERENCES pessoas(id)
);

create table pacientes(
    id_pessoa INT NOT NULL IDENTITY PRIMARY KEY,
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
	id_pessoa INT NOT NULL IDENTITY,
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
