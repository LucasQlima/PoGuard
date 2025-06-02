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
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
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
dataFim DATETIME,
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
('DSK3421', 'FH 500', 1),
('HKG9348', 'Scania 770s', 1),
('PBNJ107', 'DAF XF 480', 1),
('GYM97P0', 'Mercedes-Benz Atego 2548', 1),
('ATK1010', 'Volkswagen Meteor 28.480', 1),
('PIN8W33', 'Ford Cargo 2429', 1),
('QUE7J89', 'Mercedes-Benz Actros', 2),
('BAT0M12', 'Volkswagen Constellation', 2),
('MON3P45', 'Ford Cargo 2429', 3),
('OPA6S78', 'Iveco Stralis', 4),
('SOC340A', 'DAF XF 480', 5);

INSERT INTO TBL_SENSOR (numSerie, modeloSensor, statusSensor, localSensor, fkVeiculo) VALUES 
(1001, 'SensTemp-1000', 'ativo', 'Fundo', 1),
(1002, 'SensTemp-1000', 'ativo', 'Centro', 1),
(1003, 'SensTemp-1000', 'ativo', 'Porta', 1),
-- ---------------------------------------------
(2001, 'SensTemp-2000', 'ativo', 'Fundo', 2),
(2002, 'SensTemp-2000', 'ativo', 'Centro', 2),
(2003, 'SensTemp-2000', 'ativo', 'Porta', 2),
-- ---------------------------------------------
(3001, 'SensTemp-1000', 'ativo', 'Fundo', 3),
(3002, 'SensTemp-1000', 'ativo', 'Centro', 3),
(3003, 'SensTemp-1000', 'ativo', 'Porta', 3),
-- ---------------------------------------------
(4001, 'SensTemp-2000', 'ativo', 'Fundo', 4),
(4002, 'SensTemp-2000', 'ativo', 'Centro', 4),
(4003, 'SensTemp-2000', 'ativo', 'Porta', 4),
-- ---------------------------------------------
(5001, 'SensTemp-1000', 'ativo', 'Fundo', 5),
(5002, 'SensTemp-1000', 'ativo', 'Centro', 5),
(5003, 'SensTemp-1000', 'ativo', 'Porta', 5),
-- ---------------------------------------------
(6001, 'SensTemp-2000', 'ativo', 'Fundo', 6),
(6002, 'SensTemp-2000', 'ativo', 'Centro', 6),
(6003, 'SensTemp-2000', 'ativo', 'Porta', 6),
-- ---------------------------------------------
(7001, 'SensTemp-1000', 'inativo', 'Fundo', 7),
(7002, 'SensTemp-1000', 'inativo', 'Centro', 7),
(7003, 'SensTemp-1000', 'inativo', 'Porta', 7),
-- ---------------------------------------------
(8001, 'SensTemp-2000', 'inativo', 'Fundo', 8),
(8002, 'SensTemp-2000', 'inativo', 'Centro', 8),
(8003, 'SensTemp-2000', 'inativo', 'Porta', 8),
-- ---------------------------------------------
(9001, 'SensTemp-1000', 'manutenção', 'Fundo', 3),
(1011, 'SensTemp-2000', 'ativo', 'Fundo', 4),
(1021, 'SensTemp-1000', 'inativo', 'Fundo', 5),
(1031, 'SensTemp-2000', 'ativo', 'Fundo', 6),
(1041, 'SensTemp-1000', 'ativo', 'Fundo', 7);
-- TALVES SEJA NECESSARIO ADICIONAR MAIS DADOS NESSA TABLE PARA DASH ESPECIFICA

