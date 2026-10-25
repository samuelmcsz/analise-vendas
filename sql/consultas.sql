-- ============================================================
-- Projeto: Análise de Vendas — Magalu (dados fictícios)
-- Autor: Samuel Martins Cardoso
-- Banco: vendas_magalu
-- Objetivo: análise exploratória e validação de qualidade dos dados
-- Banco de dados: MySQL 8+
-- Período analisado: 2025
-- ============================================================

USE vendas_magalu;

-- ============================================================
-- 0) BASE DE TRABALHO
-- CTE com as informações relevantes para todas as consultas
-- ============================================================
WITH base_vendas AS (
    SELECT
        v.id_venda,
        v.id_cliente,
        v.id_produto,
        v.data_venda,
        v.quantidade,
        v.preco_unitario,
        v.desconto,
        v.forma_pagamento,
        v.faturamento,
        c.nome AS nome_cliente,
        c.cidade,
        c.estado,
        c.regiao,
        p.nome_produto,
        p.categoria
    FROM vendas v
    JOIN clientes c ON c.id_cliente = v.id_cliente
    JOIN produtos p ON p.id_produto = v.id_produto
),

-- ============================================================
-- 1) CONFERÊNCIA DOS DADOS
-- Esperado: 1000 | 50 | 10000
-- ============================================================
contagem_geral AS (
    SELECT
        (SELECT COUNT(*) FROM clientes) AS total_clientes,
        (SELECT COUNT(*) FROM produtos) AS total_produtos,
        (SELECT COUNT(*) FROM vendas)   AS total_vendas
),

-- ============================================================
-- 2) VALIDAÇÃO DE QUALIDADE DOS DADOS
-- Importante para garantir que os KPIs reflitam a realidade
-- ============================================================
validacao AS (
    SELECT
        (SELECT COUNT(*)
         FROM vendas v
         LEFT JOIN clientes c ON c.id_cliente = v.id_cliente
         WHERE c.id_cliente IS NULL) AS vendas_sem_cliente,

        (SELECT COUNT(*)
         FROM vendas v
         LEFT JOIN produtos p ON p.id_produto = v.id_produto
         WHERE p.id_produto IS NULL) AS vendas_sem_produto,

        (SELECT COUNT(*)
         FROM vendas
         WHERE quantidade <= 0) AS quantidade_invalida,

        (SELECT COUNT(*)
         FROM vendas
         WHERE preco_unitario <= 0) AS preco_invalido,

        (SELECT COUNT(*)
         FROM vendas
         WHERE desconto < 0 OR desconto > 1) AS desconto_invalido,

        (SELECT COUNT(*)
         FROM vendas
         WHERE data_venda IS NULL) AS data_nula,

        (SELECT COUNT(*)
         FROM vendas
         WHERE faturamento < 0) AS faturamento_negativo,

        (SELECT COUNT(*)
         FROM vendas v
         WHERE ROUND(v.quantidade * v.preco_unitario * (1 - v.desconto), 2) <> ROUND(v.faturamento, 2)) AS faturamento_inconsistente
),

-- ============================================================
-- 3) KPIs GERAIS
-- Esperado: 7190613.51 | 10000 | 719.06 | 14256 | 979 | 6.19 | 473866.09
-- ============================================================
kp_is_gerais AS (
    SELECT
        ROUND(SUM(faturamento), 2)                                    AS faturamento_total,
        COUNT(*)                                                      AS total_vendas,
        ROUND(AVG(faturamento), 2)                                    AS ticket_medio,
        SUM(quantidade)                                               AS unidades_vendidas,
        COUNT(DISTINCT id_cliente)                                    AS clientes_ativos,
        ROUND(AVG(desconto) * 100, 2)                                 AS desconto_medio_pct,
        ROUND(SUM(quantidade * preco_unitario) - SUM(faturamento), 2) AS total_descontos
    FROM vendas
)
SELECT
    '-- 1. Contagem geral --' AS secao,
    total_clientes AS valor_1,
    total_produtos AS valor_2,
    total_vendas AS valor_3,
    NULL AS valor_4,
    NULL AS valor_5
FROM contagem_geral

UNION ALL

