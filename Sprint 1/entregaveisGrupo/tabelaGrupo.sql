CREATE DATABASE poGuard;
USE poGuard;

-- CRIAÇÃO DA TABELA user_admin
CREATE TABLE TBL_USER_ADMIN(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
	telefone CHAR(12) UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    verif_senha VARCHAR(100) NOT NULL
);

-- CRIAÇÃO DE CONSTRAINTS
ALTER TABLE TBL_USER_ADMIN ADD CONSTRAINT chkEmailAdmin
		CHECK(email LIKE "%@%" AND email NOT LIKE "% %");
        
ALTER TABLE TBL_USER_ADMIN ADD CONSTRAINT chkSenhaAdmin
		CHECK(senha = verif_senha AND senha NOT LIKE "% %");
        
ALTER TABLE TBL_USER_ADMIN ADD CONSTRAINT chkCnpj
		CHECK(cnpj NOT LIKE "% %");

-- INSERÇÃO DE DADOS
INSERT INTO TBL_USER_ADMIN (nome, cnpj, telefone, email, senha, verif_senha) VALUES
    ('Carlos Almeida', '12345678000195', '11987654321', 'carlos.almeida@email.com', 'S3nhaF0rte!', 'S3nhaF0rte!'),
    ('Mariana Souza', '98765432000188', '11976543210', 'mariana.souza@email.com', 'M@ri2024!!', 'M@ri2024!!'),
    ('Rafael Lima', '56473829000123', '11965432109', 'rafael.lima@email.com', 'R4fa3l_L!ma', 'R4fa3l_L!ma'),
    ('Fernanda Castro', '10293847560019', '11954321098', 'fernanda.castro@email.com', 'F3rn@nd@C$', 'F3rn@nd@C$'),
    ('Bruno Oliveira', '67584930200176', '11943210987', 'bruno.oliveira@email.com', 'Bruno2024*', 'Bruno2024*'),
    ('Lucas Ferreira', '34567890000145', '11932109876', 'lucas.ferreira@email.com', 'Luc@sF3rr!', 'Luc@sF3rr!'),
    ('Amanda Nunes', '56789012000167', '11921098765', 'amanda.nunes@email.com', 'Am@nD@#12', 'Am@nD@#12'),
    ('Thiago Mendes', '78901234000189', '11910987654', 'thiago.mendes@email.com', 'Th1@g0M3nd$', 'Th1@g0M3nd$'),
    ('Juliana Rocha', '89012345000190', '11909876543', 'juliana.rocha@email.com', 'Ju!R0ch@22', 'Ju!R0ch@22'),
    ('Gustavo Santos', '90123456000101', '11908765432', 'gustavo.santos@email.com', 'Gust@v0!23', 'Gust@v0!23'),
    ('Camila Dias', '01234567000112', '11907654321', 'camila.dias@email.com', 'C@mila#D12', 'C@mila#D12'),
    ('Felipe Martins', '12345098000123', '11906543210', 'felipe.martins@email.com', 'F3lip3M@r!', 'F3lip3M@r!'),
    ('Vanessa Ribeiro', '23456109000134', '11905432109', 'vanessa.ribeiro@email.com', 'V@n3ss@#R!', 'V@n3ss@#R!'),
    ('Rodrigo Almeida', '34567210000145', '11904321098', 'rodrigo.almeida@email.com', 'Rodr!g0@123', 'Rodr!g0@123'),
    ('Patricia Lima', '45678321000156', '11903210987', 'patricia.lima@email.com', 'P@tr1c1@_L!', 'P@tr1c1@_L!');


-- CRIAÇÃO DA TABELA user
CREATE TABLE TBL_USER(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE,
    telefone CHAR(12) UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    verif_senha VARCHAR(100) NOT NULL,
    foto_url VARCHAR(249) UNIQUE
);

-- CRIAÇÃO DE CONSTRAINTS
ALTER TABLE TBL_USER ADD CONSTRAINT chkEmailUser
		CHECK(email LIKE "%@%" AND email NOT LIKE "% %");
        
ALTER TABLE TBL_USER ADD CONSTRAINT chkSenhaUser
		CHECK(senha = verif_senha AND senha NOT LIKE "% %");
        
ALTER TABLE TBL_USER ADD CONSTRAINT chkCpf
		CHECK(cpf NOT LIKE "% %");

