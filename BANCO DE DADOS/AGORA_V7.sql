/*
	O ESTOQUE NÃO PODE FICAR NEGATIVO	
	ADICIONAR PAIS NA TABELA ENDERECO
*/

USE MASTER;
GO

DROP DATABASE AGORA_V7
GO

CREATE DATABASE AGORA_V7;
GO

USE AGORA_V7;

CREATE TABLE TB_FORNECEDORES(
    ID_FORN UNIQUEIDENTIFIER PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(50),
    CNPJ VARCHAR(20) UNIQUE,
	ATIVO BIT,
	DATA_CADASTRO DATETIME,
); 

CREATE TABLE TB_PRODUTOS(
    ID_PRODUTO INT PRIMARY KEY IDENTITY(1,1),
    ID_FORN_PROD UNIQUEIDENTIFIER,
    NOME_PRODUTO VARCHAR(50),
	DESCRICAO_PRODUTO VARCHAR(100),
	CATEGORIA VARCHAR(30),
    VALOR_UNI_COMPRA DECIMAL(6,2),
    VALOR_UNI_VENDA DECIMAL(6,2), 
	DATA_CADASTRO DATETIME,
--	ATIVO BIT,
	CONSTRAINT ID_FORN_PROD FOREIGN KEY (ID_FORN_PROD) REFERENCES TB_FORNECEDORES(ID_FORN),
); 
	
CREATE TABLE TB_ESTABELECIMENTOS(
    ID_ESTAB UNIQUEIDENTIFIER PRIMARY KEY ,
    CNPJ VARCHAR(20) UNIQUE,
    RAZAO_SOCIAL VARCHAR(50),
	DATA_CADASTRO DATETIME,
);	 

CREATE TABLE TB_HIERARQUIA(
	ID_HIERARQUIA INT PRIMARY KEY IDENTITY(1,1),
	CARGO VARCHAR(30)
); 
			INSERT INTO TB_HIERARQUIA VALUES('ADMINISTRADOR')
			INSERT INTO TB_HIERARQUIA VALUES('GERENTE') 
			INSERT INTO TB_HIERARQUIA VALUES('CAIXA')
			INSERT INTO TB_HIERARQUIA VALUES('BALCONISTA')
			INSERT INTO TB_HIERARQUIA VALUES('CLIENTE')
  
CREATE TABLE TB_LOGIN(
	ID_LOGIN INT PRIMARY KEY IDENTITY(1,1),
	ID_HIERARQUIA INT, 
	USUARIO VARCHAR(60) UNIQUE NOT NULL,
	SENHA VARCHAR(30) NOT NULL,
	CONSTRAINT ID_HIERARQUIA FOREIGN KEY (ID_HIERARQUIA) REFERENCES TB_HIERARQUIA(ID_HIERARQUIA),
);

CREATE TABLE TB_CLIENTES(
    ID_CLI UNIQUEIDENTIFIER PRIMARY KEY ,
    NOME VARCHAR(20),
	SOBRENOME VARCHAR(30),
	RG	VARCHAR(13), 
	CPF VARCHAR(15) UNIQUE,
	DT_NASC DATETIME,
    SEXO CHAR(1) DEFAULT 'M',
	ID_LOGIN INT, 
	ATIVO BIT,
	DATA_CADASTRO DATETIME,
	CONSTRAINT ID_LOGIN_CLI FOREIGN KEY (ID_LOGIN) REFERENCES TB_LOGIN(ID_LOGIN)
); 
CREATE TABLE TB_FUNCIONARIOS(
	ID_FUNC UNIQUEIDENTIFIER PRIMARY KEY, 
	NOME VARCHAR(20),
	SOBRENOME VARCHAR(30),	
	RG VARCHAR(12),
	CPF VARCHAR(14) UNIQUE,
	DT_NASC DATETIME, 
    SEXO CHAR(1)DEFAULT 'M', 
	CARGO VARCHAR(20),
	ID_LOGIN INT, 
	ATIVO BIT,
	DATA_CADASTRO DATETIME,
	CONSTRAINT ID_LOGIN_FUN FOREIGN KEY (ID_LOGIN) REFERENCES TB_LOGIN(ID_LOGIN) 
); 

CREATE TABLE TB_PRINCIPAL_PESSOA(
    ID_GERAL INT PRIMARY KEY IDENTITY(1,1),
    ID_ESTAB UNIQUEIDENTIFIER,  
    ID_FUNC UNIQUEIDENTIFIER,  
    ID_CLI UNIQUEIDENTIFIER, 
	ID_FORN UNIQUEIDENTIFIER,  
	CONSTRAINT ID_ESTAB FOREIGN KEY (ID_ESTAB) REFERENCES TB_ESTABELECIMENTOS(ID_ESTAB),
	CONSTRAINT ID_FUNC FOREIGN KEY (ID_FUNC) REFERENCES TB_FUNCIONARIOS(ID_FUNC),
	CONSTRAINT ID_CLI FOREIGN KEY (ID_CLI) REFERENCES TB_CLIENTES(ID_CLI),
	CONSTRAINT ID_FORN FOREIGN KEY (ID_FORN) REFERENCES TB_FORNECEDORES(ID_FORN),
); 

CREATE TABLE TB_COMANDA(
    ID_COMANDA INT PRIMARY KEY,
	STATUS_COMANDA CHAR(1) DEFAULT 'D'-- ATIVO (A); DESATIVADO (D); PAGO (P). USADO PARA SABER SE A COMANDA FOI PAGA
);
	INSERT INTO TB_COMANDA(ID_COMANDA) VALUES (9847);
	INSERT INTO TB_COMANDA(ID_COMANDA) VALUES (6050);
	INSERT INTO TB_COMANDA(ID_COMANDA) VALUES (4480);
	INSERT INTO TB_COMANDA(ID_COMANDA) VALUES (7885);
	INSERT INTO TB_COMANDA(ID_COMANDA) VALUES (3245);
		
CREATE TABLE TB_LISTA_PRODUTOS(
    ID_COMPRA INT PRIMARY KEY IDENTITY (1000,1), 
    ID_COMANDA_LISTA INT, 
    ID_PROD_LISTA INT,
    QUANTIDADE INT, 
	DATA_COMPRA DATETIME,
	DATA_SAIDA DATETIME,
	CONSTRAINT ID_PROD_LISTA FOREIGN KEY (ID_PROD_LISTA) REFERENCES TB_PRODUTOS(ID_PRODUTO),
	CONSTRAINT ID_COMANDA_LISTA FOREIGN KEY (ID_COMANDA_LISTA) REFERENCES TB_COMANDA(ID_COMANDA),
);

