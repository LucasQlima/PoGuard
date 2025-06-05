CREATE DATABASE PoGuard;
USE PoGuard;

CREATE TABLE TBL_EMPRESA (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(18) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone CHAR(13),
    codigoEmpresa CHAR(10) UNIQUE,
    CONSTRAINT chkEmailEmpresa CHECK (email LIKE '%@%')
);

CREATE TABLE TBL_USUARIO (
    idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT pkUsuarioEmpresa PRIMARY KEY (idUsuario , fkEmpresa),
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES TBL_EMPRESA (idEmpresa),
    CONSTRAINT chkEmailUsuario CHECK (email LIKE '%@%')
);

CREATE TABLE TBL_VEICULO (
    idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa CHAR(7) NOT NULL,
    modelo VARCHAR(100),
    fkEmpresa INT,
    CONSTRAINT fkVeiculoEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES TBL_EMPRESA (idEmpresa)
);

CREATE TABLE TBL_SENSOR (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numSerie INT NOT NULL,
    modeloSensor VARCHAR(45) NOT NULL,
    statusSensor VARCHAR(45) NOT NULL,
    localSensor VARCHAR(45) NOT NULL,
    fkVeiculo INT NOT NULL,
    CONSTRAINT fkSensorVeiculo FOREIGN KEY (fkVeiculo)
        REFERENCES TBL_VEICULO (idVeiculo),
    CONSTRAINT statusSensor CHECK (statusSensor IN ('ativo' , 'inativo', 'manutenção')),
    CONSTRAINT localSensor CHECK (localSensor IN ('Fundo' , 'Centro', 'Porta'))
);

CREATE TABLE TBL_DADO (
    idDado INT AUTO_INCREMENT,
    temperatura DECIMAL(4 , 2 ) NOT NULL,
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    PRIMARY KEY (idDado , fkSensor),
    CONSTRAINT fkDadoSensor FOREIGN KEY (fkSensor)
        REFERENCES TBL_SENSOR (idSensor)
);

CREATE TABLE TBL_ALERTA (
    idAlerta INT AUTO_INCREMENT,
    dtAlerta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fkDadoPorta INT,
    fkDadoCentro INT,
    fkDadoFundo INT,
    PRIMARY KEY (idAlerta , fkDadoPorta , fkDadoCentro , fkDadoFundo),
    CONSTRAINT fkAlertaDadoPorta FOREIGN KEY (fkDadoPorta)
        REFERENCES TBL_DADO (idDado),
    CONSTRAINT fkAlertaDadoCentro FOREIGN KEY (fkDadoCentro)
        REFERENCES TBL_DADO (idDado),
    CONSTRAINT fkAlertaDadoFundo FOREIGN KEY (fkDadoFundo)
        REFERENCES TBL_DADO (idDado)
);

CREATE TABLE TBL_HISTORICO (
    idHistorico INT AUTO_INCREMENT,
    dataInicio DATETIME NOT NULL,
    dataFim DATETIME,
    fkUsuario INT,
    fkEmpresa INT,
    fkVeiculo INT,
    CONSTRAINT pksHistorico PRIMARY KEY (idHistorico , fkUsuario , fkEmpresa , fkVeiculo),
    CONSTRAINT fkHistoricoUsuario FOREIGN KEY (fkUsuario)
        REFERENCES TBL_USUARIO (idUsuario),
    CONSTRAINT fkHistoricoEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES TBL_EMPRESA (idEmpresa),
    CONSTRAINT fkHistoricoVeiculo FOREIGN KEY (fkVeiculo)
        REFERENCES TBL_VEICULO (idVeiculo)
);

INSERT INTO TBL_EMPRESA (nome, cnpj, email, telefone, codigoEmpresa) VALUES 
('Transportes Rápidos Ltda', '12.345.678/0001-90', 'contato@transportesrapidos.com', '11-98765-4321', 'TRANS001');

INSERT INTO TBL_USUARIO (nome, email, senha, fkEmpresa) VALUES 
('João Silva', 'joao.silva@transportesrapidos.com', 'js123456', 1);