-- INSERÇÃO DE DADOS
INSERT INTO TBL_USER (nome, cpf, telefone, email, senha, verif_senha, foto_url) VALUES
	('João Silva', '123.456.789-01', '11987654321', 'joao.silva@example.com', 'senha123', 'senha123', 'http://example.com/fotos/joao.jpg'),
	('Maria Oliveira', '234.567.890-12', '11912345678', 'maria.oliveira@example.com', 'senha456', 'senha456', 'http://example.com/fotos/maria.jpg'),
	('Pedro Souza', '345.678.901-23', '11998765432', 'pedro.souza@example.com', 'senha789', 'senha789', 'http://example.com/fotos/pedro.jpg'),
	('Ana Costa', '456.789.012-34', '11931310897', 'ana.costa@example.com', 'senha101', 'senha101', 'http://example.com/fotos/ana.jpg'),
	('Carlos Rocha', '567.890.123-45', '11924538055', 'carlos.rocha@example.com', 'senha112', 'senha112', 'http://example.com/fotos/carlos.jpg'),
	('Fernanda Lima', '678.901.234-56', '11933857015', 'fernanda.lima@example.com', 'senha131', 'senha131', 'http://example.com/fotos/fernanda.jpg'),
	('Ricardo Alves', '789.012.345-67', '11914354377', 'ricardo.alves@example.com', 'senha415', 'senha415', 'http://example.com/fotos/ricardo.jpg'),
	('Juliana Santos', '890.123.456-78', '11950093548', 'juliana.santos@example.com', 'senha161', 'senha161', 'http://example.com/fotos/juliana.jpg'),
	('Lucas Pereira', '901.234.567-89', '11969473829', 'lucas.pereira@example.com', 'senha718', 'senha718', 'http://example.com/fotos/lucas.jpg'),
	('Patrícia Gomes', '012.345.678-90', '11971743950', 'patricia.gomes@example.com', 'senha192', 'senha192', 'http://example.com/fotos/patricia.jpg'),
	('Roberto Nunes', '123.456.789-02', '11985286901', 'roberto.nunes@example.com', 'senha021', 'senha021', 'http://example.com/fotos/roberto.jpg');


-- CRIAÇÃO DA TABELA sensor
CREATE TABLE TBL_SENSOR(
	id INT PRIMARY KEY AUTO_INCREMENT,
    num_serie INT NOT NULL UNIQUE,
    posicao VARCHAR(50) NOT NULL,
    sensor_status VARCHAR(50) NOT NULL,
    temperatura DECIMAL(4,2)
);

-- CRIAÇÃO DE CONSTRAINT
ALTER TABLE TBL_SENSOR ADD CONSTRAINT chkStatusSensor
		CHECK(sensor_status IN('Ativo','Inativo','Manutenção'));

-- INSERÇÃO DE DADOS
INSERT INTO TBL_SENSOR (num_serie, posicao, sensor_status, temperatura) VALUES
    (1001, 'Ponto Mais Quente do Baú', 'Ativo', 2.5),
    (1002, 'Ponto Mais Frio do Baú', 'Inativo', null),
    (1003, 'Centro do Baú', 'Ativo', 1.8),
    (1004, 'Canto Superior', 'Ativo', 3.1),
    (1005, 'Canto Inferior', 'Inativo', null),
    (1006, 'Próximo à Carga Sensível', 'Ativo', 9.7),
    (1007, 'Ponto Mais Quente do Baú', 'Ativo', 0.5),
    (1008, 'Ponto Mais Frio do Baú', 'Manutenção', null),
    (1009, 'Centro do Baú', 'Inativo', null),
    (1010, 'Canto Superior', 'Ativo', -2.3),
    (1011, 'Canto Inferior', 'Ativo', 3.4),
    (1012, 'Próximo à Carga Sensível', 'Inativo', null),
    (1013, 'Ponto Mais Quente do Baú', 'Ativo', -4.5),
    (1014, 'Ponto Mais Frio do Baú', 'Ativo', 0.1),
    (1015, 'Centro do Baú', 'Inativo', null),
    (1016, 'Canto Superior', 'Ativo', 6.2),
    (1017, 'Canto Inferior', 'Ativo', 5.7),
    (1018, 'Próximo à Carga Sensível', 'Inativo', null),
    (1019, 'Ponto Mais Quente do Baú', 'Ativo', 8.3),
    (1020, 'Ponto Mais Frio do Baú', 'Ativo', 2.6),
    (1021, 'Centro do Baú', 'Inativo', null),
    (1022, 'Canto Superior', 'Ativo', -2.0),
    (1023, 'Canto Inferior', 'Ativo', 2.2),
    (1024, 'Próximo à Carga Sensível', 'Inativo', null),
    (1025, 'Ponto Mais Quente do Baú', 'Ativo', 2.9),
    (1026, 'Ponto Mais Frio do Baú', 'Manutenção', null),
    (1027, 'Centro do Baú', 'Manutenção', null),
    (1028, 'Canto Superior', 'Ativo', 2.9),
    (1029, 'Canto Inferior', 'Ativo', 7.7),
    (1030, 'Próximo à Carga Sensível', 'Inativo', null);