CREATE TABLE TB_ESTOQUE( 
    ID_ESTOQUE INT PRIMARY KEY IDENTITY(1000,1),
    ID_PROD_ESTOQ INT,  
    QUANTIDADE INT,
	DATA_ENTRADA DATETIME,
    DATA_VENCIMENTO DATETIME,
	CONSTRAINT ID_PROD_ESTOQ FOREIGN KEY (ID_PROD_ESTOQ) REFERENCES TB_PRODUTOS(ID_PRODUTO), 
); 

CREATE TABLE TB_CONTAS_RECEBER(
    ID_RECEBER INT PRIMARY KEY IDENTITY(1,1),
    ID_COMANDA_RECEBER INT,
	METODO_PAGAMENTO VARCHAR(2), --CARTAO(C), DINHEIRO(D), CARTAO/DINHEIRO(CD) 
	DINHEIRO DECIMAL(7,2),
	DEBITO   DECIMAL(7,2),
	CREDITO  DECIMAL (7,2), 
	DATA_COMPRA DATETIME, 
	DATA_PREVISTA_RECEBER DATETIME,
	CONSTRAINT ID_COMANDA_RECEBER FOREIGN KEY (ID_COMANDA_RECEBER) REFERENCES TB_COMANDA(ID_COMANDA)
);

CREATE TABLE TB_CONTATO(
    ID_CONTATO INT PRIMARY KEY IDENTITY(1,1),    
    ID_GERAL_TEL INT, 
    NUMERO VARCHAR(14),
    EMAIL VARCHAR(50)
	CONSTRAINT ID_GERAL_TEL FOREIGN KEY (ID_GERAL_TEL) REFERENCES TB_PRINCIPAL_PESSOA(ID_GERAL),
);
 
CREATE TABLE TB_ENDERECO(
    ID_END INT IDENTITY(1,1) PRIMARY KEY,
    ID_GERAL_END INT NOT NULL,
	CEP		CHAR(10),
	RUA		VARCHAR(100),
	NUMERO	INT,
	BAIRRO	VARCHAR(30),
	ESTADO  VARCHAR(20),
	CIDADE  VARCHAR(30),
	CONSTRAINT ID_GERAL_END FOREIGN KEY (ID_GERAL_END) REFERENCES TB_PRINCIPAL_PESSOA(ID_GERAL),
);

CREATE TABLE TB_COMPRAS(
    ID_COMPRA INT PRIMARY KEY IDENTITY(1000,1), 
    STATUS CHAR(1), --PENDENTE(P), CONFIRMADO(C), FINALIZADO(F)+
	DATA_CRIADA DATETIME,
	DATA_FINALIZADA DATETIME,
); 

CREATE TABLE TB_COMPRA_PRODUTO(
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_COMPRA_PRODUTO INT,
	ID_PRODUTO INT, 
	QUANTIDADE INT,
	CONSTRAINT ID_COMPRA_PRODUTO FOREIGN KEY (ID_COMPRA_PRODUTO) REFERENCES TB_COMPRAS(ID_COMPRA),
	CONSTRAINT ID_PRODUTO FOREIGN KEY (ID_PRODUTO) REFERENCES TB_PRODUTOS(ID_PRODUTO),
); 

CREATE TABLE TB_CONTAS_PAGAR(
    ID_PAGAR INT PRIMARY KEY IDENTITY(1000,1),
    ID_COMPRA INT,  
	DATA_VENCIMENTO DATETIME, 
	CONSTRAINT ID_COMPRA FOREIGN KEY (ID_COMPRA) REFERENCES TB_COMPRAS(ID_COMPRA),
    -- VALOR PAGAR = SOMA DO VALOR UNITARIO * QUANTIDADE DE CADA LINHA DA COMPRA
    -- ARRUMAR
)
GO

/*========================================================================
  ========================================================================
					FUNCTION RETORNA ID_GERAL	
  =======================================================================
  =======================================================================*/
   
CREATE FUNCTION PROCURA_ID_GERAL (@CPF_CNPJ VARCHAR(20)) 
RETURNS INT
AS
BEGIN 
	DECLARE @ID_GERAL INT

		IF (@CPF_CNPJ) IN (SELECT CPF FROM TB_FUNCIONARIOS)
			BEGIN
				SET @ID_GERAL = (SELECT ID_GERAL
								 FROM TB_PRINCIPAL_PESSOA	
								INNER JOIN 
										TB_FUNCIONARIOS
								ON 
										TB_PRINCIPAL_PESSOA.ID_FUNC = TB_FUNCIONARIOS.ID_FUNC
								WHERE CPF = @CPF_CNPJ)
			END
			
		ELSE IF (@CPF_CNPJ) IN (SELECT CPF FROM TB_CLIENTES)
			BEGIN
				SET @ID_GERAL = (SELECT ID_GERAL
								 FROM TB_PRINCIPAL_PESSOA	
								 INNER JOIN 
									TB_CLIENTES
								  ON 
								    TB_PRINCIPAL_PESSOA.ID_CLI = TB_CLIENTES.ID_CLI
								 WHERE CPF = @CPF_CNPJ)
				END
		ELSE IF (@CPF_CNPJ) IN (SELECT CNPJ FROM TB_FORNECEDORES)
			BEGIN
				SET @ID_GERAL = (SELECT ID_GERAL
								 FROM TB_PRINCIPAL_PESSOA	
								 INNER JOIN 
									TB_FORNECEDORES
								  ON 
								    TB_PRINCIPAL_PESSOA.ID_FORN = TB_FORNECEDORES.ID_FORN
								 WHERE CNPJ = @CPF_CNPJ)
			END
		ELSE IF (@CPF_CNPJ) IN (SELECT CNPJ FROM TB_ESTABELECIMENTOS)
			BEGIN
				SET @ID_GERAL = (SELECT ID_GERAL
								 FROM TB_PRINCIPAL_PESSOA	
								 INNER JOIN 
									TB_ESTABELECIMENTOS
								  ON 
								    TB_PRINCIPAL_PESSOA.ID_ESTAB = TB_ESTABELECIMENTOS.ID_ESTAB
								 WHERE CNPJ = @CPF_CNPJ)
				END
			RETURN @ID_GERAL