INSERT INTO TBL_DADO (temperatura, dataHora, fkSensor) VALUES 
(-19.23, '2023-11-01 08:00:00', 1),		(-11.52, '2023-11-01 08:05:00', 1),		(-19.58, '2023-11-01 08:10:00', 1),
(-12.04, '2023-11-01 08:00:00', 2),		(-18.91, '2023-11-01 08:05:00', 2),		(-11.67, '2023-11-01 08:10:00', 2),
(-20.00, '2023-11-01 08:00:00', 3),		(-19.85, '2023-11-01 08:05:00', 3),		(-10.20, '2023-11-01 08:10:00', 3),
(-10.44, '2023-11-01 08:00:00', 4),		(-19.04, '2023-11-01 08:05:00', 4),		(-11.79, '2023-11-01 08:10:00', 4),
(-14.12, '2023-11-01 08:00:00', 5),		(-12.30, '2023-11-01 08:05:00', 5),		(-10.31, '2023-11-01 08:10:00', 5),
(-18.48, '2023-11-01 08:00:00', 6),		(-15.34, '2023-11-01 08:05:00', 6),		(-12.36, '2023-11-01 08:10:00', 6),
(-18.20, '2023-11-01 08:00:00', 7),		(-11.90, '2023-11-01 08:05:00', 7),		(-13.94, '2023-11-01 08:10:00', 7),
(-18.60, '2023-11-01 08:00:00', 8),		(-17.00, '2023-11-01 08:05:00', 8),		(-10.26, '2023-11-01 08:10:00', 8),
(-14.88, '2023-11-01 08:00:00', 9),		(-11.47, '2023-11-01 08:05:00', 9),		(-19.46, '2023-11-01 08:10:00', 9),
(-19.29, '2023-11-01 08:00:00', 10),	(-16.18, '2023-11-01 08:05:00', 10),	(-16.71, '2023-11-01 08:10:00', 10),
(-15.55, '2023-11-01 08:00:00', 11),	(-13.02, '2023-11-01 08:05:00', 11),	(-11.09, '2023-11-01 08:10:00', 11),
(-10.59, '2023-11-01 08:00:00', 12),	(-16.40, '2023-11-01 08:05:00', 12),	(-11.09, '2023-11-01 08:10:00', 12),
(-15.73, '2023-11-01 08:00:00', 13),	(-16.07, '2023-11-01 08:05:00', 13),	(-16.01, '2023-11-01 08:10:00', 13),
(-12.00, '2023-11-01 08:00:00', 14),	(-18.42, '2023-11-01 08:05:00', 14),	(-11.80, '2023-11-01 08:10:00', 14),
(-18.16, '2023-11-01 08:00:00', 15),	(-10.19, '2023-11-01 08:05:00', 15),	(-13.63, '2023-11-01 08:10:00', 15),
(-11.37, '2023-11-01 08:00:00', 16),	(-11.75, '2023-11-01 08:05:00', 16),	(-17.07, '2023-11-01 08:10:00', 16),
(-15.27, '2023-11-01 08:00:00', 17),	(-13.68, '2023-11-01 08:05:00', 17),	(-14.46, '2023-11-01 08:10:00', 17),
(-17.93, '2023-11-01 08:00:00', 18),	(-18.58, '2023-11-01 08:05:00', 18),	(-18.67, '2023-11-01 08:10:00', 18);

INSERT INTO TBL_ALERTA (titulo, statusAlerta, mensagem, dtAlerta, dtLeitura, fkDado) VALUES 
('Alerta Verde', 'verde', 'Temperatura registrada de -19.23°C em 2023-11-01 08:00:00.', '2023-11-01 08:00:00', '2023-11-01 08:00:00', 1),
('Alerta Vermelho', 'vermelho', 'Temperatura registrada de -11.52°C em 2023-11-01 08:05:00.', '2023-11-01 08:05:00', '2023-11-01 08:05:00', 2),
('Alerta Verde', 'verde', 'Temperatura registrada de -19.58°C em 2023-11-01 08:10:00.', '2023-11-01 08:10:00', '2023-11-01 08:10:00', 3),
('Alerta Vermelho', 'vermelho', 'Temperatura registrada de -12.04°C em 2023-11-01 08:00:00.', '2023-11-01 08:00:00', '2023-11-01 08:00:00', 4),
('Alerta Verde', 'verde', 'Temperatura registrada de -18.91°C em 2023-11-01 08:05:00.', '2023-11-01 08:05:00', '2023-11-01 08:05:00', 5),
('Alerta Vermelho', 'vermelho', 'Temperatura registrada de -11.67°C em 2023-11-01 08:10:00.', '2023-11-01 08:10:00', '2023-11-01 08:10:00', 6),
('Alerta Verde', 'verde', 'Temperatura registrada de -20.00°C em 2023-11-01 08:00:00.', '2023-11-01 08:00:00', '2023-11-01 08:00:00', 7),
('Alerta Verde', 'verde', 'Temperatura registrada de -19.85°C em 2023-11-01 08:05:00.', '2023-11-01 08:05:00', '2023-11-01 08:05:00', 8),
('Alerta Vermelho', 'vermelho', 'Temperatura registrada de -10.20°C em 2023-11-01 08:10:00.', '2023-11-01 08:10:00', '2023-11-01 08:10:00', 9),
('Alerta Amarelo', 'amarelo', 'Temperatura registrada de -16.20°C em 2023-11-01 08:05:00.', '2023-11-01 08:05:00', '2023-11-01 08:05:00', 10);

