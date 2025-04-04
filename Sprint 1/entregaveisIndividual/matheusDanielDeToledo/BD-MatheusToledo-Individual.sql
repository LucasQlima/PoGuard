use sprint01;

-- tabela de controle interno sobre as empresas que usufruem do serviço
create table empresas (
 id int primary key auto_increment,
 nome_empresa varchar(30),
 ramo_empresa varchar(30),
 duração_contrato decimal(2,1),
 data_incio_contrato date,
 data_fim_contrato date,
 valor_contrato int
);

create table login (
 id int primary key auto_increment,
 login_empresa varchar(15),
 login_funcionario varchar(30),
 senha_empresa varchar(20),
 senha_funcionario varchar(20)
);

create table carro (
 id int primary key auto_increment,
 placa_veiculo varchar(10),
 nome_responsavel varchar(50),
 status_veiculo varchar(20)
 constraint chkStatus check (status_veiculo in ('Ativo', 'Inativo', 'Manutenção'))
);

create table rota (
 local_partida varchar(30),
 local_chegada varchar(30)	
);

create table bau (
 id int primary key auto_increment,
 tipo_bau varchar(20),
 qtd_sensores int,
 carga_bau varchar(30),
 qtdCarga decimal(5,2),
 temperatura_bau float,
 constraint ckhTipo check (tipo_bau in ('Pequeno', 'Médio', 'Grande'))
);

create table sensor (
	id int primary key auto_increment,
    numero_de_serie varchar(10),
    status_sensor varchar(15),
    localizacao_sensor varchar(30),
    constraint chkLocal check (localizacao_sensor in (
    'Porta', 'Ventilação', 'Centro', 'Canto superior esquerdo', 'Canto superior direito',
    'Canto inferior esquerdo', 'Canto inferior direito'
    ))
);

create table produto (
 id int primary key auto_increment,
 nomeProduto varchar(20),
 menor_temperatura decimal(2,1),
 maior_temperatura decimal(2,1)
)