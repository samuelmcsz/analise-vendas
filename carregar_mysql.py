"""Gera CSVs fictícios quando necessário e carrega a base no MySQL.
Instale: python -m pip install mysql-connector-python
Execute: python carregar_mysql.py

ATENÇÃO: a carga substitui o banco vendas_magalu somente após confirmação explícita.
"""
import csv
import os
import random
import sys
from datetime import date, timedelta
from decimal import Decimal, ROUND_HALF_UP

try:
    import mysql.connector
except ImportError:
    print("Instale a dependência: python -m pip install mysql-connector-python")
    sys.exit(1)

ROOT = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(ROOT, "dados")
DB = "vendas_magalu"
CLIENTES_COLS = ["id_cliente", "nome", "cidade", "estado", "regiao"]
PRODUTOS_COLS = ["id_produto", "nome_produto", "categoria", "preco"]
VENDAS_COLS = ["id_venda", "data_venda", "id_cliente", "id_produto",
               "quantidade", "preco_unitario", "desconto", "faturamento",
               "forma_pagamento"]
CIDADES = [
    ("São Paulo", "SP", "Sudeste"), ("Campinas", "SP", "Sudeste"),
    ("Rio de Janeiro", "RJ", "Sudeste"), ("Belo Horizonte", "MG", "Sudeste"),
    ("Vitória", "ES", "Sudeste"), ("Curitiba", "PR", "Sul"),
    ("Porto Alegre", "RS", "Sul"), ("Florianópolis", "SC", "Sul"),
    ("Salvador", "BA", "Nordeste"), ("Recife", "PE", "Nordeste"),
    ("Fortaleza", "CE", "Nordeste"), ("Natal", "RN", "Nordeste"),
    ("Brasília", "DF", "Centro-Oeste"), ("Goiânia", "GO", "Centro-Oeste"),
    ("Cuiabá", "MT", "Centro-Oeste"), ("Manaus", "AM", "Norte"),
    ("Belém", "PA", "Norte"), ("Porto Velho", "RO", "Norte")]
NOMES = ["Ana", "Bruno", "Carla", "Daniel", "Fernanda", "Gabriel", "Juliana",
         "Lucas", "Mariana", "Rafael", "Tatiane", "Felipe", "Beatriz", "Henrique"]
SOBRENOMES = ["Silva", "Santos", "Oliveira", "Souza", "Pereira", "Costa",
              "Rodrigues", "Almeida", "Nascimento", "Lima", "Carvalho", "Ribeiro"]
CATALOGO = {
    "Celulares": [("Smartphone Básico 64GB", 899), ("Smartphone Intermediário 128GB", 1799),
        ("Smartphone Premium 256GB", 4299), ("Fone Bluetooth", 199.9),
        ("Carregador Turbo", 89.9), ("Capa Protetora", 39.9)],
    "Eletrônicos": [("Smart TV 43 polegadas", 2199), ("Smart TV 55 polegadas", 3199),
        ("Soundbar", 899), ("Caixa de Som Portátil", 349), ("Smartwatch", 599),
        ("Câmera de Segurança", 229)],
    "Eletrodomésticos": [("Geladeira Frost Free", 3299), ("Fogão 4 Bocas", 1099),
        ("Micro-ondas 20L", 499), ("Máquina de Lavar", 2199), ("Air Fryer", 399)],
    "Informática": [("Notebook Gamer", 5999), ("Notebook Básico", 2499),
        ("Monitor 24 polegadas", 899), ("Teclado sem fio", 159),
        ("Mouse Gamer", 129), ("Impressora Multifuncional", 799)],
    "Casa e Decoração": [("Jogo de Panelas", 349), ("Jogo de Cama", 199),
        ("Luminária de Mesa", 119), ("Cadeira de Escritório", 699),
        ("Ventilador", 249)],
    "Móveis": [("Sofá 3 Lugares", 1899), ("Mesa de Jantar", 1299),
        ("Guarda-Roupa", 1599), ("Estante", 499), ("Escrivaninha", 449)],
    "Esporte e Lazer": [("Bicicleta", 1199), ("Esteira Ergométrica", 2299),
        ("Mochila Esportiva", 179), ("Halteres", 149), ("Barraca de Camping", 299)]}
PAGAMENTOS = ["Cartão de Crédito", "Cartão de Débito", "Pix", "Boleto"]

CREATE_TABLES = [
    """CREATE TABLE clientes (id_cliente INT PRIMARY KEY, nome VARCHAR(100) NOT NULL,
       cidade VARCHAR(60) NOT NULL, estado CHAR(2) NOT NULL, regiao VARCHAR(20) NOT NULL)""",
    """CREATE TABLE produtos (id_produto INT PRIMARY KEY, nome_produto VARCHAR(100) NOT NULL,
       categoria VARCHAR(50) NOT NULL, preco DECIMAL(10,2) NOT NULL)""",
    """CREATE TABLE vendas (id_venda INT PRIMARY KEY, data_venda DATE NOT NULL,
       id_cliente INT NOT NULL, id_produto INT NOT NULL, quantidade INT NOT NULL,
       preco_unitario DECIMAL(10,2) NOT NULL, desconto DECIMAL(4,2) NOT NULL,
       faturamento DECIMAL(12,2) NOT NULL, forma_pagamento VARCHAR(30) NOT NULL,
       FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
       FOREIGN KEY (id_produto) REFERENCES produtos(id_produto))"""]