END
GO 

/*========================================================================
  ========================================================================
							PROCEDURES
  =======================================================================
  =======================================================================*/

CREATE PROCEDURE PROC_VENDA_CLIENTE
	@ACAO CHAR(1), -- INSERIR(I), EXCLUIR(E), PAGAR(P) 
	@COMANDA INT, 
	@ID_PRODUTO INT,
	@QUANTIDADE INT,
	@METODO_PAGAMENTO VARCHAR(2), 
	@DINHEIRO DECIMAL(7,2),
	@DEBITO   DECIMAL(7,2),
	@CREDITO  DECIMAL (7,2)
AS
	BEGIN 		
		DECLARE @STATUS_ATUAL CHAR(1) = (SELECT STATUS_COMANDA
											FROM TB_COMANDA
											WHERE ID_COMANDA = @COMANDA )
		IF(@ACAO = 'I')
			BEGIN
			-- SISTEMA VERIFICA SE ESTA DESATIVADO
			IF (@STATUS_ATUAL = 'D')
				BEGIN
					UPDATE TB_COMANDA
					SET STATUS_COMANDA = 'A' -- ATUALIZA PARA ATIVADO
					WHERE ID_COMANDA = @COMANDA
					
					INSERT INTO TB_LISTA_PRODUTOS(ID_PROD_LISTA, -- INSERE OS PRODUTOS NA LISTA
												  ID_COMANDA_LISTA,
												  QUANTIDADE, 
												  DATA_COMPRA)
												  
					VALUES
							(@ID_PRODUTO,
							 @COMANDA,
							 @QUANTIDADE,
							 GETDATE())
				END
		
			-- SOMENTE INSERIR OS ITENS, NÃO PRECISA ALTERAR O STATUS
			ELSE
				BEGIN		
					-- SE O PRODUTO ESTIVER NA COMANDA, SOMENTE MODIFICAR A QUANTIDADE
					IF @ID_PRODUTO IN (SELECT ID_PROD_LISTA
									   FROM  TB_LISTA_PRODUTOS
									   WHERE ID_COMANDA_LISTA = @COMANDA) 
						BEGIN
							UPDATE TB_LISTA_PRODUTOS
							SET QUANTIDADE = QUANTIDADE + @QUANTIDADE
							WHERE ID_PROD_LISTA = @ID_PRODUTO
								
						END
					ELSE
						BEGIN
						-- CASO NAO ESTEJA, ELE ADICIONA
							INSERT INTO TB_LISTA_PRODUTOS(ID_PROD_LISTA, -- INSERE OS PRODUTOS NA LISTA
												  ID_COMANDA_LISTA,
												  QUANTIDADE )
												  
					VALUES
							(@ID_PRODUTO,
							 @COMANDA,
							 @QUANTIDADE)
						END		   
				  END
			END

		ELSE IF(@ACAO = 'E')
				BEGIN
					DELETE FROM TB_LISTA_PRODUTOS WHERE ID_PROD_LISTA = @ID_PRODUTO
				END

		ELSE IF(@ACAO = 'P') 
				BEGIN
					IF(@STATUS_ATUAL != 'D')
						BEGIN				
						UPDATE TB_COMANDA -- ALTERA O STATUS PARA DESATIVADO
						SET STATUS_COMANDA = 'D'
						WHERE ID_COMANDA = @COMANDA	

						UPDATE TB_LISTA_PRODUTOS
						SET DATA_SAIDA = GETDATE()
						WHERE ID_COMANDA_LISTA = @COMANDA

						INSERT INTO TB_CONTAS_RECEBER
						VALUES (@COMANDA,
								@METODO_PAGAMENTO,
								@DINHEIRO,
								@DEBITO,
								@CREDITO,
								GETDATE(),
								(CASE 
									WHEN @METODO_PAGAMENTO = 'D' -- DINHEIRO
									THEN GETDATE()

									WHEN @METODO_PAGAMENTO = 'C'  -- CARTAO
									THEN GETDATE() + 30

									WHEN @METODO_PAGAMENTO = 'CD'  -- CARTAO/DINHEIRO
									THEN GETDATE() + 30
								 END
									) 
								)

						DECLARE PRODUTO_CURSOR CURSOR
						FOR SELECT ID_PROD_LISTA, QUANTIDADE
							FROM TB_LISTA_PRODUTOS
							WHERE ID_COMANDA_LISTA = @COMANDA

						OPEN PRODUTO_CURSOR
						FETCH NEXT FROM PRODUTO_CURSOR 
						INTO @ID_PRODUTO,
							 @QUANTIDADE

						WHILE @@FETCH_STATUS = 0 -- SUBTRAI DO ESTOQUE A QUANTIDADE DE PRODUTO COMPRADO
							BEGIN 
								UPDATE TB_ESTOQUE
								SET QUANTIDADE = QUANTIDADE - @QUANTIDADE

								WHERE ID_PROD_ESTOQ = @ID_PRODUTO 

								FETCH NEXT FROM PRODUTO_CURSOR INTO @ID_PRODUTO,
																	@QUANTIDADE
							END
						CLOSE PRODUTO_CURSOR
						DEALLOCATE PRODUTO_CURSOR	
					END
				END
		RETURN @COMANDA 
	END 
GO  

CREATE PROCEDURE PROC_COMPRA_ESTAB
	@ACAO VARCHAR(2),
	@ID_COMPRA INT,
	@ID_PRODUTO INT,	
	@QUANTIDADE INT