-- CRIAÇÃO DA TABELA produto
CREATE TABLE TBL_PRODUTO(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    temp_max DECIMAL(4,2) NOT NULL,
    temp_min DECIMAL(4,2) NOT NULL,
    foto_url VARCHAR(249) UNIQUE
);

-- INSERÇÃO DE DADOS
INSERT INTO TBL_PRODUTO (nome, descricao, temp_max, temp_min, foto_url) VALUES
	('Sorvete de Chocolate Delícia', 'Sorvete cremoso de chocolate belga, com pedaços de chocolate meio amargo. Perfeito para refrescar os dias quentes.', 5.00, -1.00, 'http://exemplo.com/sorvete_chocolate.jpg'),
	('Iogurte Natural Premium', 'Iogurte natural sem adição de açúcares, com probióticos para uma alimentação saudável e saborosa.', 4.00, -2.00, 'http://exemplo.com/iogurte_natural.jpg'),
	('Pão de Mel Artesanal', 'Pão de mel recheado com doce de leite e coberto com chocolate meio amargo. Um sabor irresistível para qualquer momento.', 5.00, -1.00, 'http://exemplo.com/pao_de_mel.jpg'),
	('Queijo Brie Cremoso', 'Queijo Brie com casca fina e cremoso por dentro, ideal para acompanhar vinhos e aperitivos.', 4.00, -2.00, 'http://exemplo.com/queijo_brie.jpg'),
	('Bolo de Cenoura Caseiro', 'Bolo de cenoura fofinho e molhadinho, coberto com chocolate derretido. Ideal para o lanche da tarde.', 2.00, -2.00, 'http://exemplo.com/bolo_cenoura.jpg'),
	('Suco de Laranja Natural', 'Suco 100% natural de laranja, sem adição de conservantes, preservando o sabor e a frescura da fruta.', 5.00, -1.00, 'http://exemplo.com/suco_laranja.jpg'),
	('Gelatina de Frutas Vermelhas', 'Gelatina refrescante feita com frutas vermelhas naturais, ideal para uma sobremesa leve e deliciosa.', 5.00, -3.00, 'http://exemplo.com/gelatina_frutas_vermelhas.jpg'),
	('Mousse de Maracujá', 'Mousse de maracujá cremoso e azedinho, preparado com polpa de maracujá fresca. Perfeito para qualquer ocasião.', 4.00, -2.00, 'http://exemplo.com/mousse_maracuja.jpg'),
	('Biscoito de Polvilho Crocante', 'Biscoito de polvilho artesanal, crocante e leve, ideal para o lanche ou para acompanhar o café.', 4.50, -1.00, 'http://exemplo.com/biscoito_polvilho.jpg'),
	('Creme de Avelã com Chocolate', 'Creme de avelã com chocolate, cremoso e saboroso, ideal para passar no pão ou comer com frutas.', 3.00, -2.00, 'http://exemplo.com/creme_avela.jpg'),
	('Bolo de Chocolate com Nozes', 'Bolo de chocolate fofinho, recheado com nozes crocantes e coberto com ganache de chocolate.', 4.00, -2.00, 'http://exemplo.com/bolo_chocolate_nozes.jpg'),
	('Café Gourmet em Grãos', 'Café gourmet em grãos, com aroma intenso e sabor encorpado, ideal para preparar uma bebida de alta qualidade.', 3.00, -2.00, 'http://exemplo.com/cafe_gourmet.jpg'),
	('Pudim de Leite Condensado', 'Pudim de leite condensado cremoso e com calda caramelizada, uma verdadeira sobremesa tradicional e deliciosa.', 5.00, -1.00, 'http://exemplo.com/pudim_leite_condensado.jpg'),
	('Frutas Cristalizadas', 'Frutas cristalizadas de alta qualidade, perfeitas para incrementar bolos, tortas ou comer puras.', 5.00, -3.00, 'http://exemplo.com/frutas_cristalizadas.jpg'),
	('Chá de Camomila Relax', 'Chá de camomila com propriedades calmantes, ideal para relaxar e garantir uma noite de sono tranquila.', 5.00, -1.00, 'http://exemplo.com/cha_camomila.jpg');


