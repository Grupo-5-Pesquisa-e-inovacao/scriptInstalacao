CREATE USER 'aidmin'@'%' IDENTIFIED BY 'senhaDificil235813';
GRANT ALL PRIVILEGES ON *.* TO 'aidmin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;


CREATE DATABASE CamelTech;
USE CamelTech;

-- TABELA provedora
CREATE TABLE provedora (
  idProvedora INT PRIMARY KEY auto_increment,
  razaoSocial VARCHAR(45),
  cnpj VARCHAR(14));
  
  INSERT INTO provedora (razaoSocial, cnpj) 
VALUES
('Camel Tech Cloud Solutions Ltda.', '12345678901234'),
('Tech Data Serviços de Tecnologia Ltda.', '56789012345678'),
('Data Center Solutions Ltda.', '90123456781234');


-- TABELA unidadeProvedora
CREATE TABLE unidadeProvedora (
  idUnidadeProvedora INT PRIMARY KEY auto_increment,
  nomeUnidade VARCHAR(45),
  cep CHAR(8),
  rua VARCHAR(45),
  complemento VARCHAR(45),
  numero VARCHAR(45),
  fkProvedora INT NOT NULL,
  constraint fkunidProv foreign key(fkProvedora) references provedora(idProvedora));
  
  INSERT INTO unidadeProvedora (nomeUnidade, cep, rua, complemento, numero, fkProvedora)
VALUES
('Unidade São Paulo', '01234567', 'Av. Paulista', 'Andar 10', '123', 1),
('Unidade Rio de Janeiro', '23456789', 'Rua Copacabana', 'Sala 301', '456', 2),
('Unidade Belo Horizonte', '34567890', 'Av. Contorno', 'Bloco B', '789', 3);

-- TABELA tipoUsuario
CREATE TABLE tipoUsuario(
idTipoUsuario int primary key auto_increment,
tipoUsuario VARCHAR(45)
);

  INSERT INTO tipoUsuario (tipoUsuario)
VALUES
('Administrador'),
('Usuário Padrão');
  
-- Tabela usuario  
CREATE TABLE usuario(
idUsuario int primary key auto_increment,
nome VARCHAR(45),
cpf VARCHAR(16),
email VARCHAR(50),
senha VARCHAR(45),
fkProvedora int,
constraint fkProvRepresentante foreign key(fkProvedora) references
 provedora(idProvedora),
fkTipoUsuario int,
constraint fktipoUser foreign key (fkTipousuario) references tipoUsuario(idTipoUsuario)  ON DELETE CASCADE,
fkUnidade int,
constraint fkUnid foreign key(fkUnidade) references unidadeProvedora(idUnidadeProvedora)
);


INSERT INTO usuario (nome, cpf, email, senha, fkTipoUsuario,fkUnidade,fkProvedora)
VALUES
('João Silva', '123.456.789-01', 'joao@email.com', 'senha123', 1,null,1),
('Maria Oliveira', '234.567.890-12', 'maria@email.com', 'senha456', 2,2,null),
('Carlos Santos', '345.678.901-23', 'carlos@email.com', 'senha789', 2,3,null);

-- TABELA servidor
CREATE TABLE servidor (
  idServidor INT PRIMARY KEY AUTO_INCREMENT,
  nomeResponsavel VARCHAR(45),
  numeroRegistro VARCHAR(45),
  frequenciaIdealProcessador FLOAT,
  capacidadeRam INT,
  maxUsoRam INT,
  capacidadeDisco INT,
  maxUsoDisco INT,
  velocidadeDeRede FLOAT,
  fkUsuario INT NOT NULL,
CONSTRAINT fkUserUnid FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario) ON DELETE CASCADE
);

SELECT numeroRegistro FROM servidor WHERE fkUsuario = 2;

-- Inserção na tabela servidor
INSERT INTO servidor (
  nomeResponsavel,
  numeroRegistro,
  frequenciaIdealProcessador,
  capacidadeRam,
  maxUsoRam,
  capacidadeDisco,
  maxUsoDisco,
  velocidadeDeRede,
  fkUsuario
) VALUES (
  'João Silva',
  'SRV001',
  3.5,
  32,
  80,
  1024,
  614,
  1,
  3
);

INSERT INTO servidor (
  nomeResponsavel,
  numeroRegistro,
  frequenciaIdealProcessador,
  capacidadeRam,
  maxUsoRam,
  capacidadeDisco,
  maxUsoDisco,
  velocidadeDeRede,
  fkUsuario
) VALUES (
  'Maria Oliveira',
  'SRV002',
  2.8,
  16,
  70,
  512,
  256,
  100,
  3
);

INSERT INTO servidor (
  nomeResponsavel,
  numeroRegistro,
  frequenciaIdealProcessador,
  capacidadeRam,
  maxUsoRam,
  capacidadeDisco,
  maxUsoDisco,
  velocidadeDeRede,
  fkUsuario
) VALUES (
  'Carlos Santos',
  'SRV003',
  3.0,
  64,
  90,
  2048,
  1536,
  10000,
  2
);




-- TABELA tipoComponente
CREATE TABLE tipoComponente (
  idtipoComponente INT PRIMARY KEY auto_increment,
  tipo VARCHAR(45));
  INSERT INTO tipoComponente (tipo) VALUES
('RAM'),
('Disco'),
('Frequência'),
('Rede');

-- TABELA tipoDado
CREATE TABLE tipoDado (
  idtipoDado INT PRIMARY KEY auto_increment,
  tipoDado VARCHAR(45));
  INSERT INTO tipoDado (tipoDado) VALUES
('Uso de RAM'),
('Uso de Disco'),
('Frequência do Processador'),
('Velocidade de Rede');


-- TABELA configuracao
CREATE TABLE configuracao (
  idConfiguracao INT auto_increment,
  fkServidor INT NOT NULL,
  fktipoComponente INT NOT NULL,
  PRIMARY KEY (idConfiguracao, fkServidor, fktipoComponente) ,
  FOREIGN KEY (fkServidor) REFERENCES servidor(idServidor) ON DELETE CASCADE,
  FOREIGN KEY (fktipoComponente) REFERENCES tipoComponente(idtipoComponente)
);


INSERT INTO configuracao values
(1,1,1), -- RAM
(2,1,2), -- DISCO
(3,1,3), -- Frequência
(4,1,4), -- REDE

(5,2,1), -- RAM
(6,2,2), -- DISCO
(7,2,3), -- Frequência
(8,2,4), -- REDE

(9,3,1), -- RAM 
(10,3,2), -- DISCO
(11,3,3), -- Frequência
(12,3,4); -- REDE



  select * from configuracao;

-- TABELA dadosCapturados
CREATE TABLE dadosCapturados (
  iddadosCapturados INT PRIMARY KEY auto_increment,
  dadoCapturado Float,
  dtHora DATETIME,
  fkConfiguracao INT,
  constraint fkConfigCap foreign key(fkConfiguracao) references configuracao(idConfiguracao) ON DELETE CASCADE,
  fkTipoDado INT,
  constraint fkTipoDadoCap foreign key(fkTipoDado) references tipoDado(idTipoDado));
  
 
