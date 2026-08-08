📊 Análise de Vendas — Magalu | Data Analytics

«Projeto de estudo em Dados & Analytics utilizando dados fictícios para simular uma análise de vendas da Magazine Luiza (Magalu).»

---

📌 Sobre o Projeto

Este projeto foi desenvolvido com o objetivo de praticar SQL, Banco de Dados e Análise de Dados através de uma simulação de vendas inspirada na operação de uma grande empresa varejista, utilizando a Magazine Luiza (Magalu) como referência.

«⚠️ Importante: este projeto não utiliza dados reais da Magazine Luiza. Todos os clientes, produtos, vendas, valores e resultados são dados fictícios gerados para fins educacionais.»

A análise busca transformar dados brutos em informações e indicadores que poderiam auxiliar na tomada de decisões de negócio.

---

🎯 Objetivos

- Analisar o desempenho das vendas;
- Identificar produtos com maior faturamento;
- Avaliar a evolução das vendas ao longo do tempo;
- Comparar o desempenho entre categorias;
- Analisar o comportamento dos clientes;
- Identificar regiões com maior faturamento;
- Criar indicadores de desempenho (KPIs);
- Praticar consultas SQL e relacionamentos entre tabelas;
- Desenvolver um dashboard no Power BI.

---

🛠️ Tecnologias Utilizadas

Tecnologia| Utilização
🐍 Python| Geração dos dados fictícios
🗄️ MySQL| Armazenamento e gerenciamento do banco de dados
🔎 SQL| Consultas, filtros, agregações e análise
📊 Power BI| Dashboard e visualização dos indicadores
📗 Excel| Organização e apoio na exploração dos dados
💻 VS Code| Desenvolvimento e organização do projeto

---

🗂️ Estrutura do Projeto

📁 analise-vendas
│
├── 📁 dados
│   ├── clientes.csv
│   ├── produtos.csv
│   └── vendas.csv
│
├── 📁 sql
│   └── consultas.sql
│
├── 📁 dashboard
│   └── dashboard.pbix
│
├── 📁 imagens
│   └── dashboard.png
│
├── gerar_dados.py
│
└── README.md

---

🗄️ Banco de Dados

O projeto utiliza três tabelas principais:

👥 Clientes

- ID do cliente;
- Nome;
- Cidade;
- Estado;
- Região.

📦 Produtos

- ID do produto;
- Nome do produto;
- Categoria;
- Preço.

🛒 Vendas

- ID da venda;
- Data da venda;
- Cliente;
- Produto;
- Quantidade;
- Preço unitário;
- Desconto;
- Faturamento;
- Forma de pagamento.

📊 Volume de dados

A base foi criada para simular um cenário de vendas:

- 1.000 clientes
- 50 produtos
- 10.000 vendas
- Período analisado: 2025

---

📈 Análises Realizadas

💰 Faturamento

- Faturamento total;
- Ticket médio;
- Evolução do faturamento por mês;
- Comparação entre períodos.

📦 Produtos

- Produtos mais vendidos;
- Produtos com maior faturamento;
- Categorias com maior desempenho;
- Quantidade de unidades vendidas.

👥 Clientes

- Quantidade de clientes;
- Clientes com maior volume de compras;
- Faturamento por cliente;
- Distribuição dos clientes por região.

🌎 Regiões

- Faturamento por região;
- Quantidade de clientes por região;
- Volume de vendas por localização.

💳 Formas de Pagamento

- Quantidade de vendas por método;
- Faturamento por forma de pagamento.

---

🔎 Principais Perguntas de Negócio

Durante o projeto, algumas perguntas serão utilizadas para orientar a análise:

1. Qual foi o faturamento total?
2. Qual foi o ticket médio?
3. Qual mês apresentou o maior faturamento?
4. Quais produtos geraram mais receita?
5. Quais produtos tiveram maior volume de vendas?
6. Qual categoria apresentou o melhor desempenho?
7. Qual região gerou mais faturamento?
8. Quais clientes realizaram mais compras?
9. Qual foi a forma de pagamento mais utilizada?
10. Existem períodos com desempenho significativamente maior ou menor?

---

📊 Resultados

Os principais resultados e insights serão adicionados após a conclusão das análises SQL.

A seção será atualizada com indicadores como:

- Faturamento total;
- Total de vendas;
- Ticket médio;
- Melhor e pior período;
- Produtos de maior destaque;
- Categorias com maior faturamento;
- Regiões com melhor desempenho;
- Principais padrões encontrados nos dados.

«Observação: todos os resultados apresentados serão baseados nos dados fictícios utilizados neste projeto.»

---

📊 Dashboard

O projeto terá um dashboard desenvolvido no Power BI, contendo indicadores e visualizações como:

- 💰 Faturamento total;
- 🛒 Total de vendas;
- 📦 Unidades vendidas;
- 📈 Evolução mensal;
- 🏆 Ranking de produtos;
- 📊 Faturamento por categoria;
- 🌎 Faturamento por região;
- 💳 Formas de pagamento.

Status: 🚧 Em desenvolvimento.

---

🚀 Próximos Passos

- [x] Criar dados fictícios;
- [x] Criar banco de dados;
- [x] Inserir clientes e vendas;
- [x] Criar primeiras consultas SQL;
- [x] Analisar faturamento geral;
- [x] Analisar faturamento mensal;
- [ ] Finalizar importação dos produtos;
- [ ] Analisar produtos;
- [ ] Analisar categorias;
- [ ] Analisar clientes;
- [ ] Analisar regiões;
- [ ] Analisar formas de pagamento;
- [ ] Criar KPIs finais;
- [ ] Desenvolver dashboard no Power BI;
- [ ] Documentar os principais insights;
- [ ] Finalizar projeto para portfólio.

---

📚 O que estou praticando

Este projeto faz parte dos meus estudos na área de Dados & Analytics.

Durante o desenvolvimento, estou praticando:

- SQL;
- MySQL;
- relacionamentos entre tabelas;
- "SELECT";
- "WHERE";
- "GROUP BY";
- "ORDER BY";
- funções de agregação;
- "JOIN";
- criação de indicadores;
- análise exploratória de dados;
- visualização de dados;
- interpretação de resultados de negócio.

A ideia é evoluir o projeto de forma prática, documentando o processo e os aprendizados ao longo do desenvolvimento.

---

👨‍💻 Autor

Samuel Martins Cardoso

Estudante de Dados & Analytics, com foco em SQL, Banco de Dados, Excel e Power BI.

Este projeto foi desenvolvido como parte do meu aprendizado prático na área de dados, buscando transformar conhecimentos teóricos em um projeto que simule um problema de negócio real.

---

⚠️ Aviso

Este é um projeto educacional.

A Magazine Luiza (Magalu) é utilizada apenas como referência para a simulação.

Nenhum dado apresentado neste projeto representa informações reais, internas ou oficiais da empresa.

Todos os clientes, produtos, vendas, valores e resultados foram gerados artificialmente para fins de estudo e portfólio.