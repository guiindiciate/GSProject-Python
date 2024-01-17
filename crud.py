from connect import connect
from validacao import *
import json


# Criando conexão com o banco de dados
try:
    cursor, conn = connect()
except Exception as e:
    print(f"Não foi possível realizar a conexão com o sistema :( \n"
          f"Erro: {e}")
    raise


# Criar conta
def criar_conta():
    nome_cliente = validar_nome()

    email_cliente = validar_email("Digite seu email: ")

    cpf_cliente = validar_cpf()

    data_nasc_cliente = validar_data()

    genero_cliente = obriga_opcao(['M', 'F'], "Digite seu gênero (M ou F): ")

    telefone_cliente = validar_numero()

    cep_cliente = validar_cep()

    possui_alergia = obriga_opcao(['S', 'N'], "Você possui alguma alergia? (S ou N): ")
    if possui_alergia == 'N':
        descricao_alergia = 'NULL'
    else:
        descricao_alergia = input("Qual alergia? ")
        descricao_alergia = f"'{descricao_alergia}'"

    toma_medicamentos = obriga_opcao(['S', 'N'], "Você toma algum medicamento? (S ou N): ")
    if toma_medicamentos == 'N':
        descricao_medicamentos = 'NULL'
    else:
        descricao_medicamentos = input("Qual medicamento? ")
        descricao_medicamentos = f"'{descricao_medicamentos}'"

    comando = f"INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos) VALUES ('{nome_cliente}', '{email_cliente}', '{cpf_cliente}', TO_DATE('{data_nasc_cliente}', 'DD-MM-YYYY'), '{genero_cliente}', '{telefone_cliente}', '{cep_cliente}', '{possui_alergia}', {descricao_alergia}, '{toma_medicamentos}', {descricao_medicamentos})"

    cursor.execute(comando)
    conn.commit()

    print("Conta criada com sucesso!")

    return


def mostrar_doencas():

    cursor.execute("SELECT NM_DOENCA FROM T_DOENCAS")
    nomes_doencas = cursor.fetchall()
    for i in range(len(nomes_doencas)):
        print(f"{i+1} - {nomes_doencas[i][0]}")

    doenca_selecionada = int(input("Qual doença deseja saber mais sobre? "))

    cursor.execute(f"SELECT DS_DOENCA FROM T_DOENCAS WHERE ID_DOENCA = {doenca_selecionada}")
    descricao_doenca = cursor.fetchall()
    print("-" * 100)
    print("DESCRIÇÃO DA DOENÇA")
    print(descricao_doenca[0][0])
    print("-" * 100)

    while True:
        print("1 - Sintomas \n"
              "2 - Tratamentos \n"
              "3 - Exportar informações da doença para um arquivo JSON \n"
              "4 - Voltar")

        opcao = int(obriga_opcao(["1", "2", "3", "4"], "Selecione alguma opção: "))

        cursor.execute(f"SELECT DS_SINTOMA FROM T_SINTOMAS WHERE T_DOENCAs_ID_DOENCA = {doenca_selecionada}")
        sintomas = cursor.fetchall()

        cursor.execute(f"SELECT DS_TRATAMENTO FROM T_TRATAMENTOS WHERE T_DOENCAs_ID_DOENCA = {doenca_selecionada}")
        tratamentos = cursor.fetchall()

        if opcao == 1:
            print("-" * 100)
            print("SINTOMAS")
            for i in range(len(sintomas)):
                print(f"{i+1} - {sintomas[i][0]}")
            print("-" * 100)
        elif opcao == 2:
            print("-" * 100)
            print("TRATAMENTOS")
            for i in range(len(tratamentos)):
                print(f"{i+1} - {tratamentos[i][0]}")
            print("-" * 100)
        elif opcao == 3:
            dicionario_doenca = {
                'Nome': nomes_doencas[doenca_selecionada-1][0],
                'Desc': descricao_doenca[0][0],
                'Sintomas': [],
                'Tratamentos': []
            }

            for i in range(len(sintomas)):
                dicionario_doenca['Sintomas'].append(sintomas[i][0])

            for i in range(len(tratamentos)):
                dicionario_doenca['Tratamentos'].append(tratamentos[i][0])

            with open("arquivos-json/doenca.json", "w") as arquivo:
                arquivo.write(json.dumps(dicionario_doenca, indent=4))

            print("JSON criado!")

        else:
            break

    return


def atualizar_info_cadastro():
    cursor.execute(f"select COLUMN_NAME from ALL_TAB_COLUMNS where TABLE_NAME='T_CLIENTE'")
    colunas = cursor.fetchall()

    while True:
        email_cadastrado = validar_email("Digite o seu email cadastrado no sistema: ")

        try:
            cursor.execute(f"SELECT * FROM T_CLIENTE WHERE ML_CLIENTE = '{email_cadastrado}'")
            dados_cliente = cursor.fetchall()
            break
        except:
            print("Não foi possível achar este email, tente novamente.")

    nomes_colunas = []

    for i in range(len(colunas)):
        print(f"{colunas[i][0]} - {dados_cliente[0][i]}")

        nomes_colunas.append(colunas[i][0])

    opcao = obriga_opcao(nomes_colunas, "Qual dado deseja alterar? ")
    novo_dado = input(f"Insira o/a novo {opcao}: ")

    cursor.execute(f"UPDATE t_cliente SET {opcao} = '{novo_dado}' WHERE ml_cliente = '{email_cadastrado}'")
    conn.commit()

    print("Dado alterado com sucesso!")

    return



