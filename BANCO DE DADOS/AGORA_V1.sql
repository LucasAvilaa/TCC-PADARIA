/* 

INF2GM_REDEDEPADARIAS_EQUIPE01 (PROJETO ÁGORA)
TURMA: INF2GM

TEMA: REDE DE PADARIAS
EQUIPE: 01

COMPONENTES:

DIOGO FERREIRA - N° 05
ISABELA MENEZES - N° 11
JOÃO VITOR NOGUEIRA - N°12
LUCAS ÁVILA - N°16

*/
USE MASTER;
GO

DROP DATABASE AGORA_V1_0;
GO

CREATE DATABASE AGORA_V1_0;
GO

USE AGORA_V1_0;
GO

/* OBSERVAÇÕES: NESSE DOCUMENTO HÁ A PRESENÇA DE QUERYS ALTERNATIVAS QUE FORAM COMENTADAS. A RAZÃO DESSAS LINHAS É DEVIDO O FATO QUE EU ESCREVI E RODEI 
ESSES CÓDIGOS INICIALMENTE NO MYSQL, QUE UTILIZA ALGUMAS SYNTAXES DIFERENTES DO SQLSERVER QUE É O SGBD UTILIZADO NAS AULAS DO LABORATÓRIO. EU MANTIVE ESSAS LINHAS
POR CONVENIÊNCIA, POIS É MAIS FÁCIL PARA EU PODER REALIZAR TESTES.*/


/* TABELAS -- ESTABELECIMENTO  -----------------------------------------------------------------  */
/* DDL ---------------------------------------------------------------------------------------------------------------------------- */

CREATE TABLE HORARIO_FUNC (
    HORARIO_FUNC_PK INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    HORARIO_FUNC VARCHAR(50) 
);
GO


CREATE TABLE ENDERECO_EST(	 
	COD_ENDERECO_EST INT IDENTITY(1,1) PRIMARY KEY NOT NULL , 
	CEP CHAR(9) NOT NULL,
    CIDADE VARCHAR(20) NOT NULL,
    BAIRRO VARCHAR(50) NOT NULL
);
GO

CREATE TABLE ESTABELECIMENTO (
     COD_ESTABELECIMENTO INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
     NOME_ESTABELECIMENTO VARCHAR(20) NOT NULL ,
	 FK_HORARIO_FUNC INT,
     FK_COD_ENDERECO_EST INT,  
	 CONSTRAINT FK_COD_ENDERECO_EST FOREIGN KEY (FK_COD_ENDERECO_EST) REFERENCES ENDERECO_EST(COD_ENDERECO_EST),
	 CONSTRAINT FK_HORARIO_FUNC FOREIGN KEY (FK_HORARIO_FUNC) REFERENCES HORARIO_FUNC(HORARIO_FUNC_PK)
);
GO


/* INSERTS ENDEREÇO ESTABELECIMENTO    */
   
INSERT INTO ENDERECO_EST (CEP, CIDADE, BAIRRO)
VALUES ('1234-5678', 'BARUERI', 'JARDIM BELVAL');
GO

INSERT INTO ENDERECO_EST (CEP, CIDADE, BAIRRO)
VALUES ('1234-5677', 'BARUERI', 'JARDIM SILVEIRA');
GO

INSERT INTO ENDERECO_EST (CEP, CIDADE, BAIRRO)
VALUES ('1234-5676', 'BARUERI', 'JARDIM IRACEMA');
GO


/* INSERTS HORARIO FUNCIONAMENTO    */
INSERT INTO HORARIO_FUNC (HORARIO_FUNC)
VALUES ('08:00 - 18:00');
GO
INSERT INTO HORARIO_FUNC (HORARIO_FUNC)
VALUES ('06:10 - 13:10');
GO
INSERT INTO HORARIO_FUNC (HORARIO_FUNC)
VALUES ('09:10 - 21:30');
GO


/* INSERTS ESTABELECIMENTO    */

INSERT INTO ESTABELECIMENTO (NOME_ESTABELECIMENTO, FK_COD_ENDERECO_EST, FK_HORARIO_FUNC)
VALUES ('PADARIA_AGORA', 1, 1); 
GO
INSERT INTO ESTABELECIMENTO (NOME_ESTABELECIMENTO, FK_COD_ENDERECO_EST, FK_HORARIO_FUNC)
VALUES ('PADARIA_DEPOIS', 2, 3); 
GO
INSERT INTO ESTABELECIMENTO (NOME_ESTABELECIMENTO,FK_COD_ENDERECO_EST, FK_HORARIO_FUNC)
VALUES ('PADARIA_ANTES', 3, 2); 
GO
 
 
/* CONSUMIDOR */