SELECT
    '-- 2. Validação de qualidade --' AS secao,
    vendas_sem_cliente,
    vendas_sem_produto,
    quantidade_invalida,
    preco_invalido,
    desconto_invalido
FROM validacao

UNION ALL

SELECT
    '-- 3. KPIs gerais --' AS secao,
    faturamento_total,
    total_vendas,
    ticket_medio,
    unidades_vendidas,
    clientes_ativos
FROM kp_is_gerais

UNION ALL

SELECT
    '-- 3. KPIs complementares --' AS secao,
    desconto_medio_pct,
    total_descontos,
    NULL,
    NULL,
    NULL
FROM kp_is_gerais;

-- ============================================================
-- 4) FATURAMENTO MENSAL
-- Esperado: 12 linhas (jan = 429512.88 | dez = 815905.63)
-- ============================================================
SELECT
    MONTH(data_venda)                  AS mes,
    COUNT(*)                           AS total_vendas,
    ROUND(SUM(faturamento), 2)         AS faturamento,
    ROUND(AVG(faturamento), 2)         AS ticket_medio,
    SUM(quantidade)                   AS unidades_vendidas
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY mes;

-- 4.1) Mês que mais faturou (esperado: mês 12, 815905.63)
SELECT
    MONTH(data_venda)          AS mes,
    ROUND(SUM(faturamento), 2) AS faturamento
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY faturamento DESC
LIMIT 1;

-- 4.2) Mês que menos faturou (esperado: mês 1, 429512.88)
SELECT
    MONTH(data_venda)          AS mes,
    ROUND(SUM(faturamento), 2) AS faturamento
FROM vendas
GROUP BY MONTH(data_venda)
ORDER BY faturamento ASC
LIMIT 1;

-- 4.3) Comparativo de crescimento mês a mês
WITH faturamento_mensal AS (
    SELECT
        MONTH(data_venda) AS mes,
        ROUND(SUM(faturamento), 2) AS faturamento
    FROM vendas
    GROUP BY MONTH(data_venda)
)
SELECT
    mes,
    faturamento,
    LAG(faturamento) OVER (ORDER BY mes) AS faturamento_mes_anterior,
    ROUND(((faturamento - LAG(faturamento) OVER (ORDER BY mes)) / NULLIF(LAG(faturamento) OVER (ORDER BY mes), 0)) * 100, 2) AS variacao_pct
FROM faturamento_mensal
ORDER BY mes;


-- ============================================================
-- 5) PRODUTOS
-- ============================================================

-- 5.1) Top 10 produtos por faturamento
-- Esperado: 1º Notebook Gamer (477676.50) | 2º Console de Videogame (407195.15)
SELECT
    p.nome_produto,
    p.categoria,
    ROUND(SUM(v.faturamento), 2) AS faturamento,
    SUM(v.quantidade)            AS unidades_vendidas,
    ROUND(AVG(v.faturamento), 2) AS ticket_medio_por_venda
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome_produto, p.categoria
ORDER BY faturamento DESC
LIMIT 10;

-- 5.2) Top 10 produtos por unidades vendidas
-- Esperado: 1º Capa Protetora (849 unidades)
SELECT
    p.nome_produto,
    SUM(v.quantidade)            AS unidades_vendidas,
    ROUND(SUM(v.faturamento), 2) AS faturamento,
    ROUND(AVG(v.faturamento), 2) AS ticket_medio_por_venda
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome_produto
ORDER BY unidades_vendidas DESC
LIMIT 10;

-- 5.3) Produtos com maior margem aparente (faturamento / quantidade)
SELECT
    p.nome_produto,
    p.categoria,
    ROUND(SUM(v.faturamento), 2) AS faturamento,
    ROUND(SUM(v.quantidade), 0) AS unidades_vendidas,
    ROUND(SUM(v.faturamento) / NULLIF(SUM(v.quantidade), 0), 2) AS faturamento_por_unidade
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome_produto, p.categoria
ORDER BY faturamento_por_unidade DESC
LIMIT 10;


