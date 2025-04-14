CREATE DATABASE PoGuard;
USE PoGuard;

-- TABELA USUARIO
-- DROP TABLE TBL_USUARIO;
CREATE TABLE TBL_USUARIO(
idUsuario INT AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(100) NOT NULL,
cpf CHAR(16) NOT NULL,
telefone CHAR(13),
senha VARCHAR(20) NOT NULL,
cargo VARCHAR(45) NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT pkUsuarioEmpresa PRIMARY KEY(idUsuario, fkEmpresa),
CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES TBL_EMPRESA(idEmpresa),
CONSTRAINT chkEmailUsuario CHECK (email LIKE '%@%'),
CONSTRAINT chkCargo CHECK (cargo IN ('funcionario', 'gerente'))
);

-- TABELA EMPRESA
-- DROP TABLE TBL_EMPRESA;
CREATE TABLE TBL_EMPRESA(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cnpj CHAR(18) NOT NULL,
email VARCHAR(100) NOT NULL,
telefone CHAR(13),
CONSTRAINT chkEmailEmpresa CHECK(email LIKE '%@%')
);

-- TABELA VEICULO
-- DROP TABLE TBL_VEICULO;
CREATE TABLE TBL_VEICULO(
idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
placa CHAR(7) NOT NULL,
modelo VARCHAR(100),
motoristo VARCHAR(100),
fkEmpresa INT NOT NULL,
CONSTRAINT fkVeiculoEmpresa FOREIGN KEY (fkEmpresa) REFERENCES TBL_EMPRESA(idEmpresa)
);

-- TABELA CARGA
-- DROP TABLE TBL_CARGA;
CREATE TABLE TBL_CARGA(
idCarga INT PRIMARY KEY AUTO_INCREMENT,
descricao VARCHAR(400),
tipoCarga VARCHAR(45) NOT NULL,
temperaturaMaxima DECIMAL(4, 2) NOT NULL,
temperaturaMinima DECIMAL(4, 2) NOT NULL,
fkVeiculo INT UNIQUE NOT NULL,
CONSTRAINT fkCargaVeiculo FOREIGN KEY (fkVeiculo) REFERENCES TBL_VEICULO(idVeiculo)
);

-- TABELA SENSOR
-- DROP TABLE TBL_SENSOR;
CREATE TABLE TBL_SENSOR(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
numSerie INT NOT NULL,
modeloSensor VARCHAR(45) NOT NULL,
statusSensor VARCHAR(10) NOT NULL,
fkVeiculo INT NOT NULL,
CONSTRAINT fkSensorVeiculo FOREIGN KEY (fkVeiculo) REFERENCES TBL_VEICULO(idVeiculo),
CONSTRAINT statusSensor CHECK(statusSensor IN ('ativo', 'inativo', 'manutenção'))
);

-- TABELA DADO
-- DROP TABLE TBL_DADO;
CREATE TABLE TBL_DADO(
idDado INT AUTO_INCREMENT,
temperatura DECIMAL(4,2) NOT NULL,
dataHora DATETIME NOT NULL,
fkSensor INT,
PRIMARY KEY(idDado, fkSensor),
CONSTRAINT fkDadoSensor FOREIGN KEY  (fkSensor) REFERENCES TBL_SENSOR(idSensor)
);

-- TABELA ALERTA
-- DROP TABLE TBL_ALERTA;
CREATE TABLE TBL_ALERTA(
idAlerta INT AUTO_INCREMENT,
titulo VARCHAR(60) NOT NULL,
statusAlerta VARCHAR(8) NOT NULL,
mensagem VARCHAR(400) NOT NULL,
fkDado INT UNIQUE,
PRIMARY KEY(idAlerta, fkDado),
CONSTRAINT chkStatusAlerta CHECK (statusAlerta IN ('verde', 'amarelo', 'vermelho')),
CONSTRAINT fkAlertaDado FOREIGN KEY (fkDado) REFERENCES TBL_DADO(idDado)
);

INSERT INTO TBL_USUARIO VALUES 
(default, "Guilherme Dias", "gui.dias@poguard.com", 12345678900, 40028922, "123B!g@00", "gerente", 1), 
(default, "Lucas Queiroz", "lucas.queiroz@poguard.com", 00987654321, 89224002, "00aaa123@P", "funcionario", 2);   

INSERT INTO TBL_EMPRESA (nome, cnpj, email, telefone) 
VALUES 
('Empresa Exemplo 1', '12.345.678/0001-90', 'contato@empresa1.com', '1234567890123'),
('Empresa Exemplo 2', '98.765.432/0001-87', 'contato@empresa2.com', '9876543210987');

INSERT INTO TBL_VEICULO (placa, modelo, motoristo, fkEmpresa) 
VALUES 
('ABC1234', 'Caminhão 1', 'João Silva', 1),
('XYZ5678', 'Caminhão 2', 'Maria Oliveira', 2);

INSERT INTO TBL_CARGA (descricao, tipoCarga, temperaturaMaxima, temperaturaMinima, fkVeiculo) 
VALUES 
('Carga 1', 'Carnes', 4.00, -2.00, 1),
('Carga 2', 'Laticínios', 7.00, 0.00, 2);