INSERT INTO TBL_HISTORICO (dataInicio, dataFim, fkUsuario, fkEmpresa, fkVeiculo) VALUES
('2025-05-01 08:00:00', NULL, 1, 1, 1),
('2025-05-01 08:00:00', NULL, 1, 1, 2),
('2025-05-01 08:00:00', NULL, 1, 1, 3),
('2025-05-01 08:00:00', NULL, 1, 1, 4),
('2025-05-01 08:00:00', NULL, 1, 1, 5),
('2025-05-01 08:00:00', NULL, 1, 1, 6),
('2025-05-01 08:00:00', '2025-05-10 18:00:00', 1, 1, 7),
('2025-05-01 08:00:00', '2025-05-10 18:00:00', 1, 1, 8),
('2025-05-01 08:00:00', NULL, 3, 2, 9),
('2025-05-01 08:00:00', NULL, 3, 2, 10),
('2025-05-01 08:00:00', NULL, 5, 3, 11),
('2025-05-01 08:00:00', NULL, 6, 4, 12),
('2025-05-01 08:00:00', NULL, 7, 5, 13);

-- Verificação básica dos dados inseridos
SELECT * FROM TBL_EMPRESA;

SELECT * FROM TBL_USUARIO;

SELECT * FROM TBL_VEICULO; 

SELECT * FROM TBL_SENSOR;

SELECT * FROM TBL_DADO;

SELECT * FROM TBL_ALERTA; 

SELECT * FROM TBL_HISTORICO;


-- -- VIEWS -- --
CREATE VIEW vw_login_page as 
	SELECT 
		idUsuario,
		email,
        senha
	FROM
		TBL_USUARIO;
	
select 
	* 
from 
	vw_login_page 
WHERE
	email = '${email}' AND senha = '${senha}';
-- ---------------------------------------------

    
CREATE VIEW vw_navbar as
	SELECT
		u.nome as usuario,
		e.nome as empresa
	FROM 
		TBL_USUARIO u JOIN TBL_EMPRESA e
			ON e.idEmpresa = u.fkEmpresa;
		
select * from vw_navbar;
-- ---------------------------------------------
            
            
	SELECT 
		COUNT(v.idVeiculo) as Frota,
        (
			select
				COUNT(hs.fkVeiculo)
			FROM
				TBL_EMPRESA es JOIN TBL_VEICULO vs
					ON es.idEmpresa = vs.fkEmpresa
				JOIN TBL_HISTORICO hs
					ON vs.idVeiculo = hs.fkVeiculo
			WHERE
				hs.dataFim is null AND
                hs.fkEmpresa = 1
        ) as Ativo
	FROM
		TBL_USUARIO u JOIN TBL_EMPRESA e
			ON e.idEmpresa = u.fkEmpresa
		JOIN TBL_VEICULO v
			ON e.idEmpresa = v.fkEmpresa
		LEFT JOIN TBL_HISTORICO h
			ON v.idVeiculo = h.fkVeiculo
	WHERE 
		v.fkEmpresa = 1 AND u.idUsuario = 1; 
            
            
	