-- ============================================================
-- 6) CATEGORIAS
-- Esperado: 7 linhas (1º Informática 1305682.13 = 18.2% | último Casa e Decoração 513563.88 = 7.1%)
-- ============================================================
SELECT
    p.categoria,
    ROUND(SUM(v.faturamento), 2)                                               AS faturamento,
    SUM(v.quantidade)                                                          AS unidades_vendidas,
    ROUND(SUM(v.faturamento) * 100 / (SELECT SUM(faturamento) FROM vendas), 1) AS percentual,
    ROUND(AVG(v.faturamento), 2)                                               AS ticket_medio_categoria
FROM vendas v
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY p.categoria
ORDER BY faturamento DESC;


-- ============================================================
-- 7) CLIENTES
-- ============================================================

-- 7.1) Top 10 clientes por valor gasto
-- Esperado: 1º Daniel Lopes (62892.77, 31 compras) | 2º Felipe Nascimento (50204.17, 47 compras)
SELECT
    c.id_cliente,
    c.nome,
    c.cidade,
    c.estado,
    COUNT(*)                     AS compras,
    ROUND(SUM(v.faturamento), 2) AS total_gasto,
    ROUND(AVG(v.faturamento), 2) AS ticket_medio
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome, c.cidade, c.estado
ORDER BY total_gasto DESC
LIMIT 10;

-- 7.2) Top 10 clientes por número de compras
SELECT
    c.id_cliente,
    c.nome,
    c.cidade,
    c.estado,
    COUNT(*) AS compras,
    ROUND(SUM(v.faturamento), 2) AS total_gasto
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome, c.cidade, c.estado
ORDER BY compras DESC
LIMIT 10;


-- ============================================================
-- 8) REGIÕES
-- Esperado: 5 linhas (1º Sudeste 3764119.03 = 52.3% | último Norte 335124.57 = 4.7%)
-- ============================================================
SELECT
    c.regiao,
    COUNT(DISTINCT c.id_cliente)                                               AS clientes,
    COUNT(*)                                                                   AS total_vendas,
    ROUND(SUM(v.faturamento), 2)                                               AS faturamento,
    ROUND(SUM(v.faturamento) * 100 / (SELECT SUM(faturamento) FROM vendas), 1) AS percentual,
    ROUND(AVG(v.faturamento), 2)                                               AS ticket_medio_regiao
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
GROUP BY c.regiao
ORDER BY faturamento DESC;

-- 8.1) Faturamento por região e categoria
SELECT
    c.regiao,
    p.categoria,
    ROUND(SUM(v.faturamento), 2) AS faturamento,
    SUM(v.quantidade)            AS unidades_vendidas
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY c.regiao, p.categoria
ORDER BY c.regiao, faturamento DESC;


-- ============================================================
-- 9) FORMAS DE PAGAMENTO
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

-- 9.1) Ticket médio por forma de pagamento
SELECT
    forma_pagamento,
    ROUND(AVG(faturamento), 2) AS ticket_medio,
    ROUND(SUM(faturamento), 2) AS faturamento_total,
    COUNT(*) AS total_vendas
FROM vendas
GROUP BY forma_pagamento
ORDER BY ticket_medio DESC;


-- ============================================================
-- 10) ÍNDICES E MELHORIAS DE PERFORMANCE
-- Sugestões para otimizar o banco caso os dados cresçam
-- ============================================================
-- CREATE INDEX idx_vendas_data_venda ON vendas(data_venda);
-- CREATE INDEX idx_vendas_id_cliente ON vendas(id_cliente);
-- CREATE INDEX idx_vendas_id_produto ON vendas(id_produto);
-- CREATE INDEX idx_vendas_forma_pagamento ON vendas(forma_pagamento);
-- CREATE INDEX idx_clientes_regiao ON clientes(regiao);
-- CREATE INDEX idx_produtos_categoria ON produtos(categoria);


-- ============================================================
-- 11) RESUMO EXECUTIVO (VERSÃO RÁPIDA)
-- ============================================================
SELECT
    'Faturamento total' AS indicador,
    ROUND(SUM(faturamento), 2) AS valor
FROM vendas

UNION ALL

SELECT
    'Ticket médio',
    ROUND(AVG(faturamento), 2)
FROM vendas

UNION ALL

SELECT
    'Clientes ativos',
    COUNT(DISTINCT id_cliente)
FROM vendas

UNION ALL

SELECT
    'Venda mais cara',
    ROUND(MAX(faturamento), 2)
FROM vendas;