INSERT INTO TBL_VEICULO (placa, modelo, fkEmpresa) VALUES 
('ABC1D23', 'Volvo FH 540', 1),
('DEF4G56', 'Scania R500', 1),
('DSK3421', 'FH 500', 1),
('HKG9348', 'Scania 770s', 1),
('PBNJ107', 'DAF XF 480', 1),
('GYM97P0', 'Mercedes-Benz Atego 2548', 1),
('ATK1010', 'Volkswagen Meteor 28.480', 1),
('PIN8W33', 'Ford Cargo 2429', 1);

INSERT INTO TBL_SENSOR (numSerie, modeloSensor, statusSensor, localSensor, fkVeiculo) VALUES
-- Veículo 1
(101, 'LM35', 'ativo', 'Porta', 1),
(102, 'LM35', 'ativo', 'Centro', 1),
(103, 'LM35', 'ativo', 'Fundo', 1),
-- Veículo 2
(104, 'LM35', 'ativo', 'Porta', 2),
(105, 'LM35', 'ativo', 'Centro', 2),
(106, 'LM35', 'ativo', 'Fundo', 2),
-- Veículo 3
(107, 'LM35', 'ativo', 'Porta', 3),
(108, 'LM35', 'ativo', 'Centro', 3),
(109, 'LM35', 'ativo', 'Fundo', 3),
-- Veículo 4
(110, 'LM35', 'ativo', 'Porta', 4),
(111, 'LM35', 'ativo', 'Centro', 4),
(112, 'LM35', 'ativo', 'Fundo', 4),
-- Veículo 5
(113, 'LM35', 'ativo', 'Porta', 5),
(114, 'LM35', 'ativo', 'Centro', 5),
(115, 'LM35', 'ativo', 'Fundo', 5),
-- Veículo 6
(116, 'LM35', 'ativo', 'Porta', 6),
(117, 'LM35', 'ativo', 'Centro', 6),
(118, 'LM35', 'ativo', 'Fundo', 6),
-- Veículo 7
(119, 'LM35', 'ativo', 'Porta', 7),
(120, 'LM35', 'ativo', 'Centro', 7),
(121, 'LM35', 'ativo', 'Fundo', 7),
-- Veículo 8
(122, 'LM35', 'ativo', 'Porta', 8),
(123, 'LM35', 'ativo', 'Centro', 8),
(124, 'LM35', 'ativo', 'Fundo', 8);

-- encontrar codigo empresa
SELECT 
    *
FROM
    TBL_EMPRESA
WHERE
    codigoEmpresa = '${codigoEmpresa}';

-- pagina cadastro
INSERT INTO TBL_USUARIO (nome, email, senha, fkEmpresa) VALUES ('${nome}', '${email}', '${senha}', '${fkEmpresa}');

-- pagina login
SELECT 
    idUsuario,
    u.nome AS 'nome',
    u.email AS 'email',
    u.senha AS 'senha',
    e.nome AS 'empresa',
    e.idEmpresa AS 'fkEmpresa'
FROM
    TBL_USUARIO AS u
        JOIN
    TBL_EMPRESA AS e ON e.idEmpresa = u.fkEmpresa
WHERE
    u.email = '${email}'
        AND senha = '${senha}';

-- alerta
-- select 1
SELECT 
    veiculo.idVeiculo AS id_veiculo,
    veiculo.placa,
    alerta.dtAlerta,
    CONCAT('Há ',
            TIMESTAMPDIFF(MINUTE,
                alerta.dtAlerta,
                NOW()),
            ' minutos atrás') AS tempo,
    dadoPorta.temperatura AS Porta,
    dadoCentro.temperatura AS Centro,
    dadoFundo.temperatura AS Fundo,
    TRUNCATE((dadoPorta.temperatura + dadoCentro.temperatura + dadoFundo.temperatura) / 3,
        2) AS Media,
    CASE
        WHEN
            TRUNCATE((dadoPorta.temperatura + dadoCentro.temperatura + dadoFundo.temperatura) / 3,
                2) > - 14
        THEN
            'Crítico'
        WHEN
            TRUNCATE((dadoPorta.temperatura + dadoCentro.temperatura + dadoFundo.temperatura) / 3,
                2) > - 16
                AND TRUNCATE((dadoPorta.temperatura + dadoCentro.temperatura + dadoFundo.temperatura) / 3,
                2) <= - 14
        THEN
            'Alerta'
        ELSE 'Ideal'
    END AS Status_alerta
