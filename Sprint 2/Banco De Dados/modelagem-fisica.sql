CREATE DATABASE PoGuard;
USE PoGuard;
-- DROP DATABASE PoGuard;


-- DROP TABLE TBL_EMPRESA;
CREATE TABLE TBL_EMPRESA(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
cnpj CHAR(18) NOT NULL,
email VARCHAR(100) NOT NULL,
telefone CHAR(13),
codigoEmpresa CHAR(10) UNIQUE,
CONSTRAINT chkEmailEmpresa CHECK(email LIKE '%@%')
);


-- DROP TABLE TBL_USUARIO;
CREATE TABLE TBL_USUARIO(
idUsuario INT AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(100) NOT NULL,
senha VARCHAR(20) NOT NULL,
cargo VARCHAR(45) NOT NULL,
fkEmpresa INT,
CONSTRAINT pkUsuarioEmpresa PRIMARY KEY(idUsuario, fkEmpresa),
CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES TBL_EMPRESA(idEmpresa),
CONSTRAINT chkEmailUsuario CHECK (email LIKE '%@%'),
CONSTRAINT chkCargo CHECK (cargo IN ('funcionario', 'gerente'))
);


-- DROP TABLE TBL_VEICULO;
CREATE TABLE TBL_VEICULO(
idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
placa CHAR(7) NOT NULL,
modelo VARCHAR(100),
fkEmpresa INT,
CONSTRAINT fkVeiculoEmpresa FOREIGN KEY (fkEmpresa) REFERENCES TBL_EMPRESA(idEmpresa)
);


-- DROP TABLE TBL_SENSOR;
CREATE TABLE TBL_SENSOR(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
numSerie INT NOT NULL,
modeloSensor VARCHAR(45) NOT NULL,
statusSensor VARCHAR(45) NOT NULL,
localSensor VARCHAR(45) NOT NULL,
fkVeiculo INT NOT NULL,
CONSTRAINT fkSensorVeiculo FOREIGN KEY (fkVeiculo) REFERENCES TBL_VEICULO(idVeiculo),
CONSTRAINT statusSensor CHECK(statusSensor IN ('ativo', 'inativo', 'manutenção')),
CONSTRAINT localSensor CHECK(localSensor IN ('Fundo', 'Centro', 'Porta'))
);


-- DROP TABLE TBL_DADO;
CREATE TABLE TBL_DADO(
idDado INT AUTO_INCREMENT,
temperatura DECIMAL(4,2) NOT NULL,
dataHora DATETIME,
fkSensor INT,
PRIMARY KEY(idDado, fkSensor),
CONSTRAINT fkDadoSensor FOREIGN KEY  (fkSensor) REFERENCES TBL_SENSOR(idSensor)
);


-- DROP TABLE TBL_ALERTA;
CREATE TABLE TBL_ALERTA(
idAlerta INT AUTO_INCREMENT,
titulo VARCHAR(60) NOT NULL,
statusAlerta VARCHAR(8) NOT NULL,
mensagem VARCHAR(400) NOT NULL,
dtAlerta DATETIME NOT NULL,
dtLeitura DATETIME,
fkDado INT,
PRIMARY KEY(idAlerta, fkDado),
CONSTRAINT chkStatusAlerta CHECK (statusAlerta IN ('verde', 'amarelo', 'vermelho')),
CONSTRAINT fkAlertaDado FOREIGN KEY (fkDado) REFERENCES TBL_DADO(idDado)
);

CREATE TABLE TBL_HISTORICO (
idHistorico INT AUTO_INCREMENT,
dataInicio DATETIME NOT NULL,
dataFim DATETIME NOT NULL,
fkUsuario INT,
fkEmpresa INT,
fkVeiculo INT,
CONSTRAINT pksHistorico PRIMARY KEY (idHistorico, fkUsuario, fkEmpresa, fkVeiculo),
CONSTRAINT fkHistoricoUsuario FOREIGN KEY (fkUsuario)
	REFERENCES TBL_USUARIO(idUsuario),
CONSTRAINT fkHistoricoEmpresa FOREIGN KEY (fkEmpresa)
	REFERENCES TBL_EMPRESA(idEmpresa),
CONSTRAINT fkHistoricoVeiculo FOREIGN KEY (fkVeiculo)
	REFERENCES TBL_VEICULO(idVeiculo)
);