SELECT 
		*
	FROM
		TBL_USUARIO u JOIN TBL_EMPRESA e
			ON e.idEmpresa = u.fkEmpresa
		JOIN TBL_VEICULO v
			ON e.idEmpresa = v.fkEmpresa
		left JOIN TBL_HISTORICO h
			ON v.idVeiculo = h.fkVeiculo
	WHERE 
		v.fkEmpresa = 1 AND u.idUsuario = 1;     
-- ---------------------------------------------

		
    
    
-- ---------------------------------------------


	SELECT
		e.idEmpresa as idEmpresa,
		v.idVeiculo as idVeiculo,
        v.placa as placa,
        (
			select
				d2.temperatura
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Porta'
            LIMIT 1
		) as porta,
        (
			select
				d2.temperatura
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Centro'
            LIMIT 1
        ) as centro,
        (
			select
				d2.temperatura
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Fundo'
            LIMIT 1
        ) as fundo,
			(
            (
            select
				d2.temperatura
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Porta'
            LIMIT 1
			) +
            (
            select
				d2.temperatura
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Centro'
            LIMIT 1
            ) +
            (
            select
				TRUNCATE(d2.temperatura, 2)
			from
				TBL_DADO d2 join TBL_SENSOR s2
					on s2.idSensor = d2.fkSensor
                join TBL_VEICULO v2
					on v2.idVeiculo = s2.fkVeiculo
			where
                v2.idVeiculo = 1 AND s2.localSensor = 'Fundo'
            LIMIT 1
            )) / 3
         as media
	FROM 
		TBL_USUARIO u JOIN TBL_EMPRESA e
			ON e.idEmpresa = u.fkEmpresa
		JOIN TBL_VEICULO v
			ON e.idEmpresa = v.fkEmpresa
		JOIN TBL_HISTORICO h
			ON v.idVeiculo = h.fkVeiculo;
DROP VIEW vw_alertas;
SELECT * FROM vw_alertas WHERE idEmpresa = 1;


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
       ON sensor.id;

SELECT 
    s.localSensor AS sensor,
    ROUND(d.temperatura, 2) AS temperatura,
    DATE_FORMAT(d.dataHora, '%H:%i') AS horario_leitura,
    d.idDado AS idDado
FROM 
    TBL_DADO d
JOIN 
    TBL_SENSOR s ON d.fkSensor = s.idSensor
WHERE 
    s.fkVeiculo = 1  -- ID do caminhão desejado
    AND d.idDado IN (
        SELECT MAX(d2.idDado)
        FROM TBL_DADO d2
        JOIN TBL_SENSOR s2 ON d2.fkSensor = s2.idSensor
        WHERE s2.fkVeiculo = 1  -- Mesmo ID do caminhão
        GROUP BY s2.localSensor
    )
ORDER BY 
    CASE s.localSensor
        WHEN 'Porta' THEN 1
        WHEN 'Centro' THEN 2
        WHEN 'Fundo' THEN 3
    END;
    
SELECT 
    s.localSensor AS sensor,
    IFNULL(ROUND(d.temperatura, 2), 'N/A') AS temperatura,
    IFNULL(DATE_FORMAT(d.dataHora, '%H:%i'), 'N/A') AS horario_leitura,
    d.idDado AS idDado
FROM 
    (SELECT DISTINCT localSensor FROM TBL_SENSOR WHERE fkVeiculo = 1) s
LEFT JOIN (
    SELECT 
        d.*,
        s.localSensor,
        ROW_NUMBER() OVER (PARTITION BY s.localSensor ORDER BY d.dataHora DESC) AS row_num
    FROM 
        TBL_DADO d
    JOIN 
        TBL_SENSOR s ON d.fkSensor = s.idSensor
    WHERE 
        s.fkVeiculo = 1
) d ON s.localSensor = d.localSensor AND d.row_num <= 10
ORDER BY 
    s.localSensor,
    d.dataHora ASC;
       ON sensor.id;
       
       