AS
--	DECLARE @VALOR_UNIT DECIMAL(5,2) = (SELECT VALOR_UNI_COMPRA FROM TB_PRODUTOS WHERE ID_PRODUTO = @ID_PRODUTO)
	BEGIN
		IF(@ACAO = 'IC') -- 'INSERIR COMPRA' NA COMPRA
			BEGIN 
				INSERT INTO TB_COMPRAS VALUES('P', GETDATE(), NULL)
				DECLARE @ID_INSERIR_COMPRA INT = (SELECT TOP 1 ID_COMPRA FROM TB_COMPRAS ORDER BY ID_COMPRA DESC)
				INSERT INTO TB_COMPRA_PRODUTO VALUES (@ID_INSERIR_COMPRA, @ID_PRODUTO, @QUANTIDADE)	
			END
		ELSE IF(@ACAO = 'II') -- 'ISERIR ITENS' NA COMPRA
			BEGIN
				IF(@ID_PRODUTO) IN (SELECT ID_PRODUTO FROM TB_COMPRA_PRODUTO WHERE ID_COMPRA_PRODUTO = @ID_COMPRA) -- SE O ITEM EXISTE, SOMA
					BEGIN 
						UPDATE TB_COMPRA_PRODUTO
						SET QUANTIDADE += @QUANTIDADE
						WHERE ID_COMPRA_PRODUTO =  @ID_COMPRA
						   AND ID_PRODUTO = @ID_PRODUTO
					END
				ELSE -- SENÃO ACRESCENTA
					BEGIN					
						INSERT INTO TB_COMPRA_PRODUTO VALUES (@ID_COMPRA, @ID_PRODUTO, @QUANTIDADE)
					END
			END
		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_COMPRA_PRODUTO
				SET ID_PRODUTO = @ID_PRODUTO,
					QUANTIDADE = @QUANTIDADE
				WHERE ID_COMPRA_PRODUTO = @ID_COMPRA
			END
		ELSE IF(@ACAO = 'C')
			BEGIN
				UPDATE TB_COMPRAS
				SET STATUS = 'C'
				WHERE ID_COMPRA = @ID_COMPRA
			END

		ELSE IF(@ACAO = 'EI') -- EXCLUIR ITENS
			BEGIN
				DELETE FROM TB_COMPRA_PRODUTO WHERE ID_COMPRA_PRODUTO = @ID_COMPRA 
												AND ID_PRODUTO = @ID_PRODUTO
			END
		ELSE IF(@ACAO = 'EC') -- EXCLUIR COMPRAS
			BEGIN
				DELETE FROM TB_COMPRA_PRODUTO WHERE ID_COMPRA_PRODUTO = @ID_COMPRA
				DELETE FROM TB_COMPRAS  WHERE ID_COMPRA = @ID_COMPRA
			END
	END
GO 

CREATE PROCEDURE PROC_CRUD_LOGIN
	@ACAO CHAR(1),
	@ID_LOGIN INT,
	@USUARIO VARCHAR(60),
	@SENHA VARCHAR(30) 
AS
 
	BEGIN
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_LOGIN (USUARIO,SENHA) VALUES (@USUARIO, @SENHA)		
			END

		ELSE IF(@ACAO = 'A')
			BEGIN			 
				UPDATE TB_LOGIN
				SET USUARIO = @USUARIO,
					SENHA = @SENHA
				WHERE ID_LOGIN = @ID_LOGIN
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_LOGIN WHERE ID_LOGIN = @ID_LOGIN
			END
	END
GO

CREATE PROCEDURE PROC_CRUD_FUNCIONARIOS
	@ACAO CHAR(1),
	@ID_FUNC UNIQUEIDENTIFIER,
	@NOME VARCHAR(20),
	@SOBRENOME VARCHAR(30),
	@RG VARCHAR(12),
	@CPF VARCHAR(14),
	@DT_NASC DATETIME,
	@SEXO CHAR(1),
	@CARGO VARCHAR(20),
	@ATIVO BIT
AS
	BEGIN
	 
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_FUNCIONARIOS VALUES (NEWID(),@NOME,@SOBRENOME,@RG,@CPF,@DT_NASC,@SEXO,@CARGO,NULL, 1, GETDATE())	
			END

		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_FUNCIONARIOS
				SET NOME = @NOME,
					SOBRENOME = @SOBRENOME,
					RG = @RG,
					CPF = @CPF,
					DT_NASC = @DT_NASC,
					SEXO = @SEXO,
					CARGO = @CARGO,
					ATIVO = @ATIVO
				WHERE ID_FUNC = @ID_FUNC
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_PRINCIPAL_PESSOA WHERE ID_FUNC = @ID_FUNC
				DELETE FROM TB_FUNCIONARIOS WHERE ID_FUNC = @ID_FUNC 
			END
	END
GO 	 

CREATE PROCEDURE PROC_CRUD_ENDERECO
	@ACAO CHAR(1),
	@CPF_CNPJ VARCHAR(20),  
	@CEP CHAR(10), 
	@RUA VARCHAR(100), 
	@NUMERO INT,
	@BAIRRO VARCHAR(30), 
	@ESTADO VARCHAR(20),
	@CIDADE VARCHAR(30)
AS
	BEGIN
		DECLARE @ID_GERAL INT = (SELECT DBO.PROCURA_ID_GERAL(@CPF_CNPJ))
			IF(@ACAO = 'I') -- INSERIR
				BEGIN
					INSERT INTO TB_ENDERECO VALUES (@ID_GERAL, @CEP, @RUA, @NUMERO, @BAIRRO, @ESTADO, @CIDADE)
				END	

			ELSE IF(@ACAO = 'A')	--ALTERAR				
					BEGIN 
						UPDATE TB_ENDERECO	
						SET  CEP = @CEP,
							 RUA = @RUA,							 
							 NUMERO = @NUMERO,
							 BAIRRO = @BAIRRO,
							 ESTADO = @ESTADO,
							 CIDADE = @CIDADE
						WHERE ID_END = @ID_GERAL
					END

			ELSE IF(@ACAO = 'E') --EXCLUIR
				BEGIN
					DELETE FROM TB_ENDERECO WHERE ID_GERAL_END = @ID_GERAL
				END
	END
GO
 
CREATE PROCEDURE PROC_CRUD_CONTATO
	@ACAO CHAR(1),
	@CPF_CNPJ VARCHAR(20),  
    @TEL_NUMERO VARCHAR(14),
    @EMAIL VARCHAR(50)
AS
	BEGIN
		DECLARE @ID_GERAL INT = (SELECT DBO.PROCURA_ID_GERAL(@CPF_CNPJ))

			IF(@ACAO = 'I') -- INSERIR
				BEGIN
					INSERT INTO TB_CONTATO VALUES (@ID_GERAL, @TEL_NUMERO, @EMAIL)
				END	

			ELSE IF(@ACAO = 'A')	--ALTERAR				
					BEGIN 
						UPDATE TB_CONTATO	
						SET  EMAIL = @EMAIL,							 
							 NUMERO = @TEL_NUMERO 
							  
						WHERE ID_GERAL_TEL = @ID_GERAL
					END

			ELSE IF(@ACAO = 'E') --EXCLUIR
				BEGIN
					DELETE FROM TB_CONTATO WHERE ID_GERAL_TEL = @ID_GERAL
				END
	END
