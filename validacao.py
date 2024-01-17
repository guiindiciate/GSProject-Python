import re
import requests


# Função de obrigar opção
def obriga_opcao(opcoes, msg):
    resposta = input(msg)
    while resposta not in opcoes:
        print("Opção inválida, tente novamente!")
        resposta = input(msg)

    return resposta


# Função que pergunta e valida o nome
def validar_nome():
    nome = input("Digite seu nome: ")
    while len(nome) > 100:
        nome = input("Digite seu nome novamente (limite de 100 caracteres): ")

    return nome


# Função que pergunta e valida o email
def validar_email(msg):
    email = input(msg)
    e_email = bool(re.match(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$', email))
    while not e_email:
        email = input("Digite um email válido: ")
        e_email = bool(re.match(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$', email))
    return email


# Função que pergunta e valida o cpf
def validar_cpf():
    cpf = input("Digite seu cpf (XXX.XXX.XXX-XX): ")
    e_cpf = bool(re.match(r'^\d{3}\.\d{3}.\d{3}-\d{2}$', cpf))
    while not e_cpf:
        cpf = input("Digite um cpf válido (XXX.XXX.XXX-XX): ")
        e_cpf = bool(re.match(r'^\d{3}\.\d{3}.\d{3}-\d{2}$', cpf))

    return cpf


def validar_data():
    data = input("Digite a data de seu nascimento (DD-MM-AAAA): ")
    e_data = bool(re.match(r'^\d{2}-\d{2}-\d{4}$', data))
    while not e_data:
        data = input("Digite uma data válida: ")
        e_data = bool(re.match(r'^\d{2}-\d{2}-\d{4}$', data))

    return data


def validar_numero():
    celular = input("Digite seu número de celular: ")
    e_celular = bool(re.match(r'^([1-9]{2})([0-9]{8})$', celular))
    codigo_area = celular[:2]
    ddd = ('11', '12', '13', '14', '15', '16', '17', '18', '19',
        '21', '22', '24', '27', '28', '31', '32', '33', '34',
        '35', '37', '38', '41', '42', '43', '44', '45', '47',
        '48', '51', '53', '54', '55', '61', '62', '63', '64',
        '65', '67', '68', '71', '73', '74', '75', '77', '79',
        '81', '82', '83', '84', '85', '87', '88', '91', '92',
        '93', '94', '95', '96', '97', '98')

    while not e_celular and codigo_area not in ddd:
        celular = input("Digite um número válido (Somente números): ")
        e_celular = bool(re.match(r'^([1-9]{2})([0-9]{8})$', celular))
        codigo_area = celular[:2]

    return celular


def validar_cep():
    cep = input("Digite seu cep: ")
    r = requests.get(f"https://viacep.com.br/ws/{cep}/json/?")
    conteudo = r.json()
    while r.status_code != 200:
        cep = input("Digite o cep corretamente: ")
        r = requests.get(f"https://viacep.com.br/ws/{cep}/json/?")
    while 'erro' in conteudo.keys():
        cep = input("Digite um cep existente: ")
        r = requests.get(f"https://viacep.com.br/ws/{cep}/json/?")
        conteudo = r.json()

    return cep
