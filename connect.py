import oracledb
import json


def connect():
    path = r"C:\Users\marce_t1ncrmn\PycharmProjects\GS-CRUD\login.json"
    with open(path, "r") as arquivo:
        dados = json.load(arquivo)

    login = dados["user"]
    pswd = dados["password"]

    # Cria a String de conexão com informações do Host, Porta e SID
    oracledb.init_oracle_client(lib_dir=r"C:\Users\marce_t1ncrmn\Downloads\CRUD\instantclient-basic-windows.x64-21.11.0.0.0dbru\instantclient_21_11")

    dsn = oracledb.makedsn(host="oracle.fiap.com.br", port=1521, sid="orcl")

    conn = oracledb.connect(user=login, password=pswd, dsn=dsn)

    # Criando cursor
    cursor = conn.cursor()

    print("Conexão realizada com sucesso!")
    return cursor, conn
