-- 1TDSPG

/* 
INTEGRANTES:
ANDR� SANT'ANA BOIM - RM 551575
GABRIEL ERINGER DE OLIVEIRA - RM 99632
GUILHERME TAVARES INDICIATE - RM 93364
MARCELO HESPANHOL DIAS - RM 98251
MATHEUS AUGUSTO LEITE - RM 99697
*/

-- Usando o DROP Table para excluir as tabelas j� existentes no ambiente.

DROP TABLE T_CLIENTE;
DROP TABLE T_CAUSAS;
DROP TABLE T_DOENCAS;
DROP TABLE T_IMAGENS;
DROP TABLE T_PREDICOES;
DROP TABLE T_SINTOMAS;
DROP TABLE T_TRATAMENTOS;

-- CRIANDO AS TABELAS

-- Criando a tabela t_causas para armazenar informa��es sobre causas de doen�as
CREATE TABLE t_causas (
    id_causa            INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_causa            VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_causa)
);

-- Criando a tabela t_cliente para armazenar informa��es sobre clientes
CREATE TABLE t_cliente (
    id_cliente      INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_cliente      VARCHAR2(100) NOT NULL,
    ml_cliente      VARCHAR2(100) NOT NULL,
    nr_cpf          VARCHAR2(14) NOT NULL,
    dt_nascimento   DATE NOT NULL,
    gn_cliente      CHAR(1) NOT NULL,
    nr_celular      VARCHAR2(15) NOT NULL,
    nr_cep          VARCHAR2(10) NOT NULL,
    st_alergia      CHAR(1) NOT NULL,
    ds_alergia      VARCHAR2(100),
    st_medicamentos CHAR(1) NOT NULL,
    ds_medicamentos VARCHAR2(100),
    PRIMARY KEY (id_cliente)
);

-- Criando a tabela t_doencas para armazenar informa��es sobre doen�as
CREATE TABLE t_doencas (
    id_doenca INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_doenca VARCHAR2(100) NOT NULL,
    ds_doenca VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_doenca)
);

-- Criando a tabela t_imagens para armazenar informa��es sobre imagens relacionadas a doen�as
CREATE TABLE t_imagens (
    id_imagem           INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    imagem              BLOB NOT NULL,
    PRIMARY KEY (id_imagem)
);


-- Criando a tabela t_predicoes para armazenar informa��es sobre predi��es relacionadas a doen�as e clientes
CREATE TABLE t_predicoes (
    t_doencas_id_doenca  INTEGER NOT NULL,
    t_cliente_id_cliente INTEGER NOT NULL,
    id_predicao          INTEGER GENERATED ALWAYS AS IDENTITY,
    dt_classificacao     TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    ds_predicao          VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id_predicao, t_doencas_id_doenca, t_cliente_id_cliente)
);

-- Criando a tabela t_sintomas para armazenar informa��es sobre sintomas relacionados a doen�as
CREATE TABLE t_sintomas (
    id_sintoma          INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_sintoma          VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_sintoma)
);

-- Criando a tabela t_tratamentos para armazenar informa��es sobre tratamentos relacionados a doen�as
CREATE TABLE t_tratamentos (
    id_tratamento       INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_tratamento       VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_tratamento)
);

-- Adicionando restri��es de chave estrangeira para as tabelas relacionadas
ALTER TABLE t_causas
    ADD CONSTRAINT t_causas_t_doencas_fk FOREIGN KEY (t_doencas_id_doenca)
        REFERENCES t_doencas (id_doenca);

ALTER TABLE t_imagens
    ADD CONSTRAINT t_imagens_t_doencas_fk FOREIGN KEY (t_doencas_id_doenca)
        REFERENCES t_doencas (id_doenca);

ALTER TABLE t_predicoes
    ADD CONSTRAINT t_predicoes_t_cliente_fk FOREIGN KEY (t_cliente_id_cliente)
        REFERENCES t_cliente (id_cliente);

ALTER TABLE t_predicoes
    ADD CONSTRAINT t_predicoes_t_doencas_fk FOREIGN KEY (t_doencas_id_doenca)
        REFERENCES t_doencas (id_doenca);

ALTER TABLE t_sintomas
    ADD CONSTRAINT t_sintomas_t_doencas_fk FOREIGN KEY (t_doencas_id_doenca)
        REFERENCES t_doencas (id_doenca);

ALTER TABLE t_tratamentos
    ADD CONSTRAINT t_tratamentos_t_doencas_fk FOREIGN KEY (t_doencas_id_doenca)
        REFERENCES t_doencas (id_doenca);
        
