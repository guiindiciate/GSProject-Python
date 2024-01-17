from crud import *


def menu():
    print("Bem vindo a GlowAI!")

    while True:
        print("1 - Criar Conta \n"
              "2 - Alterar Dados da Conta \n"
              "3 - Saber mais sobre as doenças \n"
              "4 - Sair")

        opcao = obriga_opcao(["1", "2", "3", "4"], "O que deseja realizar? ")

        if opcao == "1":
            print(100 * "-")
            criar_conta()
            print(100 * "-")
        elif opcao == "2":
            print(100 * "-")
            atualizar_info_cadastro()
            print(100 * "-")
        elif opcao == "3":
            print(100 * "-")
            mostrar_doencas()
            print(100 * "-")
        else:
            print(100 * "-")
            print("Obrigado por utilizar nosso sistema. Volte Sempre!")
            print(100 * "-")
            break

    return


menu()
