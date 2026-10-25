Análise de Vendas — Magalu
Projeto de estudo em dados e analytics com dados fictícios inspirados no varejo brasileiro, utilizando Python, MySQL, SQL e Power BI para explorar indicadores de desempenho comercial, tendências de venda e comportamento do cliente.

Aviso: este projeto não utiliza dados reais da Magazine Luiza (Magalu). Todos os clientes, produtos, vendas e valores foram gerados artificialmente para fins educacionais e de portfólio.

Visão geral
Este repositório simula uma análise de vendas em um cenário de e-commerce/retail, com foco em:

faturamento total e evolução mensal;
produtos e categorias mais lucrativas;
clientes e regiões com maior contribuição;
formas de pagamento preferidas;
validação da qualidade dos dados;
KPIs e relatórios analíticos em SQL.
A proposta do projeto é praticar a geração de dados sintéticos, o modelamento de um banco relacional e a análise exploratória com consultas SQL.

Stack tecnológica
Python: geração dos dados fictícios e carregamento no banco;
MySQL: armazenamento dos dados em estrutura relacional;
SQL: consultas, validações e indicadores;
Power BI: visualização e dashboard (em desenvolvimento).
Estrutura do projeto
analise-vendas/
├── dados/
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
├── sql/
│   └── consultas.sql
├── carregar_mysql.py
├── README.md

## Base de dados

O script gera uma base fictícia com:

- 1.000 clientes;
- 50 produtos;
- 10.000 vendas;
- período compreendido entre janeiro e dezembro de 2025.

### Tabelas principais

- `clientes`: id, nome, cidade, estado e região;
- `produtos`: id, nome, categoria e preço;
- `vendas`: data, cliente, produto, quantidade, desconto, faturamento e forma de pagamento.

O banco criado pelo script é chamado `vendas_magalu`.

## Pré-requisitos

Antes de executar o projeto, certifique-se de ter:

- Python 3.x instalado;
- MySQL Server em execução;
- permissões para criar e excluir bancos de dados;
- pacote `mysql-connector-python`.

## Como executar

### 1) Instalar a dependência

```bash
python -m pip install mysql-connector-python
2) Executar o script principal
Na raiz do projeto:

python carregar_mysql.py
3) O que o script faz
O script realiza os seguintes passos:

verifica se os arquivos CSV já existem na pasta dados/;
gera a base fictícia caso algum arquivo esteja ausente;
valida os cabeçalhos dos arquivos CSV;
solicita confirmação explícita com a palavra RECRIAR;
apaga e recria o banco vendas_magalu;
cria as tabelas do banco;
importa os registros para o MySQL.
Atenção: ao confirmar, o banco será recriado e os dados existentes serão substituídos.

Consultas SQL
O arquivo sql/consultas.sql reúne consultas para:

conferência de qualidade dos dados;
KPIs gerais de faturamento e ticket médio;
evolução mensal do faturamento;
ranking de produtos e categorias;
análise por cliente e região;
comparação por forma de pagamento;
resumo executivo.
Após carregar a base no MySQL, as consultas podem ser executadas diretamente no banco vendas_magalu.

Indicadores e análises cobertas
O projeto inclui métricas como:

faturamento total;
quantidade de vendas;
ticket médio;
unidades vendidas;
clientes ativos;
desconto médio;
faturamento por mês;
ranking de produtos e categorias;
faturamento por região;
desempenho por forma de pagamento.
Dashboard e próximos passos
A etapa atual do projeto está focada em modelagem, geração de dados e análise em SQL. A visualização em Power BI foi planejada como evolução futura.

Checklist:

 Gerar base fictícia e arquivos CSV;
 Carregar dados no MySQL;
 Desenvolver consultas SQL e KPIs;
 Construir dashboard no Power BI;
 Documentar insights obtidos em análise;
 Preparar apresentação do projeto para portfólio.
Observações importantes
os dados são artificiais e não representam informações reais da Magalu;
caso os CSVs sejam regenerados, os indicadores podem mudar;
o projeto tem foco em aprendizado e demonstração de pipeline analítico.
Autor
Samuel Martins Cardoso

Estudante de Dados e Analytics com foco em SQL, bancos de dados, Excel e Power BI.

Projeto educacional com dados gerados artificialmente. Nenhuma informação representa dados internos, oficiais ou reais da Magazine Luiza.