-- Inserindo 10 usu�rios na tabela t_cliente

    
INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Jo�o Silva', 'joao@email.com', '111.111.111-11', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'M', '999999999', '12345-678', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Maria Oliveira', 'maria@email.com', '222.222.222-22', TO_DATE('15-05-1985', 'DD-MM-YYYY'), 'F', '888888888', '54321-876', 'S', 'P�len', 'S', 'Aspirina');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Carlos Santos', 'carlos@email.com', '333.333.333-33', TO_DATE('20-10-1982', 'DD-MM-YYYY'), 'M', '777777777', '98765-432', 'N', NULL, 'Y', 'Antibi�tico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Juliana Lima', 'juliana@email.com', '444.444.444-44', TO_DATE('08-03-1995', 'DD-MM-YYYY'), 'F', '666666666', '34567-890', 'S', 'Amendoim', 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Fernando Oliveira', 'fernando@email.com', '555.555.555-55', TO_DATE('05-12-1988', 'DD-MM-YYYY'), 'M', '555555555', '67890-123', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Ana Pereira', 'ana@email.com', '666.666.666-66', TO_DATE('25-06-1978', 'DD-MM-YYYY'), 'F', '444444444', '87654-321', 'S', 'Penicilina', 'S', 'Anti-inflamat�rio');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Pedro Rocha', 'pedro@email.com', '777.777.777-77', TO_DATE('10-09-1983', 'DD-MM-YYYY'), 'M', '333333333', '23456-789', 'N', NULL, 'Y', 'Analg�sico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Mariana Lima', 'mariana@email.com', '888.888.888-88', TO_DATE('18-07-1990', 'DD-MM-YYYY'), 'F', '222222222', '78901-234', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Gabriel Silva', 'gabriel@email.com', '999.999.999-99', TO_DATE('30-11-1992', 'DD-MM-YYYY'), 'M', '111111111', '45678-901', 'S', '�caro', 'S', 'Antial�rgico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Isabela Oliveira', 'isabela@email.com', '123.456.789-09', TO_DATE('12-04-1987', 'DD-MM-YYYY'), 'F', '987654321', '90123-456', 'N', NULL, 'S', 'Antidepressivo');

commit;

-- Inserindo as 9 doen�as do nosso modelo de treinamento na tabela t_doencas 
-- N�o inserimos o m�nimo de 10 linhas pois nosso dataset para o modelo de treinamento conta com apenas 9 doen�as de pele
-- Nas outras tabelas, inserimos as 10 normalmente

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Candidiase Cut�nea', 'A candid�ase cut�nea � uma infec��o f�ngica causada por leveduras do g�nero Candida. Ela afeta a pele e pode causar sintomas como coceira, vermelhid�o e descama��o.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Carcinoma de c�lulas escamosas', 'O carcinoma de c�lulas escamosas � um tipo de c�ncer de pele que se origina nas c�lulas escamosas da epiderme. Pode se manifestar como uma les�o elevada e com crostas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Ceratose act�nica', 'A ceratose act�nica, tamb�m conhecida como queratose act�nica, � uma les�o pr�-cancerosa causada pela exposi��o ao sol. Apresenta-se como manchas escamosas na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Dermatite at�pica', 'A dermatite at�pica, tamb�m chamada de eczema, � uma condi��o inflamat�ria cr�nica da pele. Pode causar coceira intensa, vermelhid�o e descama��o.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Dermatofibroma', 'O dermatofibroma � um tumor cut�neo benigno. Geralmente se manifesta como um n�dulo marrom escuro na pele e � constitu�do por c�lulas fibrobl�sticas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Les�o vascular', 'As les�es vasculares incluem uma variedade de condi��es que afetam os vasos sangu�neos, como hemangiomas e malforma��es vasculares. Podem se apresentar como manchas ou protuber�ncias na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Melanoma', 'O melanoma � um tipo de c�ncer de pele que se origina nos melan�citos, as c�lulas produtoras de melanina. Pode se manifestar como uma pinta escura ou colorida na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Nevo melanoc�tico', 'O nevo melanoc�tico, comumente chamado de "pinta" ou "sinal", � uma les�o benigna formada por c�lulas produtoras de melanina. A maioria � inofensiva, mas algumas podem se tornar cancerosas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Verruga seborreica', 'A verruga seborreica � uma les�o benigna da pele que geralmente ocorre com o envelhecimento. Apresenta-se como uma protuber�ncia elevada, muitas vezes com superf�cie �spera e cor vari�vel.');

commit;