FROM
    TBL_ALERTA AS alerta
        JOIN
    TBL_DADO AS dadoPorta ON dadoPorta.idDado = alerta.fkDadoPorta
        JOIN
    TBL_SENSOR AS sensorPorta ON sensorPorta.idSensor = dadoPorta.fkSensor
        JOIN
    TBL_DADO AS dadoCentro ON dadoCentro.idDado = alerta.fkDadoCentro
        JOIN
    TBL_SENSOR AS sensorCentro ON sensorCentro.idSensor = dadoCentro.fkSensor
        JOIN
    TBL_DADO AS dadoFundo ON dadoFundo.idDado = alerta.fkDadoFundo
        JOIN
    TBL_SENSOR AS sensorFundo ON sensorFundo.idSensor = dadoFundo.fkSensor
        JOIN
    TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensorPorta.fkVeiculo
WHERE
    veiculo.fkEmpresa = 1
GROUP BY veiculo.idVeiculo , veiculo.placa , alerta.dtAlerta , dadoPorta.temperatura , dadoCentro.temperatura , dadoFundo.temperatura
ORDER BY alerta.dtAlerta DESC
LIMIT 3;

-- select 2
SELECT
        veiculo.idVeiculo AS id_veiculo,
        veiculo.placa,
        alerta.dtAlerta,
        CONCAT('Há ', TIMESTAMPDIFF(MINUTE, alerta.dtAlerta, NOW()), ' minutos atrás') AS tempo,
        dadoPorta.temperatura AS Porta,
        dadoCentro.temperatura AS Centro,
        dadoFundo.temperatura AS Fundo,
        TRUNCATE((
            dadoPorta.temperatura +
            dadoCentro.temperatura +
            dadoFundo.temperatura
        ) / 3, 2) AS Media,
        CASE
            WHEN TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) > -14 THEN 'Crítico'

            WHEN TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) > -16 AND TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) <= -14 THEN 'Alerta'
            ELSE 'Ideal'
        END AS Status_alerta
        FROM
        TBL_ALERTA AS alerta
        JOIN TBL_DADO AS dadoPorta ON dadoPorta.idDado = alerta.fkDadoPorta
        JOIN TBL_SENSOR AS sensorPorta ON sensorPorta.idSensor = dadoPorta.fkSensor
        JOIN TBL_DADO AS dadoCentro ON dadoCentro.idDado = alerta.fkDadoCentro
        JOIN TBL_SENSOR AS sensorCentro ON sensorCentro.idSensor = dadoCentro.fkSensor
        JOIN TBL_DADO AS dadoFundo ON dadoFundo.idDado = alerta.fkDadoFundo
        JOIN TBL_SENSOR AS sensorFundo ON sensorFundo.idSensor = dadoFundo.fkSensor
        JOIN TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensorPorta.fkVeiculo
        WHERE
        veiculo.fkEmpresa = ${fkEmpresa}
        GROUP BY
        veiculo.idVeiculo, veiculo.placa, alerta.dtAlerta,
        dadoPorta.temperatura, dadoCentro.temperatura, dadoFundo.temperatura
        ORDER BY
        alerta.dtAlerta DESC LIMIT 100;

