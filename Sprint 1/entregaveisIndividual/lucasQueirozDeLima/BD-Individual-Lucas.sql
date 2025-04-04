CREATE DATABASE projeto;
USE projeto;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    username VARCHAR(40) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(20) NOT NULL

);

CREATE TABLE funcionario (
	idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cpf CHAR(11) NOT NULL,
    username VARCHAR(40) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    funcao VARCHAR(40)

);

CREATE TABLE veiculo (
	idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
	placa CHAR(7) NOT NULL,
    porte INT NOT NULL,
    statusVeiculo VARCHAR(30),
    qtdSensores INT
    
);

CREATE TABLE alimento (
	idAlimento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    temperaturaMinima DECIMAL(4,2) NOT NULL, 
    temperaturaMaxima DECIMAL(4,2) NOT NULL, 
	qtdProduto INT,
    precoPorUnidade DECIMAL(6,2)

);

CREATE TABLE sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numSerie INT,
    tipoSensor VARCHAR(30),
    dtInstalacao DATE,
    statusSensor VARCHAR(30),
    dtUltimaManutencao DATE
    
);

CREATE TABLE dados (
	IdDados INT PRIMARY KEY AUTO_INCREMENT,
    dtObtencao DATETIME,
    temperatura DECIMAL(4,2)

);

ALTER TABLE empresa AUTO_INCREMENT = 100;
ALTER TABLE funcionario AUTO_INCREMENT = 100;
ALTER TABLE veiculo AUTO_INCREMENT = 100;
ALTER TABLE alimento AUTO_INCREMENT = 100;
ALTER TABLE sensor AUTO_INCREMENT = 100;
ALTER TABLE dados AUTO_INCREMENT = 100;

ALTER TABLE empresa ADD CONSTRAINT chkEmailEmpresa 
		CHECK(email LIKE "%@%");

ALTER TABLE funcionario ADD CONSTRAINT chkEmailFuncionario 
		CHECK(email LIKE "%@%");

ALTER TABLE veiculo ADD CONSTRAINT chkStatusVeiculo
		CHECK(statusVeiculo IN('Movimento','Inativo','Em espera'));

ALTER TABLE sensor ADD CONSTRAINT chkStatusSensor
		CHECK(statusSensor IN('Ativo','Desativo','Manutenção'));
        
INSERT INTO empresa (nome, cnpj, username, email, senha) VALUES
	('Tech Innovators', '12345678000101', 'tech_innovators', 'tech@innovators.com', 'tech1234'),
	('Green Solutions', '23456789000102', 'green_solutions', 'green@solutions.com', 'green5678'),
	('Future Builders', '34567890000103', 'future_builders', 'future@builders.com', 'build2023'),
	('Cloud Masters', '45678901000104', 'cloud_masters', 'cloud@masters.com', 'cloud7890'),
	('Data Wizards', '56789012000105', 'data_wizards', 'data@wizards.com', 'wizard123'),
	('Eco Energy', '67890123000106', 'eco_energy', 'eco@energy.com', 'eco2023!'),
	('Code Crafters', '78901234000107', 'code_crafters', 'code@crafters.com', 'craft2023'),
	('Smart Logistics', '89012345000108', 'smart_logistics', 'smart@logistics.com', 'logi2023'),
	('Pixel Artisans', '90123456000109', 'pixel_artisans', 'pixel@artisans.com', 'pixel123'),
	('Health Tech', '01234567000110', 'health_tech', 'health@tech.com', 'health2023'),
	('Solar Power Co', '12345098700111', 'solar_power', 'solar@power.com', 'solar123'),
	('AI Pioneers', '23456109800112', 'ai_pioneers', 'ai@pioneers.com', 'pioneer2023'),
	('Food Innovate', '34567210900113', 'food_innovate', 'food@innovate.com', 'food2023');

SELECT * FROM empresa;

SELECT email, senha FROM empresa WHERE senha LIKE '%!%';

SELECT * FROM empresa ORDER BY nome DESC;

SELECT nome, cnpj FROM empresa WHERE cnpj LIKE '%1';

INSERT INTO funcionario (nome, cpf, username, email, senha, funcao) VALUES
	('João Silva', '12345678901', 'joao_silva', 'joao.silva@example.com', 'joao1234', 'Desenvolvedor'),
	('Maria Oliveira', '23456789012', 'maria_oliveira', 'maria.oliveira@example.com', 'maria5678', 'Analista de Dados'),
	('Carlos Souza', '34567890123', 'carlos_souza', 'carlos.souza@example.com', 'carlos2023', 'Gerente de Projetos'),
	('Ana Costa', '45678901234', 'ana_costa', 'ana.costa@example.com', 'ana2023!', 'Designer UX/UI'),
	('Pedro Rocha', '56789012345', 'pedro_rocha', 'pedro.rocha@example.com', 'pedro123', 'Engenheiro de Software'),
	('Fernanda Lima', '67890123456', 'fernanda_lima', 'fernanda.lima@example.com', 'fernanda2023', 'Analista de Marketing'),
	('Ricardo Alves', '78901234567', 'ricardo_alves', 'ricardo.alves@example.com', 'ricardo123', 'Administrador de Sistemas'),
	('Juliana Santos', '89012345678', 'juliana_santos', 'juliana.santos@example.com', 'juliana2023', 'Recrutadora'),
	('Lucas Pereira', '90123456789', 'lucas_pereira', 'lucas.pereira@example.com', 'lucas123', 'Desenvolvedor Front-end'),
	('Patrícia Gomes', '01234567890', 'patricia_gomes', 'patricia.gomes@example.com', 'patricia2023', 'Analista Financeiro'),
	('Roberto Fernandes', '12345098765', 'roberto_fernandes', 'roberto.fernandes@example.com', 'roberto123', 'Engenheiro de DevOps'),
	('Amanda Ribeiro', '23456109876', 'amanda_ribeiro', 'amanda.ribeiro@example.com', 'amanda2023', 'Product Manager');
    
