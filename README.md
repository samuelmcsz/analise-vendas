
# 📊 Análise de Vendas — Magalu

**📚 Projeto de estudo em Dados e Analytics | Python · MySQL · SQL · Power BI**

Projeto educacional de análise de vendas com dados fictícios inspirados no varejo brasileiro. O objetivo é explorar indicadores de desempenho comercial, tendências de venda e comportamento do cliente por meio da geração de dados, modelagem relacional e análise em SQL.

> ⚠️ **Aviso sobre os dados**
>
> Este projeto não utiliza dados reais da Magazine Luiza (Magalu). Todos os clientes, produtos, vendas e valores foram gerados artificialmente para fins educacionais e de portfólio.

---

## 📌 1. Visão geral

Este repositório simula uma análise de vendas em um cenário de e-commerce/retail.

### 🎯 Principais objetivos

| 🔎 Área de análise | 📋 O que investigar |
|---|---|
| 💰 Faturamento | Faturamento total e evolução mensal |
| 📦 Produtos | Produtos e categorias mais lucrativas |
| 👥 Clientes | Clientes com maior contribuição |
| 🌎 Regiões | Regiões com maior contribuição |
| 💳 Pagamentos | Formas de pagamento preferidas |
| ✅ Qualidade dos dados | Validação e conferência dos dados |
| 📈 Indicadores | KPIs e relatórios analíticos em SQL |

A proposta é praticar a geração de dados sintéticos, a modelagem de um banco de dados relacional e a análise exploratória com consultas SQL.

---

## 🛠️ 2. Stack tecnológica

| 💻 Tecnologia | ⚙️ Aplicação no projeto |
|---|---|
| **🐍 Python** | Geração dos dados fictícios e carregamento no banco |
| **🗄️ MySQL** | Armazenamento dos dados em estrutura relacional |
| **🔍 SQL** | Consultas, validações e indicadores |
| **📊 Power BI** | Visualização e dashboard — em desenvolvimento |

---

## 📁 3. Estrutura do projeto

```text id="v6y2kp"
analise-vendas/
├── dados/
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
├── sql/
│   └── consultas.sql
├── carregar_mysql.py
└── README.md
```

---

## 🗄️ 4. Base de dados

O script gera uma base de dados fictícia com os seguintes volumes:

| 📌 Indicador | 📊 Quantidade ou período |
|---|---:|
| 👥 Clientes | 1.000 |
| 📦 Produtos | 50 |
| 🛒 Vendas | 10.000 |
| 📅 Período analisado | Janeiro a dezembro de 2025 |

### 📋 Tabelas principais

| 🗂️ Tabela | 📝 Informações armazenadas |
|---|---|
| `clientes` | ID, nome, cidade, estado e região |
| `produtos` | ID, nome, categoria e preço |
| `vendas` | Data, cliente, produto, quantidade, desconto, faturamento e forma de pagamento |

**🗃️ Banco de dados:** `vendas_magalu`

---

## ⚙️ 5. Pré-requisitos

Antes de executar o projeto, certifique-se de ter os seguintes componentes instalados ou configurados:

- 🐍 Python 3.x;
- 🗄️ MySQL Server em execução;
- 🔐 Permissões para criar e excluir bancos de dados;
- 📦 Pacote `mysql-connector-python`.

---

## 🚀 6. Como executar o projeto

### 📦 Etapa 1 — Instalar a dependência

Execute no terminal:

```bash id="2ofpxl"
python -m pip install mysql-connector-python
```

### ▶️ Etapa 2 — Executar o script principal

Na raiz do projeto, execute:

```bash id="4y2k91"
python carregar_mysql.py
```

### 🔄 Etapa 3 — Entender o processo de carregamento

O script executa as seguintes operações:

| 🔢 Ordem | ⚙️ Operação |
|---:|---|
| 1 | Verifica se os arquivos CSV já existem na pasta `dados/` |
| 2 | Gera a base fictícia caso algum arquivo esteja ausente |
| 3 | Valida os cabeçalhos dos arquivos CSV |
| 4 | Solicita confirmação explícita com a palavra `RECRIAR` |
| 5 | Apaga e recria o banco `vendas_magalu` |
| 6 | Cria as tabelas do banco |
| 7 | Importa os registros para o MySQL |

> ⚠️ **Atenção:** ao confirmar a operação, o banco será recriado e os dados existentes serão substituídos.

---

## 🔍 7. Consultas SQL

O arquivo `sql/consultas.sql` reúne consultas destinadas à análise e validação dos dados.

| 📂 Categoria | 📊 Análises incluídas |
|---|---|
| ✅ Qualidade dos dados | Conferência da qualidade dos dados |
| 💰 Indicadores gerais | Faturamento e ticket médio |
| 📅 Evolução temporal | Evolução mensal do faturamento |
| 🏆 Produtos | Ranking de produtos e categorias |
| 👥 Clientes e regiões | Análise por cliente e região |
| 💳 Pagamentos | Comparação por forma de pagamento |
| 📑 Gestão | Resumo executivo |

Após carregar a base no MySQL, as consultas podem ser executadas diretamente no banco `vendas_magalu`.

---

## 📈 8. Indicadores e análises cobertas

O projeto contempla os seguintes indicadores:

| 📊 Indicador | 🎯 Objetivo |
|---|---|
| 💰 Faturamento total | Analisar o faturamento acumulado |
| 🛒 Quantidade de vendas | Avaliar o volume de vendas |
| 🧾 Ticket médio | Analisar o valor médio por venda |
| 📦 Unidades vendidas | Avaliar o volume de unidades comercializadas |
| 👥 Clientes ativos | Analisar a quantidade de clientes ativos |
| 🏷️ Desconto médio | Avaliar os descontos concedidos |
| 📅 Faturamento por mês | Acompanhar a evolução mensal |
| 🏆 Ranking de produtos e categorias | Comparar o desempenho de produtos e categorias |
| 🌎 Faturamento por região | Comparar o desempenho regional |
| 💳 Desempenho por forma de pagamento | Analisar as formas de pagamento utilizadas |

---

## 🎯 9. Dashboard e próximos passos

A etapa atual do projeto está focada em modelagem, geração de dados e análise em SQL.

A visualização em Power BI foi planejada como evolução futura.

### ✅ Checklist do projeto

- [x] 📄 Gerar base fictícia e arquivos CSV
- [x] 🗄️ Carregar dados no MySQL
- [x] 🔍 Desenvolver consultas SQL e KPIs
- [ ] 📊 Construir dashboard no Power BI
- [ ] 💡 Documentar insights obtidos em análise
- [ ] 🎤 Preparar apresentação do projeto para portfólio

---

## ⚠️ 10. Observações importantes

- Os dados são artificiais e não representam informações reais da Magalu.
- Caso os CSVs sejam regenerados, os indicadores podem mudar.
- O projeto tem foco em aprendizado e demonstração de pipeline analítico.

---

## 👨‍💻 11. Autor

**Samuel Martins Cardoso**

🎓 Estudante de Dados e Analytics, com foco em SQL, bancos de dados, Excel e Power BI.

📌 **Finalidade:** projeto educacional com dados gerados artificialmente. Nenhuma informação representa dados internos, oficiais ou reais da Magazine Luiza.