-- Inserindo as causas das doen�as na tabela t_causas

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Crescimento excessivo de leveduras do g�nero Candida na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Sistema imunol�gico enfraquecido.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Umidade excessiva na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Uso prolongado de antibi�ticos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Clima quente e �mido.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Roupas �ntimas apertadas e sint�ticas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'M� higiene.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Exposi��o cr�nica � luz solar.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Uso de c�meras de bronzeamento.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Feridas na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Inflama��es na pele em pessoas com HIV ou doen�as autoimunes.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Infec��es cr�nicas em pessoas com HIV ou doen�as autoimune.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Exposi��o solar por longos per�odos de tempo sem prote��o.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Danos cumulativos causados pela exposi��o excessiva ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Ac�mulo de danos no DNA das c�lulas da pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Desencadeado por subst�ncias que provocam rea��es al�rgias como as presentes nos pelos de animais de estima��o.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Condi��es ambientais.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Roupas apertadas, �midas ou que provocam coceira.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Emocional, estresse e ansiedade.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (5, 'Ac�mulo de c�lulas da derme que crescem por conta de uma rea��o imunol�gica causada por cortes, feridas e at� picadas de inseto.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Trauma direto � pele, resultando em danos aos vasos sangu�neos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Doen�as vasculares, como aterosclerose, que podem enfraquecer as paredes dos vasos sangu�neos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Dist�rbios circulat�rios que prejudicam o fluxo sangu�neo normal.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Exposi��o prolongada ao sol, o que pode causar danos � pele e aos vasos sangu�neos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Complica��es de procedimentos m�dicos, como cirurgias vasculares.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Exposi��o excessiva aos raios ultravioleta (UV) do sol, especialmente em pessoas com pele clara.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Hist�rico familiar de melanoma ou outros tipos de c�ncer de pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Presen�a de muitos sinais de pele, como pintas ou manchas at�picas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Imunossupress�o, que enfraquece o sistema imunol�gico e aumenta o risco de c�ncer.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Les�es pr�vias na pele, cicatrizes ou queimaduras que podem aumentar o risco de desenvolver melanoma.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Desenvolvimento de nevos melanoc�ticos devido � exposi��o ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Hist�rico familiar de nevos melanoc�ticos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Pele clara e propens�o a queimaduras solares.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'N�mero elevado de nevos melanoc�ticos, especialmente se forem at�picos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Predisposi��o gen�tica a verrugas seborreicas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Envelhecimento da pele, sendo mais comum em pessoas mais velhas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Exposi��o prolongada ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Presen�a de outras verrugas seborreicas.');

commit;

-- Inserindo os sintomas na tabela t_sintomas

-- Candid�ase Cut�nea
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Vermelhid�o e irrita��o na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Coceira intensa na regi�o afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Presen�a de les�es na pele.');

-- Carcinoma de C�lulas Escamosas
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'N�dulos ou caro�os na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'Feridas que n�o cicatrizam.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'Altera��es na textura da pele.');

-- Ceratose Act�nica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Manchas �speras e escamosas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Sensa��o de queima��o ou prurido.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Altera��es na cor da pele afetada.');

-- Dermatite At�pica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Coceira intensa.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Inflama��o na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Pele seca e escamosa.');

-- Dermatofibroma
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'N�dulo firme e elevado na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'Coceira na �rea afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'Mudan�as na cor da les�o.');

-- Les�o Vascular
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Manchas vermelhas ou roxas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Dor ou sensibilidade na �rea afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Incha�o ou incha�o na pele.');

-- Melanoma
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Mudan�as no tamanho, forma ou cor de um nevo existente.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Coceira ou sensibilidade na les�o.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Sangramento ou oozing da les�o.');

-- Nevo Melanoc�tico
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Presen�a de manchas pigmentadas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Assimetria no formato da les�o.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Bordas irregulares na les�o.');

-- Verruga Seborreica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Les�es elevadas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Colora��o vari�vel, de marrom a preto.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Textura �spera na superf�cie da les�o.');

commit;

-- Inserindo os tratamentos na tabela t_tratamentos