GO 

CREATE PROCEDURE PROC_CRUD_CLIENTE
	@ACAO CHAR(1),
	@ID_CLI UNIQUEIDENTIFIER,
	@NOME VARCHAR(20),
	@SOBRENOME VARCHAR(30),
	@RG VARCHAR(12),
	@CPF VARCHAR(14),
	@DT_NASC DATETIME ,
	@SEXO CHAR(1),
	@ATIVO BIT -- 0 FALSE, 1 TRUE
AS
	BEGIN
		DECLARE @ID INT = (SELECT ID_GERAL FROM TB_PRINCIPAL_PESSOA WHERE ID_CLI = @ID_CLI)
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_CLIENTES VALUES (NEWID(),@NOME,@SOBRENOME,@RG,@CPF,(FORMAT(@DT_NASC, 'dd/MM/yyyy')),@SEXO,NULL, 1, GETDATE())	
			END

	
		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_CLIENTES
				SET NOME = @NOME,
					SOBRENOME = @SOBRENOME,
					RG = @RG,
					CPF = @CPF,
					DT_NASC = @DT_NASC,
					SEXO = @SEXO,
					ATIVO = @ATIVO
				WHERE ID_CLI = @ID_CLI
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_ENDERECO WHERE ID_GERAL_END = @ID
				DELETE FROM TB_CONTATO WHERE ID_GERAL_TEL = @ID
				DELETE FROM TB_PRINCIPAL_PESSOA WHERE ID_CLI = @ID_CLI
				DELETE FROM TB_CLIENTES WHERE ID_CLI = @ID_CLI
			END
	END
GO 

CREATE PROCEDURE PROC_CRUD_PRODUTOS
	@ACAO CHAR(1),	
	@ID_PRODUTO INT,
	@NOME_PRODUTO VARCHAR(50),
	@DESCRICAO_PRODUTO VARCHAR(100),
	@CATEGORIA VARCHAR(30),
	@VALOR_UNI_COMPRA DECIMAL(5,2),
	@VALOR_UNI_VENDA	DECIMAL(5,2),
	@DATA_CADASTRO DATETIME
--	@ATIVO BIT
AS
	BEGIN
		 
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_PRODUTOS (NOME_PRODUTO,DESCRICAO_PRODUTO,CATEGORIA,VALOR_UNI_COMPRA,VALOR_UNI_VENDA,DATA_CADASTRO)	
							     VALUES (@NOME_PRODUTO,@DESCRICAO_PRODUTO,@CATEGORIA,@VALOR_UNI_COMPRA,@VALOR_UNI_VENDA,GETDATE())
			END

		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_PRODUTOS
				SET NOME_PRODUTO = @NOME_PRODUTO,
					DESCRICAO_PRODUTO = @DESCRICAO_PRODUTO,
					CATEGORIA = @CATEGORIA,
					VALOR_UNI_COMPRA = @VALOR_UNI_COMPRA,
					VALOR_UNI_VENDA = @VALOR_UNI_VENDA,
					DATA_CADASTRO = @DATA_CADASTRO
			--		ATIVO = @ATIVO
				WHERE ID_PRODUTO = @ID_PRODUTO
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_PRODUTOS WHERE ID_PRODUTO = @ID_PRODUTO
			END
	END
GO 

CREATE PROCEDURE PROC_CRUD_ESTABELECIMENTOS
	@ACAO CHAR(1),
	@ID_ESTAB UNIQUEIDENTIFIER,
	@CNPJ VARCHAR(20),
	@RAZAO_SOCIAL VARCHAR(50)	
AS
	BEGIN
 		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_ESTABELECIMENTOS VALUES (NEWID(),@CNPJ,@RAZAO_SOCIAL, GETDATE())
			END

		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_ESTABELECIMENTOS
				SET CNPJ = @CNPJ,
					RAZAO_SOCIAL = @RAZAO_SOCIAL
				WHERE ID_ESTAB = @ID_ESTAB
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_PRINCIPAL_PESSOA WHERE ID_ESTAB = @ID_ESTAB
				DELETE FROM TB_ESTABELECIMENTOS WHERE ID_ESTAB = @ID_ESTAB
			END
	END
GO 

CREATE PROCEDURE PROC_CRUD_FORNECEDORES
	@ACAO CHAR(1),
	@ID_FORN UNIQUEIDENTIFIER,
	@CNPJ VARCHAR(20),
	@RAZAO_SOCIAL VARCHAR(50),
	@ATIVO BIT
AS
	BEGIN
 		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_FORNECEDORES VALUES (NEWID(),@CNPJ,@RAZAO_SOCIAL, 1, GETDATE())
			END

		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_FORNECEDORES
				SET CNPJ = @CNPJ,
					RAZAO_SOCIAL = @RAZAO_SOCIAL,
					ATIVO = @ATIVO
				WHERE ID_FORN = @ID_FORN
			END

		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_PRINCIPAL_PESSOA WHERE ID_FORN = @ID_FORN
				DELETE FROM TB_FORNECEDORES WHERE ID_FORN = @ID_FORN
			END
	END
GO  

CREATE PROCEDURE PROC_CRUD_CONTAS_RECEBER
	@ACAO CHAR(1),
	@ID_COMANDA_RECEBER INT,
	@METODO_PAGAMENTO VARCHAR(2),
	@DINHEIRO DECIMAL(5,2),
	@DEBITO DECIMAL(5,2),
	@CREDITO DECIMAL(5,2),
	@DATA_COMPRA DATETIME,
	@DATA_PREVISTA_RECEBER DATETIME