INSERT INTO TBL_SENSOR (numSerie, modeloSensor, statusSensor, fkVeiculo) 
VALUES 
(123456, 'Sensor 1', 'ativo', 1),
(789012, 'Sensor 2', 'ativo', 2);

INSERT INTO TBL_DADO (temperatura, dataHora, fkSensor) 
VALUES 
(10.00, '2025-04-14 10:00:00', 1),
(8.00, '2025-04-14 11:00:00', 2);

INSERT INTO TBL_ALERTA (titulo, statusAlerta, mensagem, fkDado) 
VALUES 
('Alerta Vermelho de Temperatura - Fora do ideal', 'vermelho', 'Temperatura do veículo 1 muito acima do limite!', 1),
('Alerta Amarelo de Temperatura - Fora do ideal ', 'amarelo', 'Temperatura do veículo 2 acima do limite.', 2);

-- Verificação básica dos dados inseridos
SELECT * FROM TBL_EMPRESA;

SELECT * FROM TBL_USUARIO;

SELECT * FROM TBL_VEICULO; 

SELECT * FROM TBL_CARGA;

SELECT * FROM TBL_SENSOR;

SELECT * FROM TBL_DADO;

SELECT * FROM TBL_ALERTA; 

SELECT usuario.nome AS 'Nome do Integrante', 
	   usuario.cargo AS 'Cargo do Integrante', 
       empresa.nome AS 'Nome da Empresa'
       FROM TBL_EMPRESA as empresa JOIN TBL_USUARIO AS usuario 
       ON empresa.idEmpresa = usuario.fkEmpresa;

SELECT empresa.nome AS 'Nome da Empresa', 
	   veiculo.placa AS 'Placa do veículo', 
       carga.tipoCarga AS 'Tipo da Carga', 
       sensor.statusSensor AS 'Status do Sensor', 
       dado.temperatura AS 'Temperatura Atual', 
       alerta.titulo AS 'Mensagem do alerta', 
       alerta.statusAlerta AS 'Status do alerta'
       FROM TBL_EMPRESA AS empresa
       JOIN TBL_VEICULO AS veiculo
       ON empresa.idEmpresa = veiculo.fkEmpresa
       JOIN TBL_CARGA AS carga
       ON veiculo.idVeiculo = carga.fkVeiculo
       JOIN TBL_SENSOR AS sensor
       ON veiculo.idVeiculo = sensor.fkVeiculo
       JOIN TBL_DADO AS dado
       ON sensor.idSensor = dado.fkSensor
       JOIN TBL_ALERTA AS alerta
       ON dado.idDado = alerta.fkDado;
       
-- Exibição dos dados - Empresa 1       
SELECT empresa.nome AS 'Nome da Empresa', 
	   veiculo.placa AS 'Placa do veículo', 
       carga.tipoCarga AS 'Tipo da Carga', 
       sensor.statusSensor AS 'Status do Sensor', 
       dado.temperatura AS 'Temperatura Atual', 
       alerta.titulo AS 'Mensagem do alerta', 
       alerta.statusAlerta AS 'Status do alerta'
       FROM TBL_EMPRESA AS empresa
       JOIN TBL_VEICULO AS veiculo
       ON empresa.idEmpresa = veiculo.fkEmpresa
       JOIN TBL_CARGA AS carga
       ON veiculo.idVeiculo = carga.fkVeiculo
       JOIN TBL_SENSOR AS sensor
       ON veiculo.idVeiculo = sensor.fkVeiculo
       JOIN TBL_DADO AS dado
       ON sensor.idSensor = dado.fkSensor
       JOIN TBL_ALERTA AS alerta
       ON dado.idDado = alerta.fkDado
       WHERE idEmpresa = 1;
       
-- Exibição dos dados - Empresa 2       
SELECT empresa.nome AS 'Nome da Empresa', 
	   veiculo.placa AS 'Placa do veículo', 
       carga.tipoCarga AS 'Tipo da Carga', 
       sensor.statusSensor AS 'Status do Sensor', 
       dado.temperatura AS 'Temperatura Atual', 
       alerta.titulo AS 'Mensagem do alerta', 
       alerta.statusAlerta AS 'Status do alerta'
       FROM TBL_EMPRESA AS empresa
       JOIN TBL_VEICULO AS veiculo
       ON empresa.idEmpresa = veiculo.fkEmpresa
       JOIN TBL_CARGA AS carga
       ON veiculo.idVeiculo = carga.fkVeiculo
       JOIN TBL_SENSOR AS sensor
       ON veiculo.idVeiculo = sensor.fkVeiculo
       JOIN TBL_DADO AS dado
       ON sensor.idSensor = dado.fkSensor
       JOIN TBL_ALERTA AS alerta
       ON dado.idDado = alerta.fkDado
       WHERE idEmpresa = 2;
       
SELECT veiculo.placa AS 'Placa do Veículo', 
	   carga.tipoCarga AS 'Tipo da Carga', 
       sensor.statusSensor AS 'Status do Sensor', 
       dado.temperatura AS 'Temperatura Atual', 
       alerta.titulo AS 'Mensagem do alerta', 
       alerta.statusAlerta AS 'Status do alerta'
       FROM TBL_VEICULO AS veiculo
       JOIN TBL_CARGA AS carga
       ON veiculo.idVeiculo = carga.fkVeiculo
       JOIN TBL_SENSOR AS sensor 
       ON sensor.id