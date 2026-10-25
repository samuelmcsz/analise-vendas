# Análise de Vendas — Magalu

Projeto de estudo em dados e analytics com base fictícia inspirada no varejo brasileiro, utilizando Python, MySQL, SQL e, futuramente, Power BI para explorar indicadores, tendências e desempenho comercial.

> Aviso: este projeto não utiliza dados reais da Magazine Luiza (Magalu). Todos os dados, clientes, produtos, vendas e valores são fictícios e foram gerados apenas para fins educacionais e de portfólio.

## Visão geral

Este repositório simula uma análise de vendas em um cenário de e-commerce/retail, com foco em:

- faturamento total e evolução mensal;
- produtos e categorias mais lucrativas;
- comportamento por região e cliente;
- formas de pagamento;
- validação da qualidade dos dados;
- uso de SQL para extração de KPIs e insights.

A ideia é praticar a geração de dados sintéticos, a modelagem de banco relacional e a análise exploratória com consultas SQL.

## Stack tecnológica

- Python: geração dos dados fictícios e carga no banco;
- MySQL: armazenamento dos dados em estrutura relacional;
- SQL: consultas, KPIs e validação;
- Power BI: visualização e dashboard (em desenvolvimento);

## Estrutura do projeto

```text
analise-vendas/
├── dados/
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
├── sql/
│   └── consultas.sql
├── carregar_mysql.py
├── README.md
└── .gitignore
```

## Base de dados

O projeto gera uma base fictícia com:

- 1.000 clientes;
- 50 produtos;
- 10.000 vendas;
- período de janeiro a dezembro de 2025.

### Tabelas principais

- `clientes`: id, nome, cidade, estado e região;
- `produtos`: id, nome, categoria e preço;
- `vendas`: data, cliente, produto, quantidade, desconto, faturamento e forma de pagamento.

O banco criado pelo script é chamado `vendas_magalu`.

## Requisitos

Antes de executar o projeto, certifique-se de ter:

- Python 3.x instalado;
- MySQL Server instalado e em execução;
- acesso com permissão para criar e excluir bancos de dados;
- biblioteca `mysql-connector-python`.

## Como executar

### 1) Instale a dependência

```bash
python -m pip install mysql-connector-python
```

### 2) Execute o script principal

Na raiz do projeto:

```bash
python carregar_mysql.py
```

### 3) O que o script faz

O script realiza os seguintes passos:

1. verifica se os arquivos CSV já existem em `dados/`;
2. gera a base fictícia caso algum arquivo esteja ausente;
3. valida os cabeçalhos dos CSVs;
4. solicita confirmação explícita com `RECRIAR`;
5. apaga e recria o banco `vendas_magalu`;
6. cria as tabelas;
7. importa os registros para MySQL.

> Atenção: ao confirmar, o banco será recriado e os dados existentes serão substituídos.

## Consultas SQL

O arquivo [`sql/consultas.sql`](sql/consultas.sql) reúne consultas para:

- conferência da qualidade dos dados;
- KPIs gerais de faturamento e ticket médio;
- evolução mensal do faturamento;
- ranking de produtos e categorias;
- análise por cliente e região;
- comparação por forma de pagamento;
- resumo executivo.

Após carregar a base no MySQL, é possível executar as consultas diretamente no banco `vendas_magalu`.

## Indicadores cobertos

As análises incluem métricas como:

- faturamento total;
- quantidade de vendas;
- ticket médio;
- unidades vendidas;
- clientes ativos;
- desconto médio;
- faturamento por mês;
- ranking de produtos e categorias;
- faturamento por região;
- desempenho por forma de pagamento.

## Dashboard e próximos passos

A estrutura atual do projeto está focada em dados, modelagem e consultas SQL. A etapa de visualização em Power BI está planejada para evolução futura.

Checklist:

- [x] Gerar base fictícia e CSVs;
- [x] Carregar dados no MySQL;
- [x] Desenvolver consultas SQL e KPIs;
- [ ] Construir dashboard no Power BI;
- [ ] Documentar insights com resultados reais obtidos;
- [ ] Preparar apresentação para portfólio.

## Observações importantes

- Os dados são artificiais e não representam informações reais da Magalu;
- Caso os CSVs sejam regenerados, os indicadores podem mudar;
- O projeto é voltado para aprendizado e demonstração de pipeline analítico.

## Autor

Samuel Martins Cardoso

Estudante de Dados e Analytics com foco em SQL, bases de dados, Excel e Power BI.

---

Projeto educacional com dados gerados artificialmente. Nenhuma informação representa dados internos, oficiais ou reais da Magazine Luiza.