CREATE TABLE ENDERECO_CONS(
    PK_COD_END INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    RUA VARCHAR(30) NOT NULL,
    CIDADE VARCHAR(20) NOT NULL,
    BAIRRO VARCHAR(50) NOT NULL,
    NUMERO VARCHAR(4) NOT NULL,
    COMPLEMENTO VARCHAR(15) NOT NULL,
	FK_ID_CONSUMIDOR INT,
);
GO

CREATE TABLE TELEFONE_CONS(
    PK_TELEFONE INT IDENTITY(1,1) NOT NULL PRIMARY KEY,   
    NUM_TELEFONE VARCHAR(14) NOT NULL,
	FK_ID_CONSUMIDOR INT,
);
GO

CREATE TABLE CONSUMIDOR(  
	PK_ID_CONSUMIDOR INT  PRIMARY KEY  IDENTITY(1,1)NOT NULL,
	NOME VARCHAR(30) NOT NULL,
    SEXO CHAR NOT NULL,    
    EMAIL VARCHAR(50),    
    USUARIO VARCHAR(16),
    SENHA VARCHAR(20),    
    FK_COD_END INT, 
	FK_TELEFONE INT,
	CONSTRAINT FK_COD_END FOREIGN KEY (FK_COD_END) REFERENCES ENDERECO_CONS(PK_COD_END),
	CONSTRAINT FK_TELEFONE FOREIGN KEY (FK_TELEFONE) REFERENCES TELEFONE_CONS(PK_TELEFONE),
);
GO

ALTER TABLE TELEFONE_CONS ADD CONSTRAINT FK_TEL_ID_CONSUMIDOR
FOREIGN KEY(FK_ID_CONSUMIDOR) REFERENCES CONSUMIDOR(PK_ID_CONSUMIDOR)
GO

ALTER TABLE ENDERECO_CONS ADD CONSTRAINT FK_END_ID_CONSUMIDOR
FOREIGN KEY(FK_ID_CONSUMIDOR) REFERENCES CONSUMIDOR(PK_ID_CONSUMIDOR)
GO


INSERT INTO ENDERECO_CONS (RUA, CIDADE, BAIRRO, NUMERO, COMPLEMENTO)
VALUES ('RUA SABIÁ', 'JANDIRA', 'FÁTIMA', '07', 'CASA'); 
GO
INSERT INTO ENDERECO_CONS (RUA, CIDADE, BAIRRO, NUMERO, COMPLEMENTO)
VALUES ('RUA GALINHA', 'BARUERI', 'BELVAL', '123', 'CASA'); 
GO
INSERT INTO ENDERECO_CONS (RUA, CIDADE, BAIRRO, NUMERO, COMPLEMENTO)
VALUES ('RUA PINGUIM', 'BARUERI', 'SILVEIRA', '222', 'APARTAMENTO'); 
GO
INSERT INTO CONSUMIDOR (NOME, SEXO, EMAIL, USUARIO, SENHA, FK_COD_END)
VALUES ('ARMANDO SILVEIRA', 'M', 'ABACATE1997@GMAIL.COM', NULL, NULL, 1);
GO
INSERT INTO CONSUMIDOR (NOME, SEXO, EMAIL, USUARIO, SENHA, FK_COD_END)
VALUES ('MARIANA SILVA OLIVEIRA', 'F', NULL, NULL, NULL, 2);
GO
INSERT INTO CONSUMIDOR (NOME, SEXO, EMAIL, USUARIO, SENHA, FK_COD_END)
VALUES ('ARMANDO SILVEIRA', 'M', NULL, 'RUNESCAPE2007BR', '39102384', 3);
GO