AS
BEGIN
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_CONTAS_RECEBER (METODO_PAGAMENTO, DINHEIRO, DEBITO, CREDITO, DATA_COMPRA, DATA_PREVISTA_RECEBER)
									  VALUES(@METODO_PAGAMENTO,@DINHEIRO,@DEBITO,@CREDITO, @DATA_COMPRA, @DATA_PREVISTA_RECEBER) 
			END
		
		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_CONTAS_RECEBER	
				SET METODO_PAGAMENTO = @METODO_PAGAMENTO,
					DINHEIRO = @DINHEIRO,
					DEBITO = @DEBITO,
					CREDITO = @CREDITO,
					DATA_COMPRA = @DATA_COMPRA,
					DATA_PREVISTA_RECEBER = @DATA_PREVISTA_RECEBER
				WHERE ID_COMANDA_RECEBER = @ID_COMANDA_RECEBER 
			END
		
		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_CONTAS_RECEBER WHERE ID_RECEBER = (SELECT ID_RECEBER FROM TB_CONTAS_RECEBER WHERE ID_COMANDA_RECEBER = @ID_COMANDA_RECEBER) 
			END
END
GO

CREATE PROCEDURE PROC_CRUD_CONTAS_PAGAR
	@ACAO CHAR(1),
	@ID_PAGAR INT,
	@ID_COMPRA INT, 
	@DATA_VENCIMENTO DATETIME
AS
BEGIN
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_CONTAS_PAGAR (ID_COMPRA,DATA_VENCIMENTO)
									  VALUES(@ID_COMPRA,@DATA_VENCIMENTO) 
			END
		
		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_CONTAS_PAGAR	
				SET   ID_COMPRA = @ID_COMPRA,
					  DATA_VENCIMENTO = @DATA_VENCIMENTO
				WHERE ID_PAGAR = @ID_PAGAR
			END
		
		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_CONTAS_PAGAR WHERE ID_PAGAR = @ID_PAGAR
			END
END
GO

CREATE PROCEDURE PROC_CRUD_ESTOQUE
	@ACAO VARCHAR(1),
	@ID_ESTOQUE INT,
	@ID_PRODUTO INT, 
	@QUANTIDADE INT, 
	@DATA_ENTRADA DATETIME,
	@DATA_VENCIMENTO DATETIME
AS
	BEGIN
		IF(@ACAO = 'I')
			BEGIN
				INSERT INTO TB_ESTOQUE VALUES (@ID_PRODUTO, @QUANTIDADE, @DATA_ENTRADA, @DATA_VENCIMENTO)
			END
		ELSE IF(@ACAO = 'A')
			BEGIN
				UPDATE TB_ESTOQUE
				   SET ID_PROD_ESTOQ = @ID_PRODUTO,
					   QUANTIDADE = @QUANTIDADE,
					   DATA_ENTRADA = @DATA_ENTRADA,
					   DATA_VENCIMENTO = @DATA_VENCIMENTO
				WHERE ID_ESTOQUE = @ID_ESTOQUE
			END
		ELSE IF(@ACAO = 'E')
			BEGIN
				DELETE FROM TB_ESTOQUE WHERE ID_ESTOQUE = @ID_ESTOQUE
			END
	END
GO
/*========================================================================
  ========================================================================
			TRIGGERS PARA INSERIR NA TABELA PESSOA PRINCIPAL	
  =======================================================================
  =======================================================================*/

CREATE TRIGGER INSERE_FUNCIONARIOS
ON TB_FUNCIONARIOS 
AFTER INSERT 
AS 
	BEGIN
		DECLARE @ID_FUNCIONARIO UNIQUEIDENTIFIER,
				@CARGO VARCHAR(30),  	
				@HIERARQUIA INT,
				@CPF VARCHAR(14),
				@USUARIO VARCHAR(40),
				@EMAIL VARCHAR(60)

		SELECT @ID_FUNCIONARIO = ID_FUNC, 
			   @CPF = REPLACE(REPLACE(CPF,'-',''),'.',''),
			   @USUARIO =  REPLACE(CONCAT(NOME, '.' , SOBRENOME),' ',''),
			   @CARGO = CARGO
		FROM INSERTED
				SET @EMAIL = LOWER((SELECT CONCAT(@USUARIO, LEFT(@CPF,4), '@REDEAGORA.COM'))) 
		SELECT @HIERARQUIA = ID_HIERARQUIA
		FROM TB_HIERARQUIA  
		WHERE CARGO = @CARGO
			 
		INSERT INTO TB_LOGIN VALUES (@HIERARQUIA,@EMAIL,REPLACE(CHECKSUM(NEWID()),'-','')) 

		UPDATE TB_FUNCIONARIOS
		SET ID_LOGIN = (SELECT MAX(ID_LOGIN)FROM TB_LOGIN)
		WHERE ID_FUNC =  @ID_FUNCIONARIO

		INSERT INTO TB_PRINCIPAL_PESSOA (ID_FUNC) 
			VALUES (@ID_FUNCIONARIO)			 
	END	
GO

CREATE TRIGGER INSERE_FORNECEDOR
ON TB_FORNECEDORES 
AFTER INSERT 
AS 
	BEGIN
		DECLARE @ID_FORNECEDOR UNIQUEIDENTIFIER = (SELECT ID_FORN
												   FROM INSERTED) 

		INSERT INTO TB_PRINCIPAL_PESSOA (ID_FORN) 
				VALUES (@ID_FORNECEDOR)
	END
GO

CREATE TRIGGER INSERE_CLIENTE
ON TB_CLIENTES 
AFTER INSERT 
AS 
	BEGIN
		DECLARE @ID_CLIENTE UNIQUEIDENTIFIER = (SELECT ID_CLI
												FROM INSERTED)
												
		DECLARE @ID_GERAL INT = (SELECT ID_GERAL 
								 FROM TB_PRINCIPAL_PESSOA
								 WHERE ID_CLI = @ID_CLIENTE)

		INSERT INTO TB_PRINCIPAL_PESSOA (ID_CLI) 
				VALUES (@ID_CLIENTE)

		DECLARE @EMAIL VARCHAR(30) = (SELECT EMAIL 
									  FROM TB_CONTATO
									  WHERE ID_GERAL_TEL = @ID_GERAL)
		IF (@EMAIL) IS NOT NULL 
			BEGIN
				INSERT INTO TB_LOGIN (USUARIO) VALUES (@EMAIL)
			END
	END
GO

CREATE TRIGGER INSERE_ESTABELECIMENTO
ON TB_ESTABELECIMENTOS 
AFTER INSERT 
AS 
	BEGIN
		DECLARE @ID_ESTABELECIMENTO UNIQUEIDENTIFIER = (SELECT ID_ESTAB
											FROM INSERTED) 

		INSERT INTO TB_PRINCIPAL_PESSOA (ID_ESTAB) 
				VALUES (@ID_ESTABELECIMENTO)
	END