-- INSERÇÕES 
INSERT INTO TBL_EMPRESA (nome, cnpj, email, telefone, codigoEmpresa) VALUES 
('Transportes Rápidos Ltda', '12.345.678/0001-90', 'contato@transportesrapidos.com', '11-98765-4321', 'TRANS001'),
('Logística Nacional S.A.', '98.765.432/0001-21', 'sac@logisticanacional.com.br', '(1-98765-1234', 'LOG002'),
('Cargas Pesadas ME', '45.678.912/0001-34', 'atendimento@cargaspesadas.me', '31-91234-5678', 'CARGA003'),
('Distribuidora Express', '78.912.345/0001-67', 'contato@expressdist.com', '41-99876-5432', 'EXP004'),
('Fretes & Entregas Ltda', '23.456.789/0001-89', 'faleconosco@fretesentregas.com', '51-92345-6789', 'FRET005');

INSERT INTO TBL_USUARIO (nome, email, senha, cargo, fkEmpresa) VALUES 
('João Silva', 'joao.silva@transportesrapidos.com', 'js123456', 'gerente', 1),
('Maria Oliveira', 'maria.oliveira@transportesrapidos.com', 'mo654321', 'funcionario', 1),
('Carlos Souza', 'carlos.souza@logisticanacional.com.br', 'cs789012', 'gerente', 2),
('Ana Pereira', 'ana.pereira@logisticanacional.com.br', 'ap345678', 'funcionario', 2),
('Pedro Costa', 'pedro.costa@cargaspesadas.me', 'pc901234', 'gerente', 3),
('Fernanda Lima', 'fernanda.lima@expressdist.com', 'fl567890', 'gerente', 4),
('Ricardo Santos', 'ricardo.santos@fretesentregas.com', 'rs123789', 'gerente', 5);

INSERT INTO TBL_VEICULO (placa, modelo, fkEmpresa) VALUES 
('ABC1D23', 'Volvo FH 540', 1),
('DEF4G56', 'Scania R500', 1),
('GHI7J89', 'Mercedes-Benz Actros', 2),
('JKL0M12', 'Volkswagen Constellation', 2),
('MNO3P45', 'Ford Cargo 2429', 3),
('PQR6S78', 'Iveco Stralis', 4),
('STU9V01', 'DAF XF 480', 5);

INSERT INTO TBL_SENSOR (numSerie, modeloSensor, statusSensor, localSensor, fkVeiculo) VALUES 
(1001, 'SensTemp-1000', 'ativo', 'Fundo', 1),
(1002, 'SensTemp-1000', 'ativo', 'Centro', 1),
(1003, 'SensTemp-1000', 'ativo', 'Porta', 1),
(2001, 'SensTemp-2000', 'ativo', 'Fundo', 2),
(2002, 'SensTemp-2000', 'ativo', 'Centro', 2),
(3001, 'SensTemp-1000', 'manutenção', 'Fundo', 3),
(4001, 'SensTemp-2000', 'ativo', 'Fundo', 4),
(5001, 'SensTemp-1000', 'inativo', 'Fundo', 5),
(6001, 'SensTemp-2000', 'ativo', 'Fundo', 6),
(7001, 'SensTemp-1000', 'ativo', 'Fundo', 7);

