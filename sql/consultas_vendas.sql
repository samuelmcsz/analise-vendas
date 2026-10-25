-- ============================================================
-- Projeto: Análise de Vendas — Magalu (dados fictícios)
-- Autor: Samuel Martins Cardoso
-- Banco: vendas_magalu (tabelas: clientes, produtos, vendas)
-- Período analisado: 2025
-- ============================================================

USE vendas_magalu;

-- ============================================================
-- 1) CONFERÊNCIA DOS DADOS
-- Esperado: 1000 | 50 | 10000
-- ============================================================
SELECT
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM produtos) AS total_produtos,
    (SELECT COUNT(*) FROM vendas)   AS total_vendas;


-- ============================================================
-- 2) KPIs GERAIS
-- Esperado: 7190613.51 | 10000 | 719.06 | 14256 | 979 | 6.19 | 473866.09
-- ============================================================
SELECT
    ROUND(SUM(faturamento), 2)                                    AS faturamento_total,
    COUNT(*)                                                      AS total_vendas,
    ROUND(AVG(faturamento), 2)                                    AS ticket_medio,
    SUM(quantidade)                                               AS unidades_vendidas,
    COUNT(DISTINCT id_cliente)                                    AS clientes_ativos,
    ROUND(AVG(desconto) * 100, 2)                                 AS desconto_medio_pct,
    ROUND(SUM(quantidade * preco_unitario) - SUM(faturamento), 2) AS total_descontos
FROM vendas;


-- ============================================================
-- 3) FATURAMENTO MENSAL
-- Esperado: 12 linhas (jan = 429512.88 | dez = 815905.63)
-- ============================================================
SELECT
    MONTH(data_venda)          AS mes,
    COUNT(*)                   AS total_vendas,
    ROUND(SUM(faturamento), 2) AS faturamento
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY mes;

-- 3.1) Mês que mais faturou (esperado: mês 12, 815905.63)
SELECT
    MONTH(data_venda)          AS mes,
    ROUND(SUM(faturamento), 2) AS faturamento
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY faturamento DESC
LIMIT 1;

-- 3.2) Mês que menos faturou (esperado: mês 1, 429512.88)
SELECT
    MONTH(data_venda)          AS mes,
    ROUND(SUM(faturamento), 2) AS faturamento
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY faturamento ASC
LIMIT 1;


-- ============================================================
-- 4) PRODUTOS
-- ============================================================

-- 4.1) Top 10 produtos por faturamento
-- Esperado: 1º Notebook Gamer (477676.50) | 2º Console de Videogame (407195.15)
SELECT
    p.nome_produto,
    p.categoria,
    ROUND(SUM(v.faturamento), 2) AS faturamento,
    SUM(v.quantidade)            AS unidades_vendidas
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome_produto, p.categoria
ORDER BY faturamento DESC
LIMIT 10;

-- 4.2) Top 10 produtos por unidades vendidas
-- Esperado: 1º Capa Protetora (849 unidades)
SELECT
    p.nome_produto,
    SUM(v.quantidade)            AS unidades_vendidas,
    ROUND(SUM(v.faturamento), 2) AS faturamento
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome_produto
ORDER BY unidades_vendidas DESC
LIMIT 10;


-- ============================================================
-- 5) CATEGORIAS
-- Esperado: 7 linhas (1º Informática 1305682.13 = 18.2% | último Casa e Decoração 513563.88 = 7.1%)
-- ============================================================
SELECT
    p.categoria,
    ROUND(SUM(v.faturamento), 2)                                               AS faturamento,
    SUM(v.quantidade)                                                          AS unidades_vendidas,
    ROUND(SUM(v.faturamento) * 100 / (SELECT SUM(faturamento) FROM vendas), 1) AS percentual
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;


-- ============================================================
-- 6) CLIENTES
-- ============================================================

-- 6.1) Top 10 clientes por valor gasto
-- Esperado: 1º Daniel Lopes (62892.77, 31 compras) | 2º Felipe Nascimento (50204.17, 47 compras)
SELECT
    c.id_cliente,
    c.nome,
    c.cidade,
    c.estado,
    COUNT(*)                     AS compras,
    ROUND(SUM(v.faturamento), 2) AS total_gasto
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome, c.cidade, c.estado
ORDER BY total_gasto DESC
LIMIT 10;


-- ============================================================
-- 7) REGIÕES
-- Esperado: 5 linhas (1º Sudeste 3764119.03 = 52.3% | último Norte 335124.57 = 4.7%)
-- ============================================================
SELECT
    c.regiao,
    COUNT(DISTINCT c.id_cliente)                                               AS clientes,
    COUNT(*)                                                                   AS total_vendas,
    ROUND(SUM(v.faturamento), 2)                                               AS faturamento,
    ROUND(SUM(v.faturamento) * 100 / (SELECT SUM(faturamento) FROM vendas), 1) AS percentual
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.regiao
ORDER BY faturamento DESC;


-- ============================================================
-- 8) FORMAS DE PAGAMENTO
-- Esperado: 4 linhas (1º Cartão de Crédito 5036 vendas = 49.5% | Pix com maior ticket médio, 753.95)
-- ============================================================
SELECT
    forma_pagamento,
    COUNT(*)                                                                 AS total_vendas,
    ROUND(SUM(faturamento), 2)                                               AS faturamento,
    ROUND(SUM(faturamento) * 100 / (SELECT SUM(faturamento) FROM vendas), 1) AS percentual,
    ROUND(AVG(faturamento), 2)                                               AS ticket_medio
FROM vendas
GROUP BY forma_pagamento
ORDER BY total_vendas DESC;
