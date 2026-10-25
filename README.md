📊 Análise de Vendas — Magalu

Projeto de estudo em Dados e Analytics, com dados fictícios inspirados no varejo brasileiro, utilizando Python, MySQL, SQL e Power BI para explorar indicadores de desempenho comercial, tendências de venda e comportamento do cliente.

«Aviso: Este projeto não utiliza dados reais da Magazine Luiza (Magalu). Todos os clientes, produtos, vendas e valores foram gerados artificialmente para fins educacionais e de portfólio.»

---

📌 Visão geral

Este repositório simula uma análise de vendas em um cenário de e-commerce/retail, com foco em:

- Faturamento total e evolução mensal;
- Produtos e categorias mais lucrativas;
- Clientes e regiões com maior contribuição;
- Formas de pagamento preferidas;
- Validação da qualidade dos dados;
- KPIs e relatórios analíticos em SQL.

A proposta do projeto é praticar a geração de dados sintéticos, a modelagem de um banco relacional e a análise exploratória com consultas SQL.

---

🛠️ Stack tecnológica

- Python: geração dos dados fictícios e carregamento no banco;
- MySQL: armazenamento dos dados em estrutura relacional;
- SQL: consultas, validações e indicadores;
- Power BI: visualização e dashboard (em desenvolvimento).

---

📁 Estrutura do projeto

analise-vendas/
│
├── dados/
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
│
├── sql/
│   └── consultas.sql
│
├── carregar_mysql.py
└── README.md

---

🗄️ Base de dados

O script gera uma base fictícia com:

- 1.000 clientes
- 50 produtos
- 10.000 vendas
- Período: janeiro a dezembro de 2025

Tabelas principais

"clientes"

ID, nome, cidade, estado e região.

"produtos"

ID, nome, categoria e preço.

"vendas"

Data, cliente, produto, quantidade, desconto, faturamento e forma de pagamento.

O banco criado pelo script é chamado "vendas_magalu".

---

⚙️ Pré-requisitos

Antes de executar o projeto, certifique-se de ter:

- Python 3.x instalado;
- MySQL Server em execução;
- Permissões para criar e excluir bancos de dados;
- Pacote "mysql-connector-python".

---

🚀 Como executar

1. Instalar a dependência

python -m pip install mysql-connector-python

2. Executar o script principal

Na raiz do projeto, execute:

python carregar_mysql.py

3. O que o script faz

O script realiza os seguintes passos:

1. Verifica se os arquivos CSV já existem na pasta "dados/";
2. Gera a base fictícia caso algum arquivo esteja ausente;
3. Valida os cabeçalhos dos arquivos CSV;
4. Solicita confirmação explícita com a palavra "RECRIAR";
5. Apaga e recria o banco "vendas_magalu";
6. Cria as tabelas do banco;
7. Importa os registros para o MySQL.

«Atenção: ao confirmar, o banco será recriado e os dados existentes serão substituídos.»

---

📈 Consultas SQL

O arquivo "sql/consultas.sql" reúne consultas para:

- Conferência de qualidade dos dados;
- KPIs gerais de faturamento e ticket médio;
- Evolução mensal do faturamento;
- Ranking de produtos e categorias;
- Análise por cliente e região;
- Comparação por forma de pagamento;
- Resumo executivo.

Após carregar a base no MySQL, as consultas podem ser executadas diretamente no banco "vendas_magalu".

---

📊 Indicadores e análises cobertas

O projeto inclui métricas como:

- Faturamento total;
- Quantidade de vendas;
- Ticket médio;
- Unidades vendidas;
- Clientes ativos;
- Desconto médio;
- Faturamento por mês;
- Ranking de produtos e categorias;
- Faturamento por região;
- Desempenho por forma de pagamento.

---

🎯 Dashboard e próximos passos

A etapa atual do projeto está focada em modelagem, geração de dados e análise em SQL. A visualização em Power BI foi planejada como evolução futura.

Checklist do projeto

- [x] Gerar base fictícia e arquivos CSV;
- [x] Carregar dados no MySQL;
- [x] Desenvolver consultas SQL e KPIs;
- [ ] Construir dashboard no Power BI;
- [ ] Documentar insights obtidos em análise;
- [ ] Preparar apresentação do projeto para portfólio.

---

⚠️ Observações importantes

- Os dados são artificiais e não representam informações reais da Magalu;
- Caso os CSVs sejam regenerados, os indicadores podem mudar;
- O projeto tem foco em aprendizado e demonstração de pipeline analítico.

---

👨‍💻 Autor

Samuel Martins Cardoso

Estudante de Dados e Analytics, com foco em SQL, bancos de dados, Excel e Power BI.

Projeto educacional com dados gerados artificialmente. Nenhuma informação representa dados internos, oficiais ou reais da Magazine Luiza.