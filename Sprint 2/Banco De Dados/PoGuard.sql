CREATE DATABASE sprint3;
USE sprint3;

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
  titulo VARCHAR(45) NOT NULL,
  statusAlerta VARCHAR(8) NOT NULL,
  mensagem VARCHAR(400) NOT NULL,
  fkDado INT UNIQUE,
  PRIMARY KEY(idAlerta, fkDado),
  CONSTRAINT chkStatusAlerta CHECK (statusAlerta IN ('verde', 'amarelo', 'vermelho')),
  CONSTRAINT fkAlertaDado FOREIGN KEY (fkDado) REFERENCES TBL_DADO(idDado)
);