def save_csv(filename, columns, rows):
    os.makedirs(DATA_DIR, exist_ok=True)
    with open(os.path.join(DATA_DIR, filename), "w", encoding="utf-8-sig", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(columns)
        writer.writerows(rows)
    print(f"Criado dados/{filename}: {len(rows)} registros")


def generate_csvs_if_missing():
    filenames = ["clientes.csv", "produtos.csv", "vendas.csv"]
    if all(os.path.isfile(os.path.join(DATA_DIR, name)) for name in filenames):
        print("CSV existentes encontrados; serão preservados.")
        return

    print("CSV ausente: gerando uma nova base fictícia para 2025.")
    random.seed(2025)
    clientes = [[i, f"{random.choice(NOMES)} {random.choice(SOBRENOMES)}",
                 *random.choice(CIDADES)] for i in range(1, 1001)]
    save_csv("clientes.csv", CLIENTES_COLS, clientes)

    catalogo = [(cat, nome, preco) for cat, itens in CATALOGO.items()
                for nome, preco in itens]
    produtos = []
    for i in range(1, 51):
        cat, nome, preco = catalogo[(i - 1) % len(catalogo)]
        if i > len(catalogo):
            nome = f"{nome} - Modelo {i}"
        produtos.append([i, nome, cat, preco])
    save_csv("produtos.csv", PRODUTOS_COLS, produtos)

    precos = {int(p[0]): Decimal(str(p[3])) for p in produtos}
    start = date(2025, 1, 1)
    vendas = []
    for i in range(1, 10001):
        pid = random.randint(1, 50)
        qtd = random.choices([1, 2, 3, 4], weights=[55, 27, 13, 5])[0]
        desconto = random.choice([Decimal("0"), Decimal("0"), Decimal("0.05"),
                                  Decimal("0.10"), Decimal("0.15")])
        faturamento = (precos[pid] * qtd * (1 - desconto)).quantize(
            Decimal("0.01"), rounding=ROUND_HALF_UP)
        data = start + timedelta(days=random.randint(0, 364))
        vendas.append([i, data.isoformat(), random.randint(1, 1000), pid, qtd,
                       str(precos[pid]), str(desconto), str(faturamento),
                       random.choice(PAGAMENTOS)])
    vendas.sort(key=lambda row: (row[1], row[0]))
    save_csv("vendas.csv", VENDAS_COLS, vendas)


def read_csv(name, expected_columns):
    path = os.path.join(DATA_DIR, name + ".csv")
    with open(path, encoding="utf-8-sig", newline="") as f:
        reader = csv.reader(f)
        header = next(reader, None)
        if header != expected_columns:
            raise ValueError(f"Cabeçalho inválido em dados/{name}.csv: {header}")
        return list(reader)


def main():
    print("=== Análise de Vendas — geração e carga MySQL ===")
    generate_csvs_if_missing()
    data = {
        "clientes": read_csv("clientes", CLIENTES_COLS),
        "produtos": read_csv("produtos", PRODUTOS_COLS),
        "vendas": read_csv("vendas", VENDAS_COLS)}
    print("\nATENÇÃO: isso apaga e recria o banco 'vendas_magalu'.")
    print("Os arquivos CSV existentes serão preservados.")
    if input("Digite RECRIAR para continuar: ").strip() != "RECRIAR":
        print("Cancelado; o banco não foi alterado.")
        return

    user = input("Usuário MySQL (Enter = root): ").strip() or "root"
    password = input("Senha MySQL: ")
    try:
        conn = mysql.connector.connect(host="localhost", port=3306,
                                       user=user, password=password,
                                       charset="utf8mb4")
    except mysql.connector.Error as error:
        print(f"Falha ao conectar ao MySQL: {error}")
        sys.exit(1)

    cursor = conn.cursor()
    try:
        cursor.execute(f"DROP DATABASE IF EXISTS {DB}")
        cursor.execute(f"CREATE DATABASE {DB} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
        cursor.execute(f"USE {DB}")
        for statement in CREATE_TABLES:
            cursor.execute(statement)
        column_counts = {"clientes": 5, "produtos": 4, "vendas": 9}
        for table, count in column_counts.items():
            rows = data[table]
            marks = ", ".join(["%s"] * count)
            print(f"Importando {len(rows)} linhas para {table}...")
            cursor.executemany(f"INSERT INTO {table} VALUES ({marks})", rows)
            conn.commit()
        print("\nResumo da carga:")
        for table in column_counts:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            print(f"  {table}: {cursor.fetchone()[0]} registros")
        cursor.execute("SELECT ROUND(SUM(faturamento), 2) FROM vendas")
        print(f"  Faturamento total: R$ {cursor.fetchone()[0]}")
        print(f"\nBanco '{DB}' carregado com sucesso.")
    except mysql.connector.Error as error:
        conn.rollback()
        print(f"Erro no MySQL durante a carga: {error}")
        sys.exit(1)
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    main()