SELECT
    veiculo.idVeiculo AS id_veiculo,
    veiculo.placa,
    alerta.dtAlerta, 
    CONCAT('Há ', TIMESTAMPDIFF(MINUTE, alerta.dtAlerta, NOW()) , 'minutos Atrás') AS 'tempo',
    (
        SELECT dadoPorta.temperatura
        FROM TBL_ALERTA AS alertaPorta
        JOIN TBL_DADO AS dadoPorta ON alertaPorta.fkDado = dadoPorta.idDado
        JOIN TBL_SENSOR AS sensorPorta ON dadoPorta.fkSensor = sensorPorta.idSensor
        JOIN TBL_VEICULO AS veiculoPorta ON sensorPorta.fkVeiculo = veiculoPorta.idVeiculo
        WHERE 
            veiculoPorta.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
            AND sensorPorta.localSensor = 'Porta'
            AND alertaPorta.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
    ) AS Porta,
    (
        SELECT dadoCentro.temperatura
        FROM TBL_ALERTA AS alertaCentro
        JOIN TBL_DADO AS dadoCentro ON alertaCentro.fkDado = dadoCentro.idDado
        JOIN TBL_SENSOR AS sensorCentro ON dadoCentro.fkSensor = sensorCentro.idSensor
        JOIN TBL_VEICULO AS veiculoCentro ON sensorCentro.fkVeiculo = veiculoCentro.idVeiculo
        WHERE 
            veiculoCentro.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
            AND sensorCentro.localSensor = 'Centro'
            AND alertaCentro.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
    ) AS Centro,
    (
        SELECT dadoFundo.temperatura
        FROM TBL_ALERTA AS alertaSub
        JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
        JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
        JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
        WHERE 
            veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
            AND sensorFundo.localSensor = 'Fundo'
            AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
    ) AS Fundo,
    (
        SELECT TRUNCATE(AVG(dadoFundo.temperatura),2)
        FROM TBL_ALERTA AS alertaSub
        JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
        JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
        JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
        WHERE 
            veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
            AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
    ) AS Media,
    (
        SELECT 
      	CASE
    				WHEN TRUNCATE(AVG(dadoFundo.temperatura), 2) > -12 THEN 'Vermelho'
    				WHEN TRUNCATE(AVG(dadoFundo.temperatura), 2) > -18 AND TRUNCATE(AVG(dadoFundo.temperatura), 2) <= -12 THEN 'Amarelo'
    			ELSE 'Verde'
				END
        FROM TBL_ALERTA AS alertaSub
        JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
        JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
        JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
        WHERE 
            veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
            AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
    ) AS Status_alerta
   
FROM 
    TBL_ALERTA AS alerta
JOIN TBL_DADO AS dado ON dado.idDado = alerta.fkDado
JOIN TBL_SENSOR AS sensor ON sensor.idSensor = dado.fkSensor
JOIN TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensor.fkVeiculo
GROUP BY veiculo.idVeiculo, alerta.dtAlerta
ORDER BY alerta.dtAlerta DESC LIMIT 3;



SELECT * FROM TBL_ALERTA;
SELECT * FROM TBL_VEICULO;

SELECT idVeiculo, TBL_DADO.temperatura,TBL_ALERTA.statusAlerta, TBL_ALERTA.dtAlerta, TBL_SENSOR.localSensor FROM TBL_ALERTA 
	JOIN TBL_DADO  ON TBL_ALERTA.fkDado = TBL_DADO.idDado 
  JOIN TBL_SENSOR ON TBL_DADO.fkSensor = TBL_SENSOR.idSensor
  JOIN TBL_VEICULO ON TBL_SENSOR.fkVeiculo = TBL_VEICULO.idVeiculo
  WHERE 
  	TBL_VEICULO.idVeiculo = 1 AND TBL_SENSOR.localSensor = 'Fundo' AND TBL_ALERTA.dtAlerta = '2023-11-01 08:10:00';