INSERT INTO TBL_DADO (temperatura, dataHora, fkSensor) VALUES 
(-18.50, '2023-11-01 08:00:00', 1),
(-19.20, '2023-11-01 08:05:00', 1),
(-17.80, '2023-11-01 08:10:00', 1),
(-20.10, '2023-11-01 08:00:00', 2),
(-15.50, '2023-11-01 08:05:00', 2),
(-12.30, '2023-11-01 08:10:00', 3),
(-18.75, '2023-11-01 09:00:00', 4),
(-19.90, '2023-11-01 09:05:00', 4),
(-5.20, '2023-11-01 09:00:00', 7),
(2.50, '2023-11-01 09:05:00', 7),
(-18.30, '2023-11-01 10:00:00', 9),
(-18.60, '2023-11-01 10:05:00', 9),
(-19.10, '2023-11-01 11:00:00', 10);

INSERT INTO TBL_ALERTA (titulo, statusAlerta, mensagem, dtAlerta, dtLeitura, fkDado) VALUES 
('Temperatura estável', 'verde', 'Temperatura dentro do esperado para produtos congelados', '2023-11-01 08:00:00', '2023-11-01 08:02:00', 1),
('Temperatura estável', 'verde', 'Temperatura dentro do esperado para produtos congelados', '2023-11-01 08:05:00', '2023-11-01 08:07:00', 2),
('Temperatura elevada', 'amarelo', 'Temperatura próxima ao limite superior para produtos congelados', '2023-11-01 08:10:00', '2023-11-01 08:15:00', 3),
('Temperatura crítica', 'vermelho', 'Temperatura acima do limite para produtos congelados', '2023-11-01 08:10:00', '2023-11-01 08:20:00', 6),
('Temperatura crítica', 'vermelho', 'Temperatura acima do limite para produtos congelados', '2023-11-01 09:05:00', NULL, 10),
('Temperatura estável', 'verde', 'Temperatura dentro do esperado para produtos congelados', '2023-11-01 11:00:00', NULL, 13);

INSERT INTO TBL_HISTORICO (dataInicio, dataFim, fkUsuario, fkEmpresa, fkVeiculo) VALUES
-- Histórico do gerente João Silva com o veículo Volvo FH 540
('2023-11-01 08:00:00', '2023-11-01 12:00:00', 1, 1, 1),

-- Histórico da funcionária Maria Oliveira com o veículo Scania R500
('2023-11-01 13:00:00', '2023-11-01 17:00:00', 2, 1, 2),

-- Histórico do gerente Carlos Souza com o veículo Mercedes-Benz Actros
('2023-11-01 07:30:00', '2023-11-01 15:30:00', 3, 2, 3),

-- Histórico do gerente Pedro Costa com o veículo Ford Cargo 2429
('2023-11-01 06:00:00', '2023-11-01 18:00:00', 5, 3, 5);

-- Verificação básica dos dados inseridos
SELECT * FROM TBL_EMPRESA;

SELECT * FROM TBL_USUARIO;

SELECT * FROM TBL_VEICULO; 

SELECT * FROM TBL_CARGA;

SELECT * FROM TBL_SENSOR;

SELECT * FROM TBL_DADO;

SELECT * FROM TBL_ALERTA; 

-- -- VIEWS
CREATE VIEW vw_login_page as 
	SELECT 
		idUsuario,
		email,
        senha
	FROM
		TBL_USUARIO
	WHERE
		email = '${email}' AND
        senha = '${senha}';
        
        
CREATE VIEW vw_frota_ativa as 
	SELECT 
		COUNT(v.idVeiculo) as Frota,
        (
			select
				COUNT(vs.idVeiculo)
			FROM
				TBL_EMPRESA es JOIN TBL_VEICULO vs
					ON es.idEmpresa = vs.fkEmpresa
				JOIN TBL_HISTORICO hs
					ON vs.idVeiculo = hs.fkVeiculo
			WHERE
				hs.dataFim = null
        ) as Ativo
	FROM
		TBL_USUARIO u JOIN TBL_EMPRESA e
			ON e.idEmpresa = u.fkEmpresa
		JOIN TBL_VEICULO v
			ON e.idEmpresa = v.fkEmpresa
		JOIN TBL_HISTORICO h
			ON v.idVeiculo = h.fkVeiculo;
	
    select * from vw_frota_ativa;



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