GO

CREATE TRIGGER AUMENTA_ESTOQUE_E_GERA_CONTAS
ON TB_COMPRAS
AFTER UPDATE
AS 	
	BEGIN 	
		DECLARE @ID_COMPRA INT =(SELECT ID_COMPRA FROM TB_COMPRAS WHERE STATUS = 'C'),
				@ID_PRODUTO INT,
				@QUANTIDADE INT

		DECLARE STATUS_CURSOR CURSOR
			FOR SELECT ID_PRODUTO, QUANTIDADE
			FROM TB_COMPRA_PRODUTO
					INNER JOIN TB_COMPRAS 
					ON TB_COMPRA_PRODUTO.ID_COMPRA_PRODUTO = TB_COMPRAS.ID_COMPRA
		WHERE ID_COMPRA = @ID_COMPRA		

		OPEN STATUS_CURSOR
		FETCH NEXT FROM STATUS_CURSOR  
		INTO @ID_PRODUTO, @QUANTIDADE
 
		WHILE @@FETCH_STATUS = 0
			BEGIN		 
				IF(@ID_PRODUTO) IN (SELECT ID_PROD_ESTOQ FROM TB_ESTOQUE)
					BEGIN			 
						UPDATE TB_ESTOQUE
						SET QUANTIDADE += @QUANTIDADE						
						WHERE ID_PROD_ESTOQ = @ID_PRODUTO								
					END
					ELSE
					BEGIN
						INSERT INTO TB_ESTOQUE VALUES(@ID_PRODUTO,@QUANTIDADE, GETDATE(), GETDATE() + 30)
					END						
				FETCH NEXT FROM STATUS_CURSOR INTO @ID_PRODUTO, @QUANTIDADE									
			END	

			CLOSE STATUS_CURSOR		
			DEALLOCATE STATUS_CURSOR

			UPDATE TB_COMPRAS
			SET STATUS = 'F',
				DATA_FINALIZADA = GETDATE()
			WHERE ID_COMPRA = @ID_COMPRA		

			INSERT INTO TB_CONTAS_PAGAR	VALUES(@ID_COMPRA, GETDATE() + 30)		
	 END 
GO	 

CREATE VIEW VW_CONTAS_PAGAR
AS
	SELECT ID_COMPRA_PRODUTO, 
		   TB_PRODUTOS.ID_PRODUTO, 
		   TB_PRODUTOS.DESCRICAO_PRODUTO,
			QUANTIDADE,
			TB_PRODUTOS.VALOR_UNI_COMPRA,
			(SELECT QUANTIDADE * VALOR_UNI_COMPRA) AS SUBTOTAL
	FROM TB_COMPRA_PRODUTO 
		INNER JOIN TB_PRODUTOS ON TB_PRODUTOS.ID_PRODUTO = TB_COMPRA_PRODUTO.ID_PRODUTO
	GROUP BY ID_COMPRA_PRODUTO,
			 TB_PRODUTOS.ID_PRODUTO,
			 TB_PRODUTOS.DESCRICAO_PRODUTO,
			 QUANTIDADE,
			 TB_PRODUTOS.VALOR_UNI_COMPRA 
GO

CREATE VIEW VW_ESTOQUE
AS 
	SELECT ID_PRODUTO  , 
		   (SELECT RAZAO_SOCIAL FROM TB_FORNECEDORES WHERE ID_FORN = ID_FORN_PROD) AS FORNECEDOR,
		   NOME_PRODUTO AS NOME_PRODUTO,
		   DESCRICAO_PRODUTO AS DESCRICAO,
		   CATEGORIA AS CATEGORIA,
		   QUANTIDADE AS QUANTIDADE,
		   VALOR_UNI_COMPRA AS VALOR_COMPRA,
		   VALOR_UNI_VENDA AS VALOR_VENDA, 
		   (CONCAT(LEFT((VALOR_UNI_VENDA-VALOR_UNI_COMPRA)/VALOR_UNI_COMPRA*100 ,5),'%')) AS PERCENTUAL_LUCRO,
		   FORMAT(DATA_CADASTRO, 'dd/MM/yyyy') AS DATA_CADASTRO		   
		   
	FROM TB_ESTOQUE EST
		INNER JOIN TB_PRODUTOS PROD ON PROD.ID_PRODUTO = EST.ID_PROD_ESTOQ
GO
 
CREATE VIEW VW_END_CONTATO
AS
	SELECT ID_GERAL,
		   CEP,
		   RUA,
		   ENDE.NUMERO AS NUMERO_RESIDENCIA,
		   BAIRRO,
		   ESTADO,
		   CIDADE,
		   CONT.NUMERO AS NUMERO_CONTATO,
		   EMAIL

	FROM TB_PRINCIPAL_PESSOA PES
		INNER JOIN TB_ENDERECO ENDE ON ENDE.ID_GERAL_END = PES.ID_GERAL
		INNER JOIN TB_CONTATO CONT ON CONT.ID_GERAL_TEL = PES.ID_GERAL
GO 

CREATE VIEW VW_COMPRA
AS
	SELECT ID_COMPRA,
		   STATUS,
		   LISTA.ID_PRODUTO,
		   (SELECT NOME_PRODUTO FROM TB_PRODUTOS WHERE ID_PRODUTO = LISTA.ID_PRODUTO ) AS NOME_PRODUTO,
		   QUANTIDADE,
		   VALOR_UNI_COMPRA,
		   (SELECT QUANTIDADE * VALOR_UNI_COMPRA) AS SUBTOTAL_PRODUTO
	FROM  TB_COMPRA_PRODUTO LISTA
		INNER JOIN  TB_COMPRAS COMPRA ON COMPRA.ID_COMPRA = LISTA.ID_COMPRA_PRODUTO
		INNER JOIN TB_PRODUTOS PRODUTO ON PRODUTO.ID_PRODUTO = LISTA.ID_PRODUTO
GO	
 