SELECT idVeiculo, TBL_DADO.temperatura,TBL_ALERTA.statusAlerta, TBL_ALERTA.dtAlerta, TBL_SENSOR.localSensor FROM TBL_ALERTA 
	JOIN TBL_DADO  ON TBL_ALERTA.fkDado = TBL_DADO.idDado 
  JOIN TBL_SENSOR ON TBL_DADO.fkSensor = TBL_SENSOR.idSensor
  JOIN TBL_VEICULO ON TBL_SENSOR.fkVeiculo = TBL_VEICULO.idVeiculo
  WHERE 
  	TBL_VEICULO.idVeiculo = 1 AND TBL_SENSOR.localSensor = 'Centro' AND TBL_ALERTA.dtAlerta = '2023-11-01 08:10:00';
    
 SELECT idVeiculo, TBL_DADO.temperatura,TBL_ALERTA.statusAlerta, TBL_ALERTA.dtAlerta, TBL_SENSOR.localSensor FROM TBL_ALERTA 
	JOIN TBL_DADO  ON TBL_ALERTA.fkDado = TBL_DADO.idDado 
  JOIN TBL_SENSOR ON TBL_DADO.fkSensor = TBL_SENSOR.idSensor
  JOIN TBL_VEICULO ON TBL_SENSOR.fkVeiculo = TBL_VEICULO.idVeiculo
  WHERE 
  	TBL_VEICULO.idVeiculo = 1 AND TBL_SENSOR.localSensor = 'Porta' AND TBL_ALERTA.dtAlerta = '2023-11-01 08:10:00';
    

SELECT 
    d1.dataHora AS  'horario_leitura',
    ROUND(d1.temperatura, 2) AS Porta,
    ROUND(d2.temperatura, 2) AS Centro,
    ROUND(d3.temperatura, 2) AS Fundo,
    ROUND((d1.temperatura + d2.temperatura + d3.temperatura) / 3, 2) AS 'Temperatura Média'
FROM 
    TBL_DADO d1
    JOIN TBL_SENSOR s1 ON d1.fkSensor = s1.idSensor AND s1.localSensor = 'Porta',
    
    TBL_DADO d2
    JOIN TBL_SENSOR s2 ON d2.fkSensor = s2.idSensor AND s2.localSensor = 'Centro',
    
    TBL_DADO d3
    JOIN TBL_SENSOR s3 ON d3.fkSensor = s3.idSensor AND s3.localSensor = 'Fundo'
WHERE
    s1.fkVeiculo = 1 AND
    s2.fkVeiculo = 1 AND
    s3.fkVeiculo = 1
ORDER BY 
    d1.dataHora DESC
LIMIT 1;

SELECT 
    s.localSensor AS sensor,
    ROUND(d.temperatura, 2) AS temperatura,
    DATE_FORMAT(d.dataHora, '%H:%i') AS horario_leitura,
    d.idDado AS idDado,
    (SELECT ROUND(AVG(d2.temperatura), 2)
     FROM TBL_DADO d2
     WHERE d2.idDado IN (
         SELECT MAX(d3.idDado)
         FROM TBL_DADO d3
         JOIN TBL_SENSOR s3 ON d3.fkSensor = s3.idSensor
         WHERE s3.fkVeiculo = 1
         GROUP BY s3.localSensor
     )) AS temperatura_media
FROM
    TBL_DADO d
        JOIN
    TBL_SENSOR s ON d.fkSensor = s.idSensor
WHERE
    s.fkVeiculo = 1
        AND d.idDado IN (SELECT 
            MAX(d2.idDado)
        FROM
            TBL_DADO d2
                JOIN
            TBL_SENSOR s2 ON d2.fkSensor = s2.idSensor
        WHERE
            s2.fkVeiculo = 1
        GROUP BY s2.localSensor)
ORDER BY CASE s.localSensor
    WHEN 'Porta' THEN 1
    WHEN 'Centro' THEN 2
    WHEN 'Fundo' THEN 3
END;

select * from TBL_DADO WHERE 