-- CRIAÇÃO DA TABELA carga
CREATE TABLE TBL_CARGA(
	id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_produto INT,
    valor DECIMAL(7,2) NOT NULL
);

-- INSERÇÃO DE DADOS
INSERT INTO TBL_CARGA (codigo_produto, valor) VALUES
	(1, 159.99),
	(2, 450.00),
	(3, 799.99),
	(4, 2500.00),
	(5, 1099.00),
	(6, 680.00),
	(7, 11230.00),
	(8, 350.00),
	(9, 2000.10),
	(10, 890.00),
	(11, 599.00),
	(12, 380.75),
	(13, 950.00),
	(14, 299.00),
	(15, 1399.00);


-- CRIAÇÃO DA TABELA veiculo
CREATE TABLE TBL_VEICULO(
	id INT PRIMARY KEY AUTO_INCREMENT,
    placa CHAR(7) UNIQUE NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    volume FLOAT NOT NULL,
    motorista VARCHAR(60) NOT NULL,
    codigo_sensor INT
);

-- CRIAÇÃO DE CONSTRAINTS
ALTER TABLE TBL_VEICULO ADD CONSTRAINT chkPlaca
		CHECK(placa NOT LIKE "% %");

-- INSERÇÃO DE DADOS
INSERT INTO TBL_VEICULO (placa, modelo, volume, motorista, codigo_sensor) VALUES
	('AB1C234', 'Furgão Ford Transit', 150.0, 'Carlos Silva', 101),
	('XY3Z567', 'Caminhão Mercedes-Benz', 300.0, 'Ana Oliveira', 102),
	('DE4F345', 'Van Renault Master', 150.0, 'João Pereira', 103),
	('GH5I789', 'Caminhonete Chevrolet S10', 450.0, 'Maria Souza', 104),
	('JK6L234', 'Furgão Fiat Ducato', 300.0, 'Paulo Costa', 105),
	('MN7O678', 'Caminhão Scania R450', 450.0, 'Luciana Almeida', 106),
	('PQ8R123', 'Carreta Volvo FH', 450.0, 'Ricardo Gomes', 107),
	('ST9U567', 'Furgão Iveco Daily', 150.0, 'Fernanda Lima', 108),
	('VW0X901', 'Furgão Mercedes-Benz Sprinter', 300.0, 'Roberto Santos', 109),
	('YZ1A345', 'Caminhonete Toyota Hilux', 150.0, 'Eduardo Martins', 110),
	('BC2D789', 'Caminhão Volkswagen Constellation', 300.0, 'Carlos Souza', 111),
	('EF3G123', 'Van Volkswagen Kombi', 150.0, 'Patrícia Costa', 112),
	('HI4J567', 'Caminhão Ford Cargo', 450.0, 'Lucia Rocha', 113),
	('KL5M901', 'Furgão Peugeot Boxer', 300.0, 'Rogério Silva', 114),
	('NO6P345', 'Carreta Scania S500', 450.0, 'Vera Oliveira', 115);


-- CRIAÇÃO DA TABELA uso
CREATE TABLE TBL_USO(
	id INT PRIMARY KEY AUTO_INCREMENT,
    dt DATETIME NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    codigo_carga INT,
    codigo_veiculo INT
);

