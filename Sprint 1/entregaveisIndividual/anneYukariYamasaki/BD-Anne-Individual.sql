CREATE DATABASE TransporteRefrigerado;

USE TransporteRefrigerado;

CREATE TABLE Veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) NOT NULL,
    modelo VARCHAR(50),
    capacidade DECIMAL(10, 2) NOT NULL,  
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,  
    temperatura_min DECIMAL(5, 2) NOT NULL,  
    temperatura_max DECIMAL(5, 2) NOT NULL,  
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Sensores (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,  
    localizacao VARCHAR(100),  
    modelo_sensor VARCHAR(50),
    data_instalacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS LeiturasTemperatura (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT,  
    temperatura DECIMAL(5, 2) NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT, 
    tipo_alerta VARCHAR(50), 
    mensagem TEXT,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Cargas (
    id_carga INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,  
    id_produto INT,  
    valor_carga DECIMAL(10, 2) NOT NULL,  
    peso DECIMAL(10, 2),  
    data_inicial DATETIME
);

INSERT INTO Veiculos (placa, modelo, capacidade) 
VALUES ('ABC-1234', 'Ford Cargo 815', 20.50);

INSERT INTO Produtos (nome, tipo, temperatura_min, temperatura_max)
VALUES ('Carne Bovina', 'Carne', -2.00, 4.00);

INSERT INTO Sensores (id_veiculo, localizacao, modelo_sensor)
VALUES (1, 'Frente do baú', 'LM35');

INSERT INTO LeiturasTemperatura (id_sensor, temperatura)
VALUES (1, 3.5);

INSERT INTO Alertas (id_sensor, tipo_alerta, mensagem)
VALUES (1, 'Temperatura fora dos limites', 'Temperatura excedeu o limite máximo de 4°C');

INSERT INTO Cargas (id_veiculo, id_produto, valor_carga, peso, data_inicial)
VALUES (1, 1, 5000.00, 1500.00, '2025-03-10 08:00:00');