/*
	----------------------------
	SELECT * FROM TB_COMANDA
	SELECT * FROM TB_PRODUTOS
	SELECT * FROM TB_LISTA_PRODUTOS
	--------------------------------

	INSERT INTO TB_FORNECEDORES VALUES (NEWID(), 'COCA COLA BRASIL','81.709.591/0001-72',1)
	INSERT INTO TB_FORNECEDORES VALUES (NEWID(), 'BUNGUE PAES','30.576.261/0001-15',1)
	INSERT INTO TB_FORNECEDORES VALUES (NEWID(), 'AGRO DORITOS','66.159.730/0001-48',1)

	INSERT INTO TB_PRODUTOS VALUES (  (SELECT ID_FORN FROM TB_FORNECEDORES WHERE RAZAO_SOCIAL = 'COCA COLA BRASIL' ),'COCA-COLA 2L', NULL, 'REFRIGERANTE', 5,8, GETDATE() )
	INSERT INTO TB_PRODUTOS VALUES (  (SELECT ID_FORN FROM TB_FORNECEDORES WHERE RAZAO_SOCIAL = 'BUNGUE PAES' ),'FARINHA 20K', 'FARINHA SEARA TIPO 2 20K - SEM GLUTEN', 'FARINHA', 50.60, NULL,GETDATE() )
	INSERT INTO TB_PRODUTOS VALUES (  (SELECT ID_FORN FROM TB_FORNECEDORES WHERE RAZAO_SOCIAL = 'AGRO DORITOS' ),	'DORITOS 720G', NULL, 'SALGADINHOS', 9, 12.98,GETDATE() )
	
	EXEC PROC_VENDA_CLIENTE 'I',3245, 1, 500,NULL, NULL, NULL, NULL
	EXEC PROC_VENDA_CLIENTE 'I',3245, 2, 100,NULL, NULL, NULL, NULL
	EXEC PROC_VENDA_CLIENTE 'I',3245, 3, 200,NULL, NULL, NULL, NULL

	EXEC PROC_VENDA_CLIENTE 'I',4480, 1, 500,NULL, NULL, NULL, NULL
	EXEC PROC_VENDA_CLIENTE 'I',4480, 2, 100,NULL, NULL, NULL, NULL
	EXEC PROC_VENDA_CLIENTE 'I',4480, 3, 200,NULL, NULL, NULL, NULL

	EXEC PROC_VENDA_CLIENTE 'P',3245, NULL, NULL,C, NULL, NULL, 1000
	EXEC PROC_VENDA_CLIENTE 'P',4480, NULL, NULL,D, 15598, NULL, NULL

	EXEC PROC_COMPRA_ESTAB IC,NULL,1,90
	EXEC PROC_COMPRA_ESTAB II,1000,3,200 
	EXEC PROC_COMPRA_ESTAB C,1000,NULL,NULL

	INSERT INTO TB_ESTABELECIMENTOS VALUES (NEWID(), 'AGORA PAES II','99.141.683/0001-64')
	INSERT INTO TB_ESTABELECIMENTOS VALUES (NEWID(), 'AGORA E DEPOIS','51.245.830/0001-10')
	INSERT INTO TB_ESTABELECIMENTOS VALUES (NEWID(), 'AGORA DOANE IV','57.260.161/0001-31')

	INSERT INTO TB_CLIENTES VALUES (NEWID(), 'OTÁVIO','LUIZ NICOLAS CORTE REAL','28.792.065-3','763.327.498-06','19/05/1994', 'M', NULL,1)
	INSERT INTO TB_CLIENTES VALUES (NEWID(), 'BRENDA','MIRELLA SILVA','14.068.796-8','671.226.233-00','05/01/2000', 'F', NULL,1)
	INSERT INTO TB_CLIENTES VALUES (NEWID(), 'THOMAS','KAIQUE ARTHUR DA CRUZ','42.880.242-4','193.171.433-93','20/02/1964', 'M', NULL,1)
	
	INSERT INTO TB_FUNCIONARIOS VALUES (NEWID(), 'GIOVANA','BRUNA ISADORA SILVEIRA', '49.052.192-7','104.911.713-15','24/06/1976', 'F', 'ADMINISTRADOR',NULL,1)
	INSERT INTO TB_FUNCIONARIOS VALUES (NEWID(), 'FABIO','EMANUEL LIMA','17.153.772-5','524.546.303-20','11/08/1981', 'M','GERENTE',NULL,1)
	INSERT INTO TB_FUNCIONARIOS VALUES (NEWID(), 'ELISA','YASMIN DA MATA','19.639.673-6','735.776.913-52','25/06/1981', 'F','BALCONISTA',NULL,1,GETDATE())
	 
SELECT * FROM TB_PRINCIPAL_PESSOA
SELECT * FROM TB_CLIENTES 
SELECT * FROM TB_ENDERECO
SELECT * FROM TB_CONTATO
SELECT * FROM TB_LOGIN
SELECT * FROM TB_ESTOQUE WHERE ID_ESTOQUE = 1002
SELECT * FROM VW_ESTOQUE 
SELECT * FROM TB_HIERARQUIA
SELECT * FROM TB_FUNCIONARIOS 
SELECT * FROM TB_ESTABELECIMENTOS 
SELECT * FROM TB_FORNECEDORES
SELECT * FROM TB_ESTOQUE
SELECT * FROM TB_CONTAS_PAGAR 
SELECT * FROM TB_COMPRA_PRODUTO
SELECT * FROM TB_FORNECEDORES 
SELECT * FROM TB_COMPRAS
SELECT * FROM TB_CONTAS_PAGAR 
SELECT * FROM TB_LISTA_PRODUTOS	WHERE ID_COMANDA_LISTA = 3245
SELECT * FROM TB_ESTOQUE
SELECT * FROM TB_CONTAS_RECEBER
SELECT * FROM VW_COMPRA
SELECT * FROM VW_CONTAS_PAGAR WHERE ID_COMPRA_PRODUTO = 1
SELECT SUM(SUBTOTAL_PRODUTO) AS TOTAL FROM VW_COMPRA WHERE ID_COMPRA = 1
SELECT * FROM VW_CONTAS_PAGAR 
SELECT SUM(SUBTOTAL_PRODUTO) AS TOTAL FROM VW_COMPRA WHERE ID_COMPRA = 1


 SELECT
    CONVERT(INT, CRYPT_GEN_RANDOM(4)) AS MEU_PREFERIDO_SQL2012

SELECT (DATEPART(NS, SYSDATETIME()))		

SELECT
   -- NEWID() AS STRING_ALEATORIO,
    CHECKSUM(NEWID()) AS INTEIRO_ALEATORIO
	 
	
*/