-- Candid�ase Cut�nea
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (1, 'Antif�ngicos t�picos, como clotrimazol ou miconazol.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (1, 'Manter a �rea afetada limpa e seca.');

-- Carcinoma de C�lulas Escamosas
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (2, 'Cirurgia para remover as les�es cancer�genas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (2, 'Radioterapia para destruir as c�lulas cancer�genas.');

-- Ceratose Act�nica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (3, 'Crioterapia, usando nitrog�nio l�quido para congelar as les�es.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (3, 'Medicamentos t�picos, como imiquimode ou fluoruracila.');

-- Dermatite At�pica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (4, 'Hidratantes para manter a pele �mida.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (4, 'Corticosteroides t�picos para reduzir a inflama��o.');

-- Dermatofibroma
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (5, 'Geralmente n�o requer tratamento, mas pode ser removido cirurgicamente por raz�es est�ticas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (5, 'Cirurgia para remo��o completa do dermatofibroma.');

-- Les�o Vascular
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (6, 'Tratamento a laser para fechar os vasos sangu�neos anormais.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (6, 'Cirurgia para remover as les�es vasculares.');

-- Melanoma
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (7, 'Cirurgia para remover o melanoma.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (7, 'Quimioterapia ou imunoterapia para tratar melanomas avan�ados.');

-- Nevo Melanoc�tico
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (8, 'Geralmente n�o requer tratamento, a menos que haja mudan�as suspeitas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (8, 'Remo��o cir�rgica se houver preocupa��es com c�ncer de pele.');

-- Verruga Seborreica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (9, 'Geralmente n�o requer tratamento, a menos que cause desconforto.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (9, 'Remo��o por raz�es est�ticas ou se causar irrita��o.');

commit;

-- Inserindo imagens (vazias) para cada uma das 9 doen�as na tabela t_imagens

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (1, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (1, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (2, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (2, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (3, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (3, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (4, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (4, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (5, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (5, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (6, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (6, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (7, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (7, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (8, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (8, EMPTY_BLOB());

INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (9, EMPTY_BLOB());
INSERT INTO t_imagens (t_doencas_id_doenca, imagem) VALUES (9, EMPTY_BLOB());

commit;

-- Inserindo dados na tabela T_PREDICOES que � a tabela que receber� os dados das predicoes realizadas com nosso modelo treinado

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (1, 1, SYSTIMESTAMP, 'Predi��o 1');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (2, 2, SYSTIMESTAMP, 'Predi��o 2');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (3, 3, SYSTIMESTAMP, 'Predi��o 3');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (4, 4, SYSTIMESTAMP, 'Predi��o 4');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (5, 5, SYSTIMESTAMP, 'Predi��o 5');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (6, 6, SYSTIMESTAMP, 'Predi��o 6');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (7, 7, SYSTIMESTAMP, 'Predi��o 7');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (8, 8, SYSTIMESTAMP, 'Predi��o 8');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (9, 9, SYSTIMESTAMP, 'Predi��o 9');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (1, 10, SYSTIMESTAMP, 'Predi��o 10');

commit;

-- Script DQL/DRS (Selects) com pelo menos 4 consultas e texto explicativo.

-- Consulta Simples:
-- Objetivo: Recuperar informa��es b�sicas sobre clientes.
-- Descri��o: Esta consulta busca recuperar o nome, e-mail e n�mero de telefone de todos os clientes da tabela t_cliente.

SELECT nm_cliente, ml_cliente, nr_celular
FROM t_cliente
ORDER BY nm_cliente;

-- Consulta com Jun��o de Tabelas:
-- Objetivo: Obter informa��es sobre as causas associadas a cada doen�a.
-- Descri��o: Esta consulta utiliza uma jun��o entre as tabelas T_DOENCAS e T_CAUSAS para obter informa��es sobre as causas de cada doen�a, ordenadas pelo nome da doen�a e descri��o da causa.

SELECT D.nm_doenca, C.ds_causa
FROM t_doencas D
JOIN t_causas C ON D.id_doenca = C.t_doencas_id_doenca
ORDER BY D.nm_doenca, C.ds_causa;

-- Consulta com Fun��o de Grupo e Agrupamento:
-- Objetivo: Contar o n�mero de clientes por g�nero.
-- Descri��o: Esta consulta utiliza a fun��o de grupo (COUNT) para contar o n�mero de clientes por g�nero na tabela T_CLIENTE.

SELECT gn_cliente, COUNT(*) AS total_clientes
FROM t_cliente
GROUP BY gn_cliente;

-- Consulta com Fun��o de Grupo, Agrupamento com Filtro (HAVING) e Jun��o de Tabelas:
-- Objetivo: Obter informa��es sobre as doen�as com mais de tr�s causas.
-- Descri��o: Esta consulta utiliza uma jun��o entre as tabelas T_DOENCAS e T_CAUSAS e aplica um filtro (HAVING) para mostrar apenas as doen�as que t�m mais de tr�s causas, ordenadas pelo n�mero total de causas em ordem decrescente.

SELECT D.nm_doenca, COUNT(C.id_causa) AS total_causas
FROM t_doencas D
LEFT JOIN t_causas C ON D.id_doenca = C.t_doencas_id_doenca
GROUP BY D.nm_doenca
HAVING COUNT(C.id_causa) > 3
ORDER BY total_causas DESC;

commit;
