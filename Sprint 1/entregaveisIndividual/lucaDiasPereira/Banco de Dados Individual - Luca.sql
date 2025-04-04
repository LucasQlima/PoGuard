CREATE DATABASE projeto;
USE projeto;

CREATE TABLE register_client (
idClient INT PRIMARY KEY AUTO_INCREMENT,
nameClnt VARCHAR (100) NOT NULL,
CNPJ CHAR (18) UNIQUE NOT NULL,
emailClnt VARCHAR (200) UNIQUE NOT NULL,
psswrd VARCHAR (12) NOT NULL,
psswrdConfirm VARCHAR (12) NOT NULL,
CONSTRAINT chkPsswrd CHECK (psswrdConfirm = psswrd)
);
INSERT INTO register_client VALUES
	(default, 'Transportadora Generica A', '74.671.870/0001-29', 'genericaatransport@gmail.com', 'exemplo123', 'exemplo123');

SELECT * FROM register_client WHERE emailClnt LIKE '_e%';

CREATE TABLE register_service (
idService INT PRIMARY KEY AUTO_INCREMENT,
plate CHAR (7) UNIQUE NOT NULL,
vehicleName VARCHAR (100) NOT NULL,
vehicleSize FLOAT NOT NULL,
productName VARCHAR (100) NOT NULL,
idealTemp INT NOT NULL,
sensorName VARCHAR (100) NOT NULL
);

CREATE TABLE sensor_offer (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
sensorName VARCHAR (100) NOT NULL,
sensorType VARCHAR (100) NOT NULL
);