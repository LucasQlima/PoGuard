create database Sprint1;
use Sprint1;

CREATE TABLE login (
    idLogin INT PRIMARY KEY AUTO_INCREMENT,
    empresa VARCHAR(100) not null,
    cnpj VARCHAR(15) UNIQUE not null,
    senha VARCHAR(50) unique not null
);

select * from login;
drop table login;

INSERT INTO login (empresa, cnpj, senha) VALUES
('Tech Innovations', '85412397654', 'a1B2c3D4'),
('Green Solutions', '67043918572', '3XyZ7kT9'),
('Future Enterprises', '53790168423', 'm5N0bL8w'),
('Creative Labs', '24687593014', 'Aq2wE4Rt'),
('Skyline Technologies', '32846590128', 'u6VtN9Yz'),
('Quantum Systems', '79163502479', 'h7P8qRf0'),
('Digital Horizons', '85412793056', 'Wq3B0Lk8'),
('Global Networks', '96248751033', 'd2J4Km1V'),
('NextGen Solutions', '76341258974', 'Gz9P0lQa'),
('Innovative Minds', '57281034629', 'Yh7Tr0Ls'),
('Bright Future', '43058921604', 'J9b8ZxRe'),
('Urban Concepts', '51978360217', 's1G4LqN7'),
('Dynamic Ventures', '38620497582', 'Wz8A2hKm'),
('TechnoWave', '74026519830', 'o9V5bD3J'),
('Advanced Dynamics', '91576034812', 'Q0rZ7HpN');

select empresa, cnpj from login where cnpj like '%4'; 
select empresa, cnpj from login where empresa like '%s%'; 

create table carros(
 id int primary key auto_increment,
 idEmpresa int not null,
 placaDoCarro varchar(11) unique not null,
 numeroDeSensores int ,
 statusDoCarro varchar(50) not null,
 constraint chkCarro 
 check (statusDoCarro in('Ativo','Desativado','Manutenção'))
 
);

drop table carros;
select * from carros;

INSERT INTO carros (idEmpresa,placaDoCarro, numeroDeSensores, statusDoCarro) VALUES
(1,'ABC-1234', 4, 'Ativo'),
(1,'DEF-5678', 2, 'Desativado'),
(1,'GHI-9101', 6, 'Manutenção'),
(2,'JKL-1122', 3, 'Ativo'),
(2,'MNO-3344', 5, 'Desativado'),
(3,'PQR-5566', 7, 'Manutenção'),
(4,'STU-7788', 4, 'Ativo'),
(5,'VWX-9900', 2, 'Ativo'),
(6,'YZA-2233', 3, 'Desativado'),
(7,'BCD-4455', 8, 'Manutenção'),
(8,'EFG-6677', 5, 'Ativo'),
(9,'HIJ-8899', 3, 'Desativado'),
(10,'KLM-0011', 6, 'Manutenção'),
(11,'NOP-2233', 4, 'Ativo'),
(12,'QRS-4455', 2, 'Desativado');

select 

create table sensores(
id int primary key auto_increment,
idCarros int not null,
statusDoSensor varchar(30) not null,
constraint chkSensor
 check (statusDoSensor in('Ativo','Desativado','Manutenção'))

);
select * from sensores;

INSERT INTO sensores (idCarros, statusDoSensor) VALUES 
(1, 'Ativo'),
(2, 'Desativado'),
(3, 'Manutenção'),
(4, 'Ativo'),
(5, 'Ativo'),
(6, 'Desativado'),
(7, 'Manutenção'),
(7, 'Manutenção'),
(7, 'Manutenção'),
(7, 'Manutenção'),
(8, 'Ativo'),
(9, 'Desativado'),
(10, 'Ativo'),
(11, 'Manutenção'),
(12, 'Ativo'),
(13, 'Desativado'),
(14, 'Ativo'),
(14, 'Ativo'),
(14, 'Ativo'),
(15, 'Manutenção');

select * from sensores;

select idCarros, statusDoSensor from sensores where idCarros = 14;






 -- colocar alerta, melhorar login, melhorar id carros, criar tabela usuarios, alimentos, 
 -- telefone empresa,