SELECT * FROM funcionario;

SELECT nome, email, cpf, funcao AS função FROM funcionario WHERE funcao = 'Desenvolvedor';

SELECT * FROM  funcionario WHERE nome LIKE '_a%';

SELECT funcao FROM funcionario WHERE funcao NOT LIKE '%s';

INSERT INTO veiculo (placa, porte, statusVeiculo, qtdSensores) VALUES
	('ABC1D23', 1, 'Movimento', 4),
	('XYZ9W87', 2, 'Inativo', 6),
	('QWE4R56', 3, 'Em espera', 8),
	('ASD7F89', 1, 'Movimento', 5),
	('ZXC2V34', 2, 'Inativo', 7),
	('POI8U76', 3, 'Em espera', 9),
	('LKJ3H45', 1, 'Movimento', 3),
	('MNB6N67', 2, 'Inativo', 6),
	('TGB9Y78', 3, 'Em espera', 10),
	('RFV1C89', 1, 'Movimento', 4);
    
SELECT * FROM veiculo;

SELECT * FROM veiculo WHERE qtdSensores BETWEEN 8 AND 10;

SELECT placa, statusVeiculo AS Descrição_sobre_veiculo FROM veiculo WHERE statusVeiculo = 'Em espera';

SELECT *, 
	CASE
    WHEN porte = 1 THEN 'Porte pequeno' 
    WHEN porte = 2 THEN 'Porte médio'
    WHEN porte = 3 THEN 'Porte grande'
    END AS porte_do_veiculo FROM veiculo;

INSERT INTO alimento (nome, temperaturaMinima, temperaturaMaxima, qtdProduto, precoPorUnidade) VALUES
	('Maçã', -1.00, 5.00, 100, 1.50),
	('Banana', 8.00, 10.00, 200, 0.80),
	('Leite', 0.00, 4.00, 50, 3.20),
	('Pão Integral', 5.00, 10.00, 150, 2.50),
	('Peito de Frango', -5.00, 2.00, 30, 12.90),
	('Queijo Mussarela', 2.00, 6.00, 40, 8.75),
	('Iogurte Natural', 1.00, 6.00, 60, 4.30),
	('Tomate', 6.00, 10.00, 120, 2.10),
	('Salmão Fresco', -3.00, 2.00, 20, 25.00),
	('Chocolate Amargo', 8.00, 10.00, 80, 6.40);
    
SELECT * FROM alimento;

SELECT * from alimento WHERE temperaturaMinima < 0;

SELECT nome, CONCAT(temperaturaMinima,' até ',temperaturaMaxima) AS Temperatura_ideal FROM alimento;

INSERT INTO sensor (numSerie, tipoSensor, dtInstalacao, statusSensor, dtUltimaManutencao) VALUES
	(1001, 'Temperatura', '2023-01-15', 'Ativo', '2023-09-01'),
	(1002, 'Umidade', '2023-02-20', 'Desativo', '2023-08-25'),
	(1003, 'Pressão', '2023-03-10', 'Ativo', '2023-07-30'),
	(1004, 'Luminosidade', '2023-04-05', 'Manutenção', '2023-09-10'),
	(1005, 'Temperatura', '2023-05-12', 'Desativo', '2023-06-15'),
	(1006, 'Umidade', '2023-06-18', 'Ativo', '2023-08-20'),
	(1007, 'Pressão', '2023-07-22', 'Manutenção', '2023-09-05'),
	(1008, 'Luminosidade', '2023-08-30', 'Desativo', '2023-09-12'),
	(1009, 'Temperatura', '2023-09-01', 'Ativo', '2023-09-15'),
	(1010, 'Umidade', '2023-10-05', 'Manutenção', '2023-10-10');
    
SELECT * FROM sensor;

SELECT * FROM sensor WHERE tipoSensor = 'Temperatura';

SELECT * FROM sensor WHERE statusSensor = 'Ativo';

-- Inserindo 10 linhas de dados criativos na tabela dados
INSERT INTO dados (dtObtencao, temperatura) VALUES
	('2023-10-01 08:30:00', -2.50),
	('2023-10-01 09:15:00', 1.20),
	('2023-10-01 10:00:00', 4.80),
	('2023-10-01 11:45:00', 7.50),
	('2023-10-01 12:30:00', 10.30),
	('2023-10-01 13:20:00', 12.90),
	('2023-10-01 14:10:00', 14.50),
	('2023-10-01 15:00:00', 13.80),
	('2023-10-01 16:45:00', 9.70),
	('2023-10-01 17:30:00', 5.20);
    
SELECT * FROM dados;

SELECT * FROM dados WHERE temperatura > 10;

SELECT * FROM dados WHERE dtObtencao > '2023-10-01 13:20:00';