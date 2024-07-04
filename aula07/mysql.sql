CREATE DATABASE ptbpabd;

USE ptbpabd;

CREATE TABLE pessoas (
  pes_codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pes_nome VARCHAR(50) NOT NULL,
  pes_cpf,
  pes_status
);

CREATE TABLE clientes (
  pes_codigo,
  cli_renda,
  cli_credito);

CREATE TABLE estagiarios (
  pes_codigo,
  est_bolsa
);

CREATE TABLE funcionarios (
  pes_codigo,
  fun_salario,
  sup_codigo
);