-- 1TDSPG

/* 
INTEGRANTES:
ANDRÉ SANT'ANA BOIM - RM 551575
GABRIEL ERINGER DE OLIVEIRA - RM 99632
GUILHERME TAVARES INDICIATE - RM 93364
MARCELO HESPANHOL DIAS - RM 98251
MATHEUS AUGUSTO LEITE - RM 99697
*/

-- Usando o DROP Table para excluir as tabelas já existentes no ambiente.

DROP TABLE T_CLIENTE;
DROP TABLE T_CAUSAS;
DROP TABLE T_DOENCAS;
DROP TABLE T_IMAGENS;
DROP TABLE T_PREDICOES;
DROP TABLE T_SINTOMAS;
DROP TABLE T_TRATAMENTOS;

-- CRIANDO AS TABELAS

-- Criando a tabela t_causas para armazenar informações sobre causas de doenças
CREATE TABLE t_causas (
    id_causa            INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_causa            VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_causa)
);

-- Criando a tabela t_cliente para armazenar informações sobre clientes
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

-- Criando a tabela t_doencas para armazenar informações sobre doenças
CREATE TABLE t_doencas (
    id_doenca INTEGER GENERATED ALWAYS AS IDENTITY,
    nm_doenca VARCHAR2(100) NOT NULL,
    ds_doenca VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_doenca)
);

-- Criando a tabela t_imagens para armazenar informações sobre imagens relacionadas a doenças
CREATE TABLE t_imagens (
    id_imagem           INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    imagem              BLOB NOT NULL,
    PRIMARY KEY (id_imagem)
);


-- Criando a tabela t_predicoes para armazenar informações sobre predições relacionadas a doenças e clientes
CREATE TABLE t_predicoes (
    t_doencas_id_doenca  INTEGER NOT NULL,
    t_cliente_id_cliente INTEGER NOT NULL,
    id_predicao          INTEGER GENERATED ALWAYS AS IDENTITY,
    dt_classificacao     TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    ds_predicao          VARCHAR2(100) NOT NULL,
    PRIMARY KEY (id_predicao, t_doencas_id_doenca, t_cliente_id_cliente)
);

-- Criando a tabela t_sintomas para armazenar informações sobre sintomas relacionados a doenças
CREATE TABLE t_sintomas (
    id_sintoma          INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_sintoma          VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_sintoma)
);

-- Criando a tabela t_tratamentos para armazenar informações sobre tratamentos relacionados a doenças
CREATE TABLE t_tratamentos (
    id_tratamento       INTEGER GENERATED ALWAYS AS IDENTITY,
    t_doencas_id_doenca INTEGER NOT NULL,
    ds_tratamento       VARCHAR2(4000) NOT NULL,
    PRIMARY KEY (id_tratamento)
);

-- Adicionando restrições de chave estrangeira para as tabelas relacionadas
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
        
-- Inserindo 10 usuários na tabela t_cliente

    
INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('João Silva', 'joao@email.com', '111.111.111-11', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'M', '999999999', '12345-678', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Maria Oliveira', 'maria@email.com', '222.222.222-22', TO_DATE('15-05-1985', 'DD-MM-YYYY'), 'F', '888888888', '54321-876', 'S', 'Pólen', 'S', 'Aspirina');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Carlos Santos', 'carlos@email.com', '333.333.333-33', TO_DATE('20-10-1982', 'DD-MM-YYYY'), 'M', '777777777', '98765-432', 'N', NULL, 'Y', 'Antibiótico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Juliana Lima', 'juliana@email.com', '444.444.444-44', TO_DATE('08-03-1995', 'DD-MM-YYYY'), 'F', '666666666', '34567-890', 'S', 'Amendoim', 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Fernando Oliveira', 'fernando@email.com', '555.555.555-55', TO_DATE('05-12-1988', 'DD-MM-YYYY'), 'M', '555555555', '67890-123', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Ana Pereira', 'ana@email.com', '666.666.666-66', TO_DATE('25-06-1978', 'DD-MM-YYYY'), 'F', '444444444', '87654-321', 'S', 'Penicilina', 'S', 'Anti-inflamatório');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Pedro Rocha', 'pedro@email.com', '777.777.777-77', TO_DATE('10-09-1983', 'DD-MM-YYYY'), 'M', '333333333', '23456-789', 'N', NULL, 'Y', 'Analgésico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Mariana Lima', 'mariana@email.com', '888.888.888-88', TO_DATE('18-07-1990', 'DD-MM-YYYY'), 'F', '222222222', '78901-234', 'N', NULL, 'N', NULL);

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Gabriel Silva', 'gabriel@email.com', '999.999.999-99', TO_DATE('30-11-1992', 'DD-MM-YYYY'), 'M', '111111111', '45678-901', 'S', 'Ácaro', 'S', 'Antialérgico');

