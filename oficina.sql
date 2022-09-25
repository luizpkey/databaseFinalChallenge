
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE oficina;

-- -----------------------------------------------------
-- Table oficina.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`Cliente` ;

CREATE TABLE IF NOT EXISTS oficina.`Cliente` (
  `idCliente` INT AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(18) NULL,
  `contato` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina.`Servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`Servico` ;

CREATE TABLE IF NOT EXISTS oficina.`Servico` (
  `idServico` INT AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `valor` DECIMAL NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina.`OrdemDeServico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`OrdemDeServico` ;

CREATE TABLE IF NOT EXISTS oficina.`OrdemDeServico` (
  `idOrdemDeServico` INT AUTO_INCREMENT,
  `statusOrdemServico` VARCHAR(45) NULL,
  `autorizado` TINYINT NULL,
  `dataEntrega` DATETIME NULL,
  `dataEmissao` DATETIME NULL,
  `valor` DECIMAL NULL,
  `dataEncerramento` DATETIME NULL,
  PRIMARY KEY (`idOrdemDeServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`Pedido` ;

CREATE TABLE IF NOT EXISTS oficina.`Pedido` (
  `idPedido` INT AUTO_INCREMENT,
  `requisicao` VARCHAR(60) NULL,
  `data_solicitacao` DATETIME NULL,
  `idCliente` INT NOT NULL,
  `idOrdemDeServico` INT NULL,
  PRIMARY KEY (`idPedido`, `idCliente`),
  INDEX `fk_Pedido_Cliente_idx` (`idCliente` ASC) ,
  INDEX `fk_Pedido_OrdemDeServico1_idx` (`idOrdemDeServico` ASC) ,
  CONSTRAINT `fk_Pedido_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES oficina.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`EquipeResponsavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`EquipeResponsavel` ;

CREATE TABLE IF NOT EXISTS oficina.`EquipeResponsavel` (
  `idResponsavel` INT AUTO_INCREMENT,
  `nivel` INT NULL,
  `departamento` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`AnaliseDePedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`AnaliseDePedido` ;

CREATE TABLE IF NOT EXISTS oficina.`AnaliseDePedido` (
  `idResponsavel` INT NOT NULL,
  `idPedido` INT NOT NULL,
  PRIMARY KEY (`idResponsavel`, `idPedido`),
  INDEX `fk_Responsavel_has_Pedido_Pedido1_idx` (`idPedido` ASC) ,
  INDEX `fk_Responsavel_has_Pedido_Responsavel1_idx` (`idResponsavel` ASC) ,
  CONSTRAINT `fk_Responsavel_has_Pedido_Responsavel1`
    FOREIGN KEY (`idResponsavel`)
    REFERENCES oficina.`EquipeResponsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Responsavel_has_Pedido_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES oficina.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`Produto` ;

CREATE TABLE IF NOT EXISTS oficina.`Produto` (
  `idProduto` INT AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `valor` DECIMAL NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`ExecucaoOrdemDeServco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`ExecucaoOrdemDeServco` ;

CREATE TABLE IF NOT EXISTS oficina.`ExecucaoOrdemDeServco` (
  `idOrdemDeServico` INT NOT NULL,
  `idResponsavel` INT NOT NULL,
  PRIMARY KEY (`idOrdemDeServico`, `idResponsavel`),
  INDEX `fk_Ordem_de_Servico_has_Responsavel_Responsavel1_idx` (`idResponsavel` ASC),
  INDEX `fk_Ordem_de_Servico_has_Responsavel_Ordem_de_Servico1_idx` (`idOrdemDeServico` ASC),
  CONSTRAINT `fk_Ordem_de_Servico_has_Responsavel_Ordem_de_Servico1`
    FOREIGN KEY (`idOrdemDeServico`)
    REFERENCES oficina.`OrdemDeServico` (`idOrdemDeServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_de_Servico_has_Responsavel_Responsavel1`
    FOREIGN KEY (`idResponsavel`)
    REFERENCES oficina.`EquipeResponsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table oficina.`Mecanico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`Mecanico` ;

CREATE TABLE IF NOT EXISTS oficina.`Mecanico` (
  `codigo` INT AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(40) NULL,
  `especialidade` ENUM('Eletrica', 'Funilaria', 'Estofamento', 'Geral', 'Pesada', 'Eletronica' ) NOT NULL,
  `EquipeResponsavel_idResponsavel` INT NOT NULL,
  PRIMARY KEY (`codigo`, `EquipeResponsavel_idResponsavel`),
  INDEX `fk_Mecanico_EquipeResponsavel1_idx` (`EquipeResponsavel_idResponsavel` ASC),
  CONSTRAINT `fk_Mecanico_EquipeResponsavel1`
    FOREIGN KEY (`EquipeResponsavel_idResponsavel`)
    REFERENCES oficina.`EquipeResponsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table oficina.`Tem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS oficina.`orcamento` ;

CREATE TABLE IF NOT EXISTS oficina.`orcamento` (
  `idOrcamento` INT auto_increment, 
  `idPedido` INT NOT NULL,
  `idServico` INT NULL,
  `idProduto` INT NULL,
  `valorExecucao` DECIMAL NULL,
  PRIMARY KEY (`idOrcamento`, `idPedido` ),
  INDEX `fk_Pedido_has_Servico_Servico1_idx` (`idServico` ASC),
  INDEX `fk_Pedido_has_Servico_Pedido1_idx` (`idPedido` ASC),
  INDEX `fk_Pedido_has_Servico_Produto1_idx` (`idProduto` ASC),
  CONSTRAINT `fk_Pedido_has_Servico_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES oficina.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Servico_Servico1`
    FOREIGN KEY (`idServico`)
    REFERENCES oficina.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Servico_Produto1`
    FOREIGN KEY (`idProduto`)
    REFERENCES oficina.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Insert table oficina.`Cliente`
-- -----------------------------------------------------
INSERT INTO oficina.cliente
(nome, cpf, contato)
VALUES('PEDRO GIOCONDO', '11111111111', '+551312121515')
     ,('ANA MARIOCONDA', '22222222222', '+551313121815')
     ,('ANA LICE'      , '88888888888', '+5513985023030');

-- -----------------------------------------------------
-- Insert table oficina.`Servico`
-- -----------------------------------------------------
INSERT INTO oficina.servico
(descricao, valor)
VALUES('REVISAO', 300)
     ,('CALIBRAGEM DA INJECAO ELETRONICA', 300)
     ,('DESMONTAGEM MOTOR', 500)
     ,('MONTAGEM MOTOR', 400)
     ,('RETOQUE NA PINTURA', 200)
     ,('REFORMA BANCOS', 300);


-- -----------------------------------------------------
-- Table oficina.`Produto`
-- -----------------------------------------------------
INSERT INTO oficina.produto
(descricao, valor)
VALUES('PECA DO MOTOR', 800)
     ,('BATERIA', 500)
     ,('ESTOFAMENTOS', 1000)
     ,('LATA DE TINTA', 50)
     ,('CENTRAL MULTIMIDIA', 800)
     ,('OLEO', 130)
     ,('FLUIDO DE FREIO', 70);

-- -----------------------------------------------------
-- Insert table oficina.`EquipeResponsavel`
-- -----------------------------------------------------
INSERT INTO oficina.EquipeResponsavel
(nivel, departamento, nome)
VALUES(1, 'ELETRONICA', 'ELETRO')
     ,(2, 'ELETRICA', 'ENERGIC')
     ,(3, 'GERAL', 'GERAL')
     ,(4, 'ACABAMENTO', 'ACABA');

-- -----------------------------------------------------
-- Insert table oficina.`Mecanico`
-- -----------------------------------------------------
INSERT INTO oficina.mecanico
(nome, endereco, especialidade, EquipeResponsavel_idResponsavel)
VALUES('JOAOZINHO', 'RUA GRAVATAI 50', 'Geral', (select idResponsavel  from EquipeResponsavel where nome ="GERAL"))
     ,('PEDRINHO', 'RUA INDEPENDENCIA 99', 'Funilaria', (select idResponsavel  from EquipeResponsavel where nome ="ACABA"))
     ,('MIKE', 'RUA DOS ABELHEIROS 70', 'Eletronica', (select idResponsavel  from EquipeResponsavel where nome ="ELETRO"))
     ,('MENDONCA', 'AV BRASIL, 1515', 'Eletrica', (select idResponsavel  from EquipeResponsavel where nome ="ENERGIC"))
     ,('ZÉ DA MOLA', 'TRAVESSA INDAIATUBA 30', 'Estofamento', (select idResponsavel  from EquipeResponsavel where nome ="ACABA"));

-- -----------------------------------------------------
-- Insert table oficina.`Pedido`
-- -----------------------------------------------------
INSERT INTO oficina.Pedido
(requisicao, data_solicitacao, idCliente, idOrdemDeServico)
VALUES('REVISAO', '2021-05-15', (select idCliente from cliente where cpf = '11111111111'), 0)
     ,('REVISAO', '2021-10-16', (select idCliente from cliente where cpf = '11111111111'), 0)
     ,('ALINHAMENTO', '2021-10-20', (select idCliente from cliente where cpf = '88888888888'), 0)
     ,('REVISAR INJECAO', '2022-01-06', (select idCliente  from cliente where cpf = '22222222222'), 0)
     ,('TROCA DE BATERIA', '2022-01-07', (select idCliente from cliente where cpf = '22222222222'), 0)
     ,('REVISAO', '2022-01-10', (select idCliente from cliente where cpf = '22222222222'), 0)
     ,('REVISAO', '2022-03-15', (select idCliente from cliente where cpf = '11111111111'), 0)
     ,('REFORMA ESTOFAMENTO', '2022-04-20', (select idCliente from cliente where cpf = '88888888888'), 0)
     ,('REVISAO', '2022-04-22', (select idCliente from cliente where cpf = '88888888888'), 0);


-- -----------------------------------------------------
-- Insert table oficina.`AnaliseDePedido`
-- -----------------------------------------------------
INSERT INTO oficina.AnaliseDePedido
(idResponsavel, idPedido)
VALUES( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-05-15' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'ALINHAMENTO' and data_solicitacao = '2021-10-20' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 1 ), ( select idPedido from Pedido where requisicao = 'REVISAR INJECAO' and data_solicitacao = '2022-01-06' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 2 ), ( select idPedido from Pedido where requisicao = 'TROCA DE BATERIA' and data_solicitacao = '2022-01-07' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-01-10' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-03-15' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 4 ), ( select idPedido from Pedido where requisicao = 'REFORMA ESTOFAMENTO' and data_solicitacao = '2022-04-20' ) )
     ,( ( select idResponsavel from EquipeResponsavel where nivel = 3 ), ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22' ) );

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-05-15' )
                                , idServico = ( select idServico from servico where descricao = 'REVISAO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-05-15' )
                                , idProduto = ( select idProduto from produto where descricao = 'OLEO' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
 ( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-05-15' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAO' and data_solicitacao = '2021-05-15';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';


-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16' )
                                , idServico = ( select idServico from servico where descricao = 'REVISAO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16' )
                                , idProduto = ( select idProduto from produto where descricao = 'OLEO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16' )
                                , idProduto = ( select idProduto from produto where descricao = 'FLUIDO DE FREIO' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAO' and data_solicitacao = '2021-10-16';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAR INJECAO' and data_solicitacao = '2022-01-06' )
                                , idServico = ( select idServico from servico where descricao = 'CALIBRAGEM DA INJECAO ELETRONICA' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAR INJECAO' and data_solicitacao = '2022-01-06' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAR INJECAO' and data_solicitacao = '2022-01-06';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'TROCA DE BATERIA' and data_solicitacao = '2022-01-07' )
                                , idProduto = ( select idProduto from produto where descricao = 'BATERIA' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, Pedido.data_solicitacao, Pedido.data_solicitacao from Pedido where requisicao = 'TROCA DE BATERIA' and data_solicitacao = '2022-01-07')
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'TROCA DE BATERIA' and data_solicitacao = '2022-01-07';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-01-10' )
                                , idServico = ( select idServico from servico where descricao = 'REVISAO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-01-10' )
                                , idProduto = ( select idProduto from produto where descricao = 'OLEO' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-01-10')
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAO' and data_solicitacao = '2022-01-10';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-03-15' )
                                , idServico = ( select idServico from servico where descricao = 'REVISAO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-03-15' )
                                , idProduto = ( select idProduto from produto where descricao = 'OLEO' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-03-15' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAO' and data_solicitacao = '2022-03-15';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REFORMA ESTOFAMENTO' and data_solicitacao = '2022-04-20' )
                                , idServico = ( select idServico from servico where descricao = 'REFORMA BANCOS' )
                                , idProduto = ( select idProduto from produto where descricao = 'ESTOFAMENTOS' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REFORMA ESTOFAMENTO' and data_solicitacao = '2022-04-20' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REFORMA ESTOFAMENTO' and data_solicitacao = '2022-04-20';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Insert table oficina.`Orcamento`/oficina.`OrdemDeServico`
-- -----------------------------------------------------

INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22' )
                                , idServico = ( select idServico from servico where descricao = 'REVISAO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22' )
                                , idProduto = ( select idProduto from produto where descricao = 'OLEO' );
INSERT INTO oficina.orcamento set idPedido = ( select idPedido from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22' )
                                , idProduto = ( select idProduto from produto where descricao = 'FLUIDO DE FREIO' );

INSERT INTO oficina.OrdemDeServico
(statusOrdemServico, autorizado, dataEntrega, dataEmissao )
( SELECT 'AGUARDANDO ACEITE', 0, DATE_ADD(Pedido.data_solicitacao, INTERVAL  FLOOR(RAND()*(5-(1)+1)+1) DAY), Pedido.data_solicitacao from Pedido where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22' )
;

UPDATE Pedido set idOrdemDeServico = ( select idOrdemDeServico from OrdemDeServico where statusOrdemServico='AGUARDANDO ACEITE')
where requisicao = 'REVISAO' and data_solicitacao = '2022-04-22';

update OrdemDeServico set statusOrdemServico='ORCADO' where statusOrdemServico='AGUARDANDO ACEITE';

-- -----------------------------------------------------
-- Update
-- -----------------------------------------------------

UPDATE orcamento  
left join servico using (idServico)
left join produto using (idProduto)
SET valorExecucao = Coalesce( produto.valor, 0 ) + Coalesce( servico.valor, 0 )
where Coalesce( valorExecucao, 0) = 0;

update OrdemDeServico
inner join Pedido using( idOrdemDeServico )
inner join ( select idPedido, Sum( orcamento.valorExecucao ) as valorTotal from  orcamento group by idPedido) ORC using( idPedido )
SET valor=ORC.valorTotal , statusOrdemServico='ACEITA', autorizado = 1
where statusOrdemServico =  'ORCADO';

update OrdemDeServico 
SET 
dataEncerramento=DATE_ADD(dataEntrega, INTERVAL FLOOR(RAND()*(3-(-2)+1)-2)  DAY)
where coalesce( dataEncerramento, '1900-01-01') <'1970-01-01';

INSERT INTO oficina.ExecucaoOrdemDeServco
(idOrdemDeServico, idResponsavel)
( select  Pedido.idOrdemDeServico, AnaliseDePedido.idResponsavel from OrdemDeServico
   inner join Pedido using (idOrdemDeServico)
   inner join  AnaliseDePedido on AnaliseDePedido.idPedido = Pedido.idPedido );

select * from cliente 
left join Pedido using (idCliente)
left join OrdemDeServico using(idOrdemDeServico);