INSERT INTO TELEFONE_CONS (NUM_TELEFONE, FK_ID_CONSUMIDOR)
VALUES ('(11) 4002-8922', 1);
GO
INSERT INTO TELEFONE_CONS (NUM_TELEFONE, FK_ID_CONSUMIDOR)
VALUES ('(11) 1111-1111', 2);
GO
INSERT INTO TELEFONE_CONS (NUM_TELEFONE, FK_ID_CONSUMIDOR)
VALUES ('(11) 2322-2222', 2);
GO
INSERT INTO TELEFONE_CONS (NUM_TELEFONE, FK_ID_CONSUMIDOR)
VALUES ('(11) 2341-4821', 3);
GO



/*---------------------------------------------------------------*/

CREATE TABLE FUNCIONARIO (
    ID_FUNC INT IDENTITY(1,1) PRIMARY KEY NOT NULL,  
    NOME VARCHAR(20) NOT NULL,
    SEXO CHAR NOT NULL,
    DATA_DE_NASCIMENTO DATETIME NOT NULL,
    CARGO VARCHAR(20) NOT NULL,
    SALARIO DECIMAL(10,2) NOT NULL,
    CPF CHAR(11) NOT NULL,
    EMAIL VARCHAR(50),
    USUARIO VARCHAR(20),
    FK_ESTABELECIMENTO_COD_ESTABELECIMENTO INT NOT NULL
);
GO

CREATE TABLE TELEFONE_FUNC (
	TELEFONE_PK INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NUM_TELEFONE CHAR(13),    
    FK_ID_FUNC INT NOT NULL
);
GO
ALTER TABLE TELEFONE_FUNC ADD CONSTRAINT FK_ID_FUNC
    FOREIGN KEY (FK_ID_FUNC)
    REFERENCES FUNCIONARIO(ID_FUNC);
 GO
ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK_ESTABELECIMENTO_COD_ESTABELECIMENTO
    FOREIGN KEY (FK_ESTABELECIMENTO_COD_ESTABELECIMENTO)
    REFERENCES ESTABELECIMENTO(COD_ESTABELECIMENTO);
	GO
INSERT INTO FUNCIONARIO (NOME, SEXO, DATA_DE_NASCIMENTO, CARGO, SALARIO, CPF, EMAIL, USUARIO, FK_ESTABELECIMENTO_COD_ESTABELECIMENTO)
VALUES ('KIARA RODRIGUES', 'F', '21/12/1991', 'ATENDENTE', '1200.00','12345678932', NULL, NULL, 1 );
GO
INSERT INTO FUNCIONARIO (NOME, SEXO, DATA_DE_NASCIMENTO, CARGO, SALARIO, CPF, EMAIL, USUARIO, FK_ESTABELECIMENTO_COD_ESTABELECIMENTO)
VALUES ('BERNADO ROMANO', 'M', '12/02/1990', 'PADEIRO', '1699.59', '12345134522', NULL, NULL, 1);
GO
INSERT INTO FUNCIONARIO (NOME, SEXO, DATA_DE_NASCIMENTO, CARGO, SALARIO, CPF, EMAIL, USUARIO, FK_ESTABELECIMENTO_COD_ESTABELECIMENTO)
VALUES ('MARIANA BÁSICA', 'F', '19/10/1980', 'PADEIRO', '1699.59', '4214523121', 'MARIANABASSSLK@HOTMAIL.COM', NULL, 3);
GO
INSERT INTO TELEFONE_FUNC (NUM_TELEFONE, FK_ID_FUNC)
VALUES ('1130012934', 1);
GO
INSERT INTO TELEFONE_FUNC (NUM_TELEFONE, FK_ID_FUNC)
VALUES ('1153234123', 3);
GO
INSERT INTO TELEFONE_FUNC (NUM_TELEFONE, FK_ID_FUNC)
VALUES ('1123412442', 2);
GO


/* FORNECEDOR  -------------------------------------------------------------------------- */



CREATE TABLE ENDERECO_FORNECEDOR (
    COD_ENDERECO INT IDENTITY(1,1) PRIMARY KEY NOT NULL , 
 	CEP CHAR(9) NOT NULL,
    CIDADE VARCHAR(20) NOT NULL,
    BAIRRO VARCHAR(50) NOT NULL,
	FK_ID_FORN INT, 
);
GO
CREATE TABLE FORNECEDOR (
    PK_ID_FORN INT IDENTITY(1,1) PRIMARY KEY NOT NULL , 
    NOME VARCHAR(25),
    SEXO CHAR,
    CPF VARCHAR(11),
    FK_COD_ENDERECO INT,
	CONSTRAINT FK_COD_ENDERECO FOREIGN KEY (FK_COD_ENDERECO)REFERENCES ENDERECO_FORNECEDOR (COD_ENDERECO)
);
GO