-- INSERÇÃO DE DADOS
INSERT INTO TBL_USO (dt, descricao, codigo_carga, codigo_veiculo) VALUES
	('2025-01-07 07:12:00', 'Transporte de carga de sorvetes para a filial de São Paulo.', 1, 1),
	('2025-02-11 08:45:30', 'Entrega de iogurtes para o supermercado local.', 2, 2),
	('2025-02-28 09:27:15', 'Transporte de pães de mel para distribuição em lojas de doces.', 3, 3),
	('2025-03-19 10:05:42', 'Entrega de queijo Brie para o restaurante gourmet.', 4, 4),
	('2025-04-27 10:52:11', 'Transporte de bolos de cenoura para ponto de venda.', 5, 5),
	('2025-05-18 11:38:24', 'Transporte de sucos de laranja para supermercado.', 6, 6),
	('2025-06-05 12:19:55', 'Entrega de gelatina de frutas vermelhas para a padaria.', 7, 7),
	('2025-06-22 13:02:37', 'Transporte de mousse de maracujá para lojas de sobremesas.', 8, 8),
	('2025-07-14 13:48:49', 'Entrega de biscoitos de polvilho para mercados regionais.', 9, 9),
	('2025-08-17 14:21:05', 'Transporte de creme de avelã com chocolate para distribuição em supermercados.', 10, 10),
	('2025-08-23 15:13:22', 'Entrega de bolo de chocolate com nozes para eventos corporativos.', 11, 11),
	('2025-09-30 16:07:18', 'Transporte de café gourmet para o ponto de venda especializado.', 12, 12),
	('2025-10-01 16:45:51', 'Entrega de pudins de leite condensado para padarias e confeitarias.', 13, 13),
	('2025-11-26 17:36:09', 'Transporte de frutas cristalizadas para indústria de confeitaria.', 14, 14),
	('2025-12-09 18:29:33', 'Entrega de chá de camomila para mercados de produtos naturais.', 15, 15);


-- VIZUALIZAÇÃO DE INFORMAÇÕES

-- TBL_USER_ADMIN
SELECT * FROM TBL_USER_ADMIN;
SELECT email, senha FROM TBL_USER_ADMIN WHERE senha LIKE '%$%';
SELECT nome, telefone, email FROM TBL_USER_ADMIN WHERE nome NOT LIKE '%s%' ORDER BY nome ASC;
SELECT CONCAT('Você pode contatar o/a ADMIN ',nome,' pelo número ',telefone,' ou pelo email ', email,' !') AS Contato_Admins FROM TBL_USER_ADMIN ORDER BY nome;


-- TBL_USER
SELECT * FROM TBL_USER;
SELECT nome, telefone FROM TBL_USER WHERE telefone = '11969473829';
SELECT * FROM TBL_USER WHERE cpf LIKE '_2%';


-- TBL_SENSOR
SELECT * FROM TBL_SENSOR;
SELECT CONCAT('O sensor que possui o número de série ',num_serie,' está localizado no ',posicao,' e capturou a temperatura de: ',temperatura,'°C') AS Informações_do_sensor 
	FROM TBL_SENSOR WHERE sensor_status = 'Ativo';
SELECT num_serie,
	CASE
    WHEN sensor_status = 'Inativo' THEN 'Necessario Revisão'
    WHEN sensor_status = 'Manutenção' THEN 'Necessario Revisão'
    WHEN sensor_status = 'Ativo' THEN 'Está tudo certo'
    END AS Status_sensor FROM TBL_SENSOR;    
SELECT num_serie, IFNULL(temperatura, 'O sensor está com algum problema') AS Temperatura_obtida FROM TBL_SENSOR;
SELECT num_serie, temperatura,
	CASE
    WHEN temperatura > 6 THEN 'Temperatura muito elevada, cuidado!'
    WHEN temperatura < -1 THEN 'Temperatura muito baixa, cuidado!'
    WHEN temperatura BETWEEN -1 AND 6 THEN 'A temperatura está de acordo com o ideal'
    END AS Alerta FROM TBL_SENSOR WHERE sensor_status = 'Ativo';


-- TBL_PRODUTO
SELECT * FROM TBL_PRODUTO;
SELECT nome FROM TBL_PRODUTO WHERE temp_max < 5;
SELECT CONCAT(nome,' necessita estar entre ',temp_max,' e ',temp_min,' Graus Celsius.') AS Temperatura_ideal FROM TBL_PRODUTO;


-- TBL_CARGA
SELECT * FROM TBL_CARGA;
SELECT id, codigo_produto FROM TBL_CARGA;


-- TBL_VEICULO
SELECT * FROM TBL_VEICULO;
SELECT * FROM TBL_VEICULO WHERE codigo_sensor BETWEEN 110 AND 115;


-- TBL_USO
SELECT * FROM TBL_USO;
SELECT * FROM TBL_USO WHERE dt > '2025-07-14';
SELECT dt, descricao FROM TBL_USO WHERE descricao LIKE 'E%';
SELECT * FROM TBL_USO WHERE descricao LIKE '%i__' ORDER BY id DESC;