INSERT INTO t_cliente (nm_cliente, ml_cliente, nr_cpf, dt_nascimento, gn_cliente, nr_celular, nr_cep, st_alergia, ds_alergia, st_medicamentos, ds_medicamentos)
VALUES ('Isabela Oliveira', 'isabela@email.com', '123.456.789-09', TO_DATE('12-04-1987', 'DD-MM-YYYY'), 'F', '987654321', '90123-456', 'N', NULL, 'S', 'Antidepressivo');

commit;

-- Inserindo as 9 doenças do nosso modelo de treinamento na tabela t_doencas 
-- Não inserimos o mínimo de 10 linhas pois nosso dataset para o modelo de treinamento conta com apenas 9 doenças de pele
-- Nas outras tabelas, inserimos as 10 normalmente

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Candidiase Cutânea', 'A candidíase cutânea é uma infecção fúngica causada por leveduras do gênero Candida. Ela afeta a pele e pode causar sintomas como coceira, vermelhidão e descamação.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Carcinoma de células escamosas', 'O carcinoma de células escamosas é um tipo de câncer de pele que se origina nas células escamosas da epiderme. Pode se manifestar como uma lesão elevada e com crostas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Ceratose actínica', 'A ceratose actínica, também conhecida como queratose actínica, é uma lesão pré-cancerosa causada pela exposição ao sol. Apresenta-se como manchas escamosas na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Dermatite atópica', 'A dermatite atópica, também chamada de eczema, é uma condição inflamatória crônica da pele. Pode causar coceira intensa, vermelhidão e descamação.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Dermatofibroma', 'O dermatofibroma é um tumor cutâneo benigno. Geralmente se manifesta como um nódulo marrom escuro na pele e é constituído por células fibroblásticas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Lesão vascular', 'As lesões vasculares incluem uma variedade de condições que afetam os vasos sanguíneos, como hemangiomas e malformações vasculares. Podem se apresentar como manchas ou protuberâncias na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Melanoma', 'O melanoma é um tipo de câncer de pele que se origina nos melanócitos, as células produtoras de melanina. Pode se manifestar como uma pinta escura ou colorida na pele.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Nevo melanocítico', 'O nevo melanocítico, comumente chamado de "pinta" ou "sinal", é uma lesão benigna formada por células produtoras de melanina. A maioria é inofensiva, mas algumas podem se tornar cancerosas.');

INSERT INTO t_doencas (nm_doenca, ds_doenca)
VALUES ('Verruga seborreica', 'A verruga seborreica é uma lesão benigna da pele que geralmente ocorre com o envelhecimento. Apresenta-se como uma protuberância elevada, muitas vezes com superfície áspera e cor variável.');

commit;

