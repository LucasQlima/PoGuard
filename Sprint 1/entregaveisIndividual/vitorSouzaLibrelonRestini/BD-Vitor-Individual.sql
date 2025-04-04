CREATE DATABASE sprint1_bd;

USE spring1;

CREATE TABLE TBL_USER_ADM (
	idU_user_adm INT PRIMARY KEY AUTO_INCREMENT,
	cnpj CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(70) NOT NULL UNIQUE ,
    numero VARCHAR(40) UNIQUE,
    senha VARCHAR(40) NOT NULL,
    verif_senha VARCHAR(12) NOT NULL,
    CONSTRAINT CHK_senha
    CHECK (senha = verif_senha),
    CONSTRAINT CHK_email
    CHECK (email LIKE '%@%')
);
CREATE TABLE TBL_USER(
	id_user INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE, -- o cpf vai ter letra a partir de 2026, então para previnir de fazer futuras atualizações já implementei o novo formato
    email VARCHAR(70) NOT NULL UNIQUE,
    senha VARCHAR(40) NOT NULL,
    verif_senha VARCHAR(40) NOT NULL,
    foto_url VARCHAR(250) UNIQUE,
    CONSTRAINT CHK_senha_user
    CHECK (senha = verif_senha),
    CONSTRAINT CHK_email_user
    CHECK (email LIKE '%@%')
);
CREATE TABLE TBL_CARRO (
	id_carro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40), -- não coloquei not null por ser opcional adicionar nome do carro
    cnpj VARCHAR(14) UNIQUE, -- alguns motoristas podem ser agregados, por isso não coloquei NOT NULL
    placa CHAR(7) NOT NULL UNIQUE,
	tipo_carro VARCHAR(40) NOT NULL,
	id_sensores TINYINT NOT NULL, -- pensando futuramente em FK
    foto_url VARCHAR(250) UNIQUE
);

CREATE TABLE TBL_SENSOR (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	numero_serie VARCHAR (250) NOT NULL UNIQUE,
	temperatura DECIMAL(4,2) NOT NULL
);
CREATE TABLE TBL_ALIMENTO (
	id_alimento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(200),
    temperatura DECIMAL(4,2) NOT NULL,
    foto_url VARCHAR(250) UNIQUE
);
CREATE TABLE TBL_ROTA (
	id_rota INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(200),
    id_carro INT,
    id_alimento INT,
    id_sensor INT
);
INSERT INTO TBL_USER_ADM (cnpj, email, numero, senha, verif_senha) VALUES
('12345678901234', 'admin1@example.com', '1199999999', 'senha123', 'senha123'),
('98765432109876', 'admin2@example.org', '2188888888', 'outraSenha', 'outraSenha'),
('11223344556677', 'admin3@test.net', '3177777777', 'senhaSegura', 'senhaSegura'),
('55667788990011', 'admin4@domain.co', '4166666666', '12345678', '12345678'),
('99887766554433', 'admin5@mymail.io', '5155555555', 'senha123', 'senha123');,

INSERT INTO TBL_USER (nome, cpf, email, senha, verif_senha, foto_url) VALUES
('Ana Silva', '123.111.111-11', 'ana.silva@email.com', 'senha123', 'senha123', '...'),
('Bruno Oliveira', '999.888.777-66', 'bruno.oliveira@email.com', 'outraSenha', 'outraSenha', '...'),
('Carla Souza', '555.555.555-55', 'carla.souza@email.com', 'senhaSegura', 'senhaSegura', NULL),
('Daniel Pereira', '555.666.777-00', 'daniel.pereira@email.com', '12345678', '12345678', '...'),
('Eliana Rocha', '999.888.777-11', 'eliana.rocha@email.com', 'password', 'password', '...');

INSERT INTO TBL_CARRO (nome, cnpj, placa, tipo_carro, id_sensores, foto_url) VALUES
('Michel', '12345678901234', 'ABC1234', 'Caminhão Baú', 1, '...'),
('Vladimir', NULL, 'DEF5678', 'Van', 2, '...'),
('Wesley', '98765432109876', 'GHI9012', 'Caminhão Baú', 3, '...'),
('Roberto', '11223344556677', 'JKL3456', 'Van', 4, NULL),
('Cláudio', NULL, 'MNO7890', 'Caminhão Baú', 5, '...');
INSERT INTO TBL_SENSOR (numero_serie, temperatura) VALUES
('SN-12345-ABC', 25.50),
('SN-67890-DEF', 30.25),
('SN-11223-GHI', 22.75),
('SN-44556-JKL', 28.00);
INSERT INTO TBL_ALIMENTO (nome, descricao, temperatura, foto_url) VALUES
('Leite Integral', 'Leite de vaca integral.', 4.00, '...'),
('Queijo Mussarela', 'Queijo.', 6.00, '...'),
('Iogurte Natural', 'Iogurte.', 5.00, '...'),
('Frango Resfriado', 'Frango.', 2.00, NULL),
('Salmão Fresco', 'Filé de salmão fresco.', 3.00, '...'),
('Manteiga Sem Sal', 'Manteiga.', 7.00, '...');
INSERT INTO TBL_ROTA (regiao, descricao, id_carro, id_alimento, id_sensor) VALUES
('Zona Sul', 'Entrega de laticínios.', 1, 1, 1),
('Zona Oeste', 'Distribuição de carnes.', 2, 4, 2),
('Zona Leste', 'Transporte de congelados.', 3, 11, 3),
('Zona Norte', 'Entrega de frutas e legumes.', 4, 7, 4);

SELECT * FROM tbl_alimento WHERE temperatura <= -1;
SELECT nome AS Região, descricao AS Descricao_rota, id_carro AS Id_Veículo, id_alimento AS Id_Alimento from tbl_rota;
SELECT * FROM tbl_alimento WHERE nome LIKE '%A%' ORDER BY temperatura;
SELECT * FROM tbl_rota WHERE nome LIKE '%Norte%';
SELECT regiao AS Região, descricao AS Tipo_de_produto FROM tbl_rota;