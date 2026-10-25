"""
Cria o banco 'vendas_magalu' no MySQL, cria as 3 tabelas e carrega os CSVs.
ATENÇÃO: se o banco vendas_magalu já existir, ele é apagado e recriado do zero.

Antes de rodar:
  1) python gerar_dados.py                       (cria a pasta dados/ com os CSVs)
  2) python -m pip install mysql-connector-python

Como rodar:  python carregar_mysql.py
"""

import csv
import os
import sys

try:
    import mysql.connector
except ImportError:
    print("Falta instalar o conector do MySQL. Rode este comando e tente de novo:")
    print("python -m pip install mysql-connector-python")
    sys.exit(1)

PASTA_BASE = os.path.dirname(os.path.abspath(__file__))
PASTA_DADOS = os.path.join(PASTA_BASE, "dados")
BANCO = "vendas_magalu"

# ---------------------------------------------------------------- tabelas
CRIAR_TABELAS = [
    """
    CREATE TABLE clientes (
        id_cliente  INT          PRIMARY KEY,
        nome        VARCHAR(100) NOT NULL,
        cidade      VARCHAR(60)  NOT NULL,
        estado      CHAR(2)      NOT NULL,
        regiao      VARCHAR(20)  NOT NULL
    )
    """,
    """
    CREATE TABLE produtos (
        id_produto    INT           PRIMARY KEY,
        nome_produto  VARCHAR(100)  NOT NULL,
        categoria     VARCHAR(50)   NOT NULL,
        preco         DECIMAL(10,2) NOT NULL
    )
    """,
    """
    CREATE TABLE vendas (
        id_venda         INT           PRIMARY KEY,
        data_venda       DATE          NOT NULL,
        id_cliente       INT           NOT NULL,
        id_produto       INT           NOT NULL,
        quantidade       INT           NOT NULL,
        preco_unitario   DECIMAL(10,2) NOT NULL,
        desconto         DECIMAL(4,2)  NOT NULL,
        faturamento      DECIMAL(12,2) NOT NULL,
        forma_pagamento  VARCHAR(30)   NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
    )
    """,
]

# (nome do csv/tabela, quantidade de colunas) — na ordem certa de carga
TABELAS = [("clientes", 5), ("produtos", 4), ("vendas", 9)]


def ler_csv(nome):
    caminho = os.path.join(PASTA_DADOS, f"{nome}.csv")
    if not os.path.exists(caminho):
        print(f"Não achei o arquivo {caminho}")
        print("Rode primeiro:  python gerar_dados.py")
        sys.exit(1)
    with open(caminho, encoding="utf-8-sig", newline="") as f:
        leitor = csv.reader(f)
        next(leitor)  # pula o cabeçalho
        return [linha for linha in leitor]


def main():
    print("=== Carregar dados no MySQL ===")
    usuario = input("Usuário do MySQL (Enter = root): ").strip() or "root"
    senha = input("Senha do MySQL: ")

    dados = {nome: ler_csv(nome) for nome, _ in TABELAS}

    try:
        conexao = mysql.connector.connect(
            host="localhost", port=3306, user=usuario, password=senha, charset="utf8mb4"
        )
    except mysql.connector.Error as erro:
        print("\nNão consegui conectar no MySQL:")
        print(erro)
        print("\nDicas: confira usuário e senha, e se o MySQL está ligado")
        print("(Windows: procure por 'Serviços' e veja se MySQL80 está 'Em execução').")
        sys.exit(1)

    cursor = conexao.cursor()

    try:
        print("\nCriando o banco e as tabelas...")
        cursor.execute(f"DROP DATABASE IF EXISTS {BANCO}")  # começa limpo
        cursor.execute(
            f"CREATE DATABASE {BANCO} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
        )
        cursor.execute(f"USE {BANCO}")
        for comando in CRIAR_TABELAS:
            cursor.execute(comando)

        for nome, n_colunas in TABELAS:
            linhas = dados[nome]
            marcadores = ", ".join(["%s"] * n_colunas)
            print(f"Inserindo {len(linhas)} linhas em {nome}...")
            cursor.executemany(f"INSERT INTO {nome} VALUES ({marcadores})", linhas)
            conexao.commit()

        print("\nConferindo:")
        for nome, _ in TABELAS:
            cursor.execute(f"SELECT COUNT(*) FROM {nome}")
            print(f"  {nome}: {cursor.fetchone()[0]} linhas")
        cursor.execute("SELECT ROUND(SUM(faturamento), 2) FROM vendas")
        print(f"  faturamento total: {cursor.fetchone()[0]}")
        print("\nPronto! O banco vendas_magalu está carregado.")
    except mysql.connector.Error as erro:
        print("\nDeu erro no MySQL:")
        print(erro)
        sys.exit(1)
    finally:
        cursor.close()
        conexao.close()


main()