-- Inserindo as causas das doenças na tabela t_causas

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Crescimento excessivo de leveduras do gênero Candida na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Sistema imunológico enfraquecido.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Umidade excessiva na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Uso prolongado de antibióticos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Clima quente e úmido.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Roupas íntimas apertadas e sintéticas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (1, 'Má higiene.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Exposição crônica à luz solar.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Uso de câmeras de bronzeamento.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Feridas na pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Inflamações na pele em pessoas com HIV ou doenças autoimunes.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (2, 'Infecções crônicas em pessoas com HIV ou doenças autoimune.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Exposição solar por longos períodos de tempo sem proteção.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Danos cumulativos causados pela exposição excessiva ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (3, 'Acúmulo de danos no DNA das células da pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Desencadeado por substâncias que provocam reações alérgias como as presentes nos pelos de animais de estimação.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Condições ambientais.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Roupas apertadas, úmidas ou que provocam coceira.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (4, 'Emocional, estresse e ansiedade.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (5, 'Acúmulo de células da derme que crescem por conta de uma reação imunológica causada por cortes, feridas e até picadas de inseto.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Trauma direto à pele, resultando em danos aos vasos sanguíneos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Doenças vasculares, como aterosclerose, que podem enfraquecer as paredes dos vasos sanguíneos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Distúrbios circulatórios que prejudicam o fluxo sanguíneo normal.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Exposição prolongada ao sol, o que pode causar danos à pele e aos vasos sanguíneos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (6, 'Complicações de procedimentos médicos, como cirurgias vasculares.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Exposição excessiva aos raios ultravioleta (UV) do sol, especialmente em pessoas com pele clara.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Histórico familiar de melanoma ou outros tipos de câncer de pele.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Presença de muitos sinais de pele, como pintas ou manchas atípicas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Imunossupressão, que enfraquece o sistema imunológico e aumenta o risco de câncer.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (7, 'Lesões prévias na pele, cicatrizes ou queimaduras que podem aumentar o risco de desenvolver melanoma.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Desenvolvimento de nevos melanocíticos devido à exposição ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Histórico familiar de nevos melanocíticos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Pele clara e propensão a queimaduras solares.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (8, 'Número elevado de nevos melanocíticos, especialmente se forem atípicos.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Predisposição genética a verrugas seborreicas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Envelhecimento da pele, sendo mais comum em pessoas mais velhas.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Exposição prolongada ao sol.');

INSERT INTO t_causas (t_doencas_id_doenca, ds_causa)
VALUES (9, 'Presença de outras verrugas seborreicas.');

commit;

-- Inserindo os sintomas na tabela t_sintomas

-- Candidíase Cutânea
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Vermelhidão e irritação na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Coceira intensa na região afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (1, 'Presença de lesões na pele.');

-- Carcinoma de Células Escamosas
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'Nódulos ou caroços na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'Feridas que não cicatrizam.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (2, 'Alterações na textura da pele.');

-- Ceratose Actínica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Manchas ásperas e escamosas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Sensação de queimação ou prurido.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (3, 'Alterações na cor da pele afetada.');

-- Dermatite Atópica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Coceira intensa.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Inflamação na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (4, 'Pele seca e escamosa.');

-- Dermatofibroma
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'Nódulo firme e elevado na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'Coceira na área afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (5, 'Mudanças na cor da lesão.');

-- Lesão Vascular
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Manchas vermelhas ou roxas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Dor ou sensibilidade na área afetada.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (6, 'Inchaço ou inchaço na pele.');

-- Melanoma
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Mudanças no tamanho, forma ou cor de um nevo existente.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Coceira ou sensibilidade na lesão.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (7, 'Sangramento ou oozing da lesão.');

-- Nevo Melanocítico
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Presença de manchas pigmentadas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Assimetria no formato da lesão.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (8, 'Bordas irregulares na lesão.');

-- Verruga Seborreica
INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Lesões elevadas na pele.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Coloração variável, de marrom a preto.');

INSERT INTO t_sintomas (t_doencas_id_doenca, ds_sintoma)
VALUES (9, 'Textura áspera na superfície da lesão.');

commit;

-- Inserindo os tratamentos na tabela t_tratamentos

-- Candidíase Cutânea
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (1, 'Antifúngicos tópicos, como clotrimazol ou miconazol.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (1, 'Manter a área afetada limpa e seca.');

-- Carcinoma de Células Escamosas
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (2, 'Cirurgia para remover as lesões cancerígenas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (2, 'Radioterapia para destruir as células cancerígenas.');

-- Ceratose Actínica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (3, 'Crioterapia, usando nitrogênio líquido para congelar as lesões.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (3, 'Medicamentos tópicos, como imiquimode ou fluoruracila.');

-- Dermatite Atópica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (4, 'Hidratantes para manter a pele úmida.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (4, 'Corticosteroides tópicos para reduzir a inflamação.');

-- Dermatofibroma
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (5, 'Geralmente não requer tratamento, mas pode ser removido cirurgicamente por razões estéticas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (5, 'Cirurgia para remoção completa do dermatofibroma.');

-- Lesão Vascular
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (6, 'Tratamento a laser para fechar os vasos sanguíneos anormais.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (6, 'Cirurgia para remover as lesões vasculares.');

-- Melanoma
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (7, 'Cirurgia para remover o melanoma.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (7, 'Quimioterapia ou imunoterapia para tratar melanomas avançados.');

-- Nevo Melanocítico
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (8, 'Geralmente não requer tratamento, a menos que haja mudanças suspeitas.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (8, 'Remoção cirúrgica se houver preocupações com câncer de pele.');

-- Verruga Seborreica
INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (9, 'Geralmente não requer tratamento, a menos que cause desconforto.');

INSERT INTO t_tratamentos (t_doencas_id_doenca, ds_tratamento)
VALUES (9, 'Remoção por razões estéticas ou se causar irritação.');

commit;

-- Inserindo imagens (vazias) para cada uma das 9 doenças na tabela t_imagens

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

-- Inserindo dados na tabela T_PREDICOES que é a tabela que receberá os dados das predicoes realizadas com nosso modelo treinado

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (1, 1, SYSTIMESTAMP, 'Predição 1');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (2, 2, SYSTIMESTAMP, 'Predição 2');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (3, 3, SYSTIMESTAMP, 'Predição 3');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (4, 4, SYSTIMESTAMP, 'Predição 4');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (5, 5, SYSTIMESTAMP, 'Predição 5');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (6, 6, SYSTIMESTAMP, 'Predição 6');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (7, 7, SYSTIMESTAMP, 'Predição 7');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (8, 8, SYSTIMESTAMP, 'Predição 8');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (9, 9, SYSTIMESTAMP, 'Predição 9');

INSERT INTO t_predicoes (t_doencas_id_doenca, t_cliente_id_cliente, dt_classificacao, ds_predicao)
VALUES (1, 10, SYSTIMESTAMP, 'Predição 10');

commit;

-- Script DQL/DRS (Selects) com pelo menos 4 consultas e texto explicativo.

-- Consulta Simples:
-- Objetivo: Recuperar informações básicas sobre clientes.
-- Descrição: Esta consulta busca recuperar o nome, e-mail e número de telefone de todos os clientes da tabela t_cliente.

SELECT nm_cliente, ml_cliente, nr_celular
FROM t_cliente
ORDER BY nm_cliente;

-- Consulta com Junção de Tabelas:
-- Objetivo: Obter informações sobre as causas associadas a cada doença.
-- Descrição: Esta consulta utiliza uma junção entre as tabelas T_DOENCAS e T_CAUSAS para obter informações sobre as causas de cada doença, ordenadas pelo nome da doença e descrição da causa.

SELECT D.nm_doenca, C.ds_causa
FROM t_doencas D
JOIN t_causas C ON D.id_doenca = C.t_doencas_id_doenca
ORDER BY D.nm_doenca, C.ds_causa;

-- Consulta com Função de Grupo e Agrupamento:
-- Objetivo: Contar o número de clientes por gênero.
-- Descrição: Esta consulta utiliza a função de grupo (COUNT) para contar o número de clientes por gênero na tabela T_CLIENTE.

SELECT gn_cliente, COUNT(*) AS total_clientes
FROM t_cliente
GROUP BY gn_cliente;

-- Consulta com Função de Grupo, Agrupamento com Filtro (HAVING) e Junção de Tabelas:
-- Objetivo: Obter informações sobre as doenças com mais de três causas.
-- Descrição: Esta consulta utiliza uma junção entre as tabelas T_DOENCAS e T_CAUSAS e aplica um filtro (HAVING) para mostrar apenas as doenças que têm mais de três causas, ordenadas pelo número total de causas em ordem decrescente.

SELECT D.nm_doenca, COUNT(C.id_causa) AS total_causas
FROM t_doencas D
LEFT JOIN t_causas C ON D.id_doenca = C.t_doencas_id_doenca
GROUP BY D.nm_doenca
HAVING COUNT(C.id_causa) > 3
ORDER BY total_causas DESC;

commit;
