# Análise de Vendas — Magalu | Data Analytics

Projeto de estudo em Dados e Analytics com dados fictícios para simular uma análise de vendas inspirada no varejo da Magazine Luiza (Magalu).

> **Aviso:** este projeto não utiliza dados reais da Magazine Luiza. Clientes, produtos, vendas, valores e resultados são fictícios e destinados exclusivamente a fins educacionais e de portfólio.

## Objetivos

- Analisar o desempenho das vendas e a evolução mensal do faturamento.
- Identificar produtos e categorias com maior faturamento e volume.
- Avaliar clientes, regiões e formas de pagamento.
- Praticar Python, MySQL e SQL.
- Construir um dashboard no Power BI.

## Tecnologias

| Tecnologia | Utilização |
|---|---|
| Python | Geração dos dados fictícios e carga no banco |
| MySQL | Armazenamento e consulta dos dados |
| SQL | Análises, validações e KPIs |
| Power BI | Dashboard e visualização (em desenvolvimento) |
| Excel | Organização e exploração dos dados |

## Estrutura do projeto

\`\`\`text
analise-vendas/
├── dados/
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
├── sql/
│   └── consultas.sql
├── carregar_mysql.py
└── README.md
\`\`\`

## Base de dados

- **1.000 clientes**
- **50 produtos**
- **10.000 vendas**
- **Período:** janeiro a dezembro de 2025

O banco \`vendas_magalu\` possui três tabelas relacionadas:

- \`clientes\`: identificação, nome, cidade, estado e região.
- \`produtos\`: identificação, nome, categoria e preço.
- \`vendas\`: data, cliente, produto, quantidade, preço unitário, desconto, faturamento e forma de pagamento.

## Como executar

### 1. Pré-requisitos

- Python 3 instalado.
- MySQL Server instalado e em execução.
- Usuário MySQL com permissão para criar e excluir bancos de dados.

### 2. Instalar a dependência

\`\`\`bash
python -m pip install mysql-connector-python
\`\`\`

### 3. Gerar os dados e carregar no MySQL

Na pasta raiz do projeto, execute:

\`\`\`bash
python carregar_mysql.py
\`\`\`

O script único:

1. Verifica os CSVs na pasta \`dados/\`.
2. Se algum dos três CSVs estiver ausente, gera os arquivos fictícios.
3. Valida os cabeçalhos dos CSVs.
4. Solicita a confirmação explícita \`RECRIAR\`.
5. Recria o banco \`vendas_magalu\`, cria as tabelas e importa os registros.

**Atenção:** confirmar a operação apaga e recria o banco \`vendas_magalu\`, substituindo tabelas e dados que já existam nele. Faça backup antes se precisar preservar o banco. Se a confirmação não for digitada exatamente como solicitado, a carga é cancelada.

Se os CSVs já existirem, o script os preserva e carrega os dados atuais; uma nova base só é gerada quando pelo menos um dos três arquivos estiver faltando.

## Consultas SQL

O arquivo [\`sql/consultas.sql\`](sql/consultas.sql) reúne consultas para:

- Conferência do volume e validação da qualidade dos dados.
- KPIs gerais, faturamento e ticket médio.
- Evolução mensal e variação percentual.
- Ranking de produtos e desempenho por categoria.
- Análises de clientes e regiões.
- Formas de pagamento e resumo executivo.

Execute as consultas após carregar o banco \`vendas_magalu\), usando MySQL 8 ou compatível.

## Análises e indicadores

As consultas cobrem faturamento total, quantidade de vendas, ticket médio, unidades vendidas, clientes ativos, evolução mensal, produtos e categorias de destaque, distribuição regional e formas de pagamento. Os resultados são calculados a partir dos CSVs carregados no banco.

Se os CSVs forem regenerados, os indicadores poderão mudar. Todos os resultados são referentes a dados fictícios e não devem ser interpretados como dados reais da Magalu.

## Dashboard Power BI

**Status:** em desenvolvimento.

O dashboard deverá apresentar KPIs gerais, evolução mensal do faturamento, ranking de produtos, desempenho por categoria e região e distribuição por forma de pagamento.

## Próximas etapas

- [x] Criar a base fictícia e os CSVs.
- [x] Criar o carregamento para MySQL.
- [x] Desenvolver consultas SQL e KPIs.
- [ ] Construir o dashboard no Power BI.
- [ ] Documentar os principais insights com resultados efetivamente obtidos.
- [ ] Finalizar a apresentação do projeto para portfólio.

## Autor

**Samuel Martins Cardoso**  
Estudante de Dados e Analytics, com foco em SQL, bancos de dados, Excel e Power BI.

---

**Nota:** projeto educacional com dados gerados artificialmente. Nenhuma informação representa dados internos, oficiais ou reais da Magazine Luiza.