-- select 3
SELECT 
            E.nome AS nome_empresa,
            COUNT(A.idAlerta) AS total_alertas,
            SUM(
                CASE
                    WHEN ((DP.temperatura + DC.temperatura + DF.temperatura) / 3) > -14 THEN 1
                    ELSE 0
                END
            ) AS total_vermelhos
        FROM 
            TBL_ALERTA A
        JOIN TBL_DADO DP ON A.fkDadoPorta = DP.idDado
        JOIN TBL_DADO DC ON A.fkDadoCentro = DC.idDado
        JOIN TBL_DADO DF ON A.fkDadoFundo = DF.idDado
        JOIN TBL_SENSOR SP ON DP.fkSensor = SP.idSensor
        JOIN TBL_VEICULO V ON SP.fkVeiculo = V.idVeiculo
        JOIN TBL_EMPRESA E ON V.fkEmpresa = E.idEmpresa
        WHERE 
            E.idEmpresa = 1  
            AND DATE(A.dtAlerta) = DATE(NOW())
        GROUP BY 
            E.nome;
            
-- dashboard
-- select 1
SELECT 
    v.idVeiculo,
    v.placa,
    recentes.temperatura_porta,
    recentes.datahora_porta,
    recentes.temperatura_centro,
    recentes.datahora_centro,
    recentes.temperatura_fundo,
    recentes.datahora_fundo,
    CASE
        WHEN recentes.idVeiculo IS NOT NULL THEN 'Ativo'
        ELSE 'Inativo'
    END AS status
FROM
    TBL_VEICULO v
        LEFT JOIN
    (SELECT 
        v.idVeiculo,
            MAX(CASE
                WHEN s.localSensor = 'Porta' THEN d.temperatura
            END) AS temperatura_porta,
            MAX(CASE
                WHEN s.localSensor = 'Porta' THEN d.dataHora
            END) AS datahora_porta,
            MAX(CASE
                WHEN s.localSensor = 'Centro' THEN d.temperatura
            END) AS temperatura_centro,
            MAX(CASE
                WHEN s.localSensor = 'Centro' THEN d.dataHora
            END) AS datahora_centro,
            MAX(CASE
                WHEN s.localSensor = 'Fundo' THEN d.temperatura
            END) AS temperatura_fundo,
            MAX(CASE
                WHEN s.localSensor = 'Fundo' THEN d.dataHora
            END) AS datahora_fundo
    FROM
        TBL_VEICULO v
    JOIN TBL_SENSOR s ON v.idVeiculo = s.fkVeiculo
    JOIN TBL_DADO d ON s.idSensor = d.fkSensor
    WHERE
        DATE(d.dataHora) = DATE(NOW())
            AND v.fkEmpresa = 1
            AND d.dataHora >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
            AND (s.fkVeiculo , s.localSensor, d.dataHora) IN (SELECT 
                s2.fkVeiculo, s2.localSensor, MAX(d2.dataHora)
            FROM
                TBL_SENSOR s2
            JOIN TBL_DADO d2 ON s2.idSensor = d2.fkSensor
            WHERE
                DATE(d2.dataHora) = DATE(NOW())
                    AND d2.dataHora >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
            GROUP BY s2.fkVeiculo , s2.localSensor)
    GROUP BY v.idVeiculo) recentes ON v.idVeiculo = recentes.idVeiculo
WHERE
    v.fkEmpresa = 1
ORDER BY status DESC , v.placa;

-- select 2
SELECT 
    v.idVeiculo,
    v.placa,
    MAX(CASE
        WHEN s.localSensor = 'Porta' THEN d.temperatura
    END) AS temperatura_porta,
    MAX(CASE
        WHEN s.localSensor = 'Porta' THEN d.dataHora
    END) AS datahora_porta,
    MAX(CASE
        WHEN s.localSensor = 'Centro' THEN d.temperatura
    END) AS temperatura_centro,
    MAX(CASE
        WHEN s.localSensor = 'Centro' THEN d.dataHora
    END) AS datahora_centro,
    MAX(CASE
        WHEN s.localSensor = 'Fundo' THEN d.temperatura
    END) AS temperatura_fundo,
    MAX(CASE
        WHEN s.localSensor = 'Fundo' THEN d.dataHora
    END) AS datahora_fundo,
    'Ativo' AS status
FROM
    TBL_VEICULO v
        JOIN
    TBL_SENSOR s ON v.idVeiculo = s.fkVeiculo
        JOIN
    TBL_DADO d ON s.idSensor = d.fkSensor
