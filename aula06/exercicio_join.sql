-- 1. Selecionar todos os nomes de pessoas envolvidas (estagiário, cliente e funcionário) na compra do produto 3
SELECT p.pes_nome
FROM pessoas AS p
INNER JOIN clientes AS c ON p.pes_codigo = c.pes_codigo
INNER JOIN pedidos AS pd ON c.pes_codigo = pd.cli_codigo
INNER JOIN itens_pedidos AS ip ON pd.ped_numero = ip.ped_numero
WHERE ip.prd_codigo = 3;

-- 2. Selecionar nome e valor bolsa dos estagiários
SELECT p.pes_nome, e.est_bolsa
FROM pessoas AS p
INNER JOIN estagiarios AS e ON p.pes_codigo = e.pes_codigo;

-- 3. Selecionar nome e renda de todos os clientes
SELECT p.pes_nome, c.cli_renda
FROM pessoas AS p
INNER JOIN clientes AS c ON p.pes_codigo = c.pes_codigo;

-- 4. Selecionar salário e nome de todos os funcionários
SELECT p.pes_nome, f.fun_salario
FROM pessoas AS p
INNER JOIN funcionarios AS f ON p.pes_codigo = f.pes_codigo;

-- 5. Selecione todos os produtos (código, descrição, quantidade) do pedido 1
SELECT prd_codigo, prd_descricao, prd_qtd
FROM produtos AS p
INNER JOIN itens_pedidos AS ip ON p.prd_codigo = ip.prd_codigo
WHERE ped_numero = 15;

-- 6. Selecione o nome dos clientes que compraram o produto 1
SELECT p.pes_nome
FROM pessoas AS p
INNER JOIN clientes AS c ON p.pes_codigo = c.pes_codigo
INNER JOIN pedidos AS pd ON c.pes_codigo = pd.cli_codigo
INNER JOIN itens_pedidos AS ip ON pd.ped_numero = ip.ped_numero
WHERE ip.prd_codigo = 1;

-- 7. Construa uma consulta que mostre o código do pedido, a data da compra, o nome do cliente, o nome do funcionário, dos pedidos que foram vendidos mais de 5 itens.
SELECT pd.ped_numero, pd.ped_data, pc.pes_nome AS nome_cliente, pf.pes_nome AS nome_funcionario
FROM pedidos AS pd
INNER JOIN (
    SELECT ped_numero
    FROM itens_pedidos
    GROUP BY ped_numero
    HAVING SUM(itp_qtd) > 5
) AS ip ON pd.ped_numero = ip.ped_numero
INNER JOIN pessoas AS pc ON pd.cli_codigo = pc.pes_codigo
INNER JOIN pessoas AS pf ON pd.fun_codigo = pf.pes_codigo;

-- 8. Construa uma consulta que mostre o cliente que mais efetuou pedidos
SELECT p.pes_nome, COUNT(pd.ped_numero) AS total_pedidos
FROM pessoas AS p
INNER JOIN clientes AS c ON p.pes_codigo = c.pes_codigo
INNER JOIN pedidos AS pd ON c.pes_codigo = pd.cli_codigo
GROUP BY p.pes_nome
ORDER BY total_pedidos;

-- 9. Construa uma consulta para exibir o código, o valor, a data (pedido) e o nome do estagiário do pedido com o menor valor efetuado pelo estagiário 3
SELECT pd.ped_numero, pd.ped_valor, pd.ped_data, p.pes_nome AS nome_estagiario
FROM pedidos AS pd
INNER JOIN pessoas AS p ON pd.est_codigo = p.pes_codigo
WHERE pd.est_codigo = 3
ORDER BY pd.ped_valor;