ALTER TABLE ENDERECO_FORNECEDOR ADD CONSTRAINT FK_ID_FORN
FOREIGN KEY (FK_ID_FORN)REFERENCES FORNECEDOR(PK_ID_FORN)
GO

INSERT INTO ENDERECO_FORNECEDOR (CEP, CIDADE, BAIRRO)
VALUES ('12345 678', 'CARAPICUIBA', 'JARDIM ANA ESTELA');
GO
INSERT INTO ENDERECO_FORNECEDOR (CEP, CIDADE, BAIRRO)
VALUES ('54321 678', 'JANDIRA', 'BROTINHO');
GO
INSERT INTO ENDERECO_FORNECEDOR (CEP, CIDADE, BAIRRO)
VALUES ('34521 523', 'BARUERI', 'ALDEIA DA SERRA');
GO
/*------------*/

INSERT INTO FORNECEDOR (NOME, SEXO, CPF, FK_COD_ENDERECO)
VALUES ('ANTÔNIO ALVEZ', 'M', '313525242', 1);
GO
INSERT INTO FORNECEDOR (NOME, SEXO, CPF, FK_COD_ENDERECO)
VALUES ('JOÃO CORNOTARO', 'M', '911235862', 2);
GO
INSERT INTO FORNECEDOR (NOME, SEXO, CPF, FK_COD_ENDERECO)
VALUES ('MAICON POLO', 'M', '716525732', 3);
GO
/*--------------------------------------------------------*/

CREATE TABLE COMANDA (
    NUM_COMANDA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    
    ID_COMANDA INT NOT NULL,
    VALOR_TOTAL DECIMAL(10,2),
    FK_COD_ESTABELECIMENTO_C INT,
	CONSTRAINT FK_COD_ESTABELECIMENTO_C FOREIGN KEY (FK_COD_ESTABELECIMENTO_C)REFERENCES ESTABELECIMENTO(COD_ESTABELECIMENTO)
);
GO

   /*-----------------------------------------------------*/
INSERT INTO COMANDA (VALOR_TOTAL, ID_COMANDA, FK_COD_ESTABELECIMENTO_C)
VALUES (25.30, 1 ,1);
GO
INSERT INTO COMANDA (VALOR_TOTAL, ID_COMANDA, FK_COD_ESTABELECIMENTO_C)
VALUES (36.90, 1 ,2);
GO
INSERT INTO COMANDA (VALOR_TOTAL, ID_COMANDA, FK_COD_ESTABELECIMENTO_C)
VALUES (41.00, 3 ,2);
 GO 
    /*-----------------------------------------------------*/
CREATE TABLE PRODUTO (
	COD_PRODUTO INT IDENTITY PRIMARY KEY NOT NULL,
    NOME VARCHAR(85),    
    VALOR_UNIT DECIMAL(10,2),
    MARCA VARCHAR(15),
    PRODUTO_TIPO VARCHAR(20)
);
GO

INSERT INTO PRODUTO (NOME, VALOR_UNIT, MARCA, PRODUTO_TIPO)
VALUES ('PÃO DE QUEIJO', 3.50, NULL, 'ALIMENTO');
GO
INSERT INTO PRODUTO (NOME, VALOR_UNIT, MARCA, PRODUTO_TIPO)
VALUES ('REFRIGERANTE COCA-COLA TRADICIONAL GARRAFA 2L', 6.80, 'COCA-COLA', 'BEBIDA');
GO
INSERT INTO PRODUTO (NOME, VALOR_UNIT, MARCA, PRODUTO_TIPO)
VALUES ('EMPADA DE FRANGO', 5.50, NULL, 'ALIMENTO');
GO