WHERE
    v.fkEmpresa = 1
        AND DATE(d.dataHora) = DATE(NOW())
        AND d.dataHora >= DATE_SUB(NOW(), INTERVAL 10 SECOND)
GROUP BY v.idVeiculo , v.placa
ORDER BY v.placa;

-- pagina caminhao
-- select 1

SELECT 
    s.localSensor AS sensor,
    IFNULL(ROUND(d.temperatura, 2), 'N/A') AS temperatura,
    IFNULL(DATE_FORMAT(d.dataHora, '%H:%i'), 'N/A') AS horario_leitura,
    d.idDado AS idDado
FROM
    (SELECT DISTINCT
        localSensor
    FROM
        TBL_SENSOR
    WHERE
        fkVeiculo = 1) s
        LEFT JOIN
    (SELECT 
        d1.*
    FROM
        TBL_DADO d1
    JOIN TBL_SENSOR s1 ON d1.fkSensor = s1.idSensor
    WHERE
        s1.fkVeiculo = 1
            AND (SELECT 
                COUNT(*)
            FROM
                TBL_DADO d2
            JOIN TBL_SENSOR s2 ON d2.fkSensor = s2.idSensor
            WHERE
                s2.localSensor = s1.localSensor
                    AND s2.fkVeiculo = 1
                    AND d2.dataHora > d1.dataHora) < 10) d ON s.localSensor = (SELECT 
            localSensor
        FROM
            TBL_SENSOR
        WHERE
            idSensor = d.fkSensor
        LIMIT 1)
ORDER BY s.localSensor , d.dataHora ASC;

-- select 2
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

-- select 3
SELECT 
    v.idVeiculo AS id_veiculo,
    v.placa,
    TRUNCATE((dp.temperatura + dc.temperatura + df.temperatura) / 3,
        2) AS media,
    CASE
        WHEN
            TRUNCATE((dp.temperatura + dc.temperatura + df.temperatura) / 3,
                2) > - 14
        THEN
            'Crítico'
        WHEN
            TRUNCATE((dp.temperatura + dc.temperatura + df.temperatura) / 3,
                2) <= - 14
                AND TRUNCATE((dp.temperatura + dc.temperatura + df.temperatura) / 3,
                2) > - 16
        THEN
            'Alerta'
        ELSE 'Ideal'
    END AS status_alerta,
    dp.dataHora AS dtTemperatura
FROM
    TBL_VEICULO AS v
        JOIN
    TBL_SENSOR AS sp ON v.idVeiculo = sp.fkVeiculo
        AND sp.localSensor = 'porta'
        JOIN
    TBL_SENSOR AS sc ON v.idVeiculo = sc.fkVeiculo
        AND sc.localSensor = 'centro'
        JOIN
    TBL_SENSOR AS sf ON v.idVeiculo = sf.fkVeiculo
        AND sf.localSensor = 'fundo'
        JOIN
    (SELECT 
        d.*
    FROM
        TBL_DADO d
    JOIN (SELECT 
        fkSensor, MAX(dataHora) AS maxData
    FROM
        TBL_DADO
    GROUP BY fkSensor) ult ON d.fkSensor = ult.fkSensor
        AND d.dataHora = ult.maxData) AS dp ON sp.idSensor = dp.fkSensor
        JOIN
    (SELECT 
        d.*
    FROM
        TBL_DADO d
    JOIN (SELECT 
        fkSensor, MAX(dataHora) AS maxData
    FROM
        TBL_DADO
    GROUP BY fkSensor) ult ON d.fkSensor = ult.fkSensor
        AND d.dataHora = ult.maxData) AS dc ON sc.idSensor = dc.fkSensor
        JOIN
    (SELECT 
        d.*
    FROM
        TBL_DADO d
    JOIN (SELECT 
        fkSensor, MAX(dataHora) AS maxData
    FROM
        TBL_DADO
    GROUP BY fkSensor) ult ON d.fkSensor = ult.fkSensor
        AND d.dataHora = ult.maxData) AS df ON sf.idSensor = df.fkSensor
WHERE
    v.fkEmpresa = 1
ORDER BY dtTemperatura DESC;