CREATE TABLE GERENCIADOR_ESTABELECIMENTO (
    ID_GERENCIADOREST INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
	NOME VARCHAR(45),
    SEXO CHAR,
    DATA_NASC VARCHAR(10),
    SALARIO DECIMAL(10,2),   
    FK_COD_ESTABELECIMENTO_G INT,
	CONSTRAINT FK_COD_ESTABELECIMENTO_G FOREIGN KEY (FK_COD_ESTABELECIMENTO_G)REFERENCES ESTABELECIMENTO(COD_ESTABELECIMENTO)
);
GO
  
    INSERT INTO GERENCIADOR_ESTABELECIMENTO (NOME, SEXO, DATA_NASC, SALARIO, FK_COD_ESTABELECIMENTO_G)
    VALUES ('HERMES SANTOS', 'M', '1987/05/30', 3900.00, '1');
    GO
    INSERT INTO GERENCIADOR_ESTABELECIMENTO (NOME, SEXO, DATA_NASC, SALARIO, FK_COD_ESTABELECIMENTO_G)
    VALUES ('MARIANNE CRISTO GONÇALVES', 'F', '1987/11/04', 3959.99, '2');
    GO
    INSERT INTO GERENCIADOR_ESTABELECIMENTO (NOME, SEXO, DATA_NASC, SALARIO, FK_COD_ESTABELECIMENTO_G)
    VALUES ('CHRISTIAN OLIVEIRA SILVEIRA', 'M', '1990/03/09', 3300.00, '3');
    GO
CREATE TABLE ESTOQUE_PRODUTO (
    COD_ESTOQUE INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
    QUANTIDADE INT,    
    FK_COD_PRODUTO INT,
    FK_COD_ESTABELECIMENTO_P INT
	CONSTRAINT FK_COD_ESTABELECIMENTO_P FOREIGN KEY (FK_COD_ESTABELECIMENTO_P)REFERENCES ESTABELECIMENTO (COD_ESTABELECIMENTO),
	CONSTRAINT FK_COD_PRODUTO FOREIGN KEY (FK_COD_PRODUTO)REFERENCES PRODUTO (COD_PRODUTO)
);
GO

    INSERT INTO ESTOQUE_PRODUTO (QUANTIDADE, FK_COD_PRODUTO, FK_COD_ESTABELECIMENTO_P)
    VALUES(18, 1, 1);
	GO
    INSERT INTO ESTOQUE_PRODUTO (QUANTIDADE, FK_COD_PRODUTO, FK_COD_ESTABELECIMENTO_P)
    VALUES(8, 2, 1);
	GO
    INSERT INTO ESTOQUE_PRODUTO (QUANTIDADE, FK_COD_PRODUTO, FK_COD_ESTABELECIMENTO_P)
    VALUES(4, 3, 2);
	GO
     INSERT INTO ESTOQUE_PRODUTO (QUANTIDADE, FK_COD_PRODUTO, FK_COD_ESTABELECIMENTO_P)
    VALUES(3, 2, 2);
    GO

/*-------------------------------------*/
CREATE TABLE PEDIDO (
    NUM_PEDIDO INT IDENTITY(1,1) PRIMARY KEY, 
    DATA_PEDIDO DATE,
    NOME_PRODUTO VARCHAR(35),
    QUANTIDADE INT,
    VALOR_UNIT DECIMAL(10,2),
    VALOR_TOTAL DECIMAL(10,2),
    FK_ID_CONSUMIDOR_P INT,
	CONSTRAINT FK_ID_CONSUMIDOR_P FOREIGN KEY (FK_ID_CONSUMIDOR_P)REFERENCES CONSUMIDOR(PK_ID_CONSUMIDOR)
);
GO        
        INSERT INTO PEDIDO (DATA_PEDIDO, NOME_PRODUTO, QUANTIDADE, VALOR_UNIT, FK_ID_CONSUMIDOR_P)
        VALUES ('12/08/2019', 'PÃO DE QUEIJO', 8, 3.50, 1);
      GO
	    INSERT INTO PEDIDO (DATA_PEDIDO, NOME_PRODUTO, QUANTIDADE, VALOR_UNIT, FK_ID_CONSUMIDOR_P)
        VALUES ('16/09/2019', 'EMPADA DE FRANGO', 1, 5.50, 1);
        GO
		INSERT INTO PEDIDO (DATA_PEDIDO, NOME_PRODUTO, QUANTIDADE, VALOR_UNIT, FK_ID_CONSUMIDOR_P)
        VALUES ('23/08/2019', 'EMPADA DE FRANGO', 3, 5.50, 2);
        GO
		UPDATE PEDIDO SET VALOR_TOTAL = QUANTIDADE * VALOR_UNIT WHERE NUM_PEDIDO >= 0;
		

/* ---------------------------- */
 
 
 
 