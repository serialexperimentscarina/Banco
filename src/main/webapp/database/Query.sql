CREATE DATABASE banco
USE banco
GO
CREATE TABLE conta_bancaria(
nome_cliente	VARCHAR(250)	NOT NULL,
num_conta		INT				NOT NULL,
saldo			DECIMAL(7, 2)	NOT NULL,
PRIMARY KEY (num_conta)
)
GO
CREATE TABLE conta_poupanca(
num_conta		INT				NOT NULL,
dia_rendimento	INT				NOT NULL,
PRIMARY KEY (num_conta),
FOREIGN KEY (num_conta) REFERENCES conta_bancaria(num_conta)
)
Go
CREATE TABLE conta_especial(
num_conta		INT				NOT NULL,
limite			DECIMAL(7, 2)	NOT NULL,
PRIMARY KEY (num_conta),
FOREIGN KEY (num_conta) REFERENCES conta_bancaria(num_conta)
)
GO
CREATE TRIGGER t_saque ON conta_bancaria
AFTER UPDATE
AS
BEGIN
	DECLARE @num_conta INT
	DECLARE @limite DECIMAL(7, 2)
	DECLARE @saldo DECIMAL(7, 2)
	SET @num_conta = (SELECT num_conta FROM INSERTED)
	SET @saldo = (SELECT saldo FROM INSERTED)
	SET @limite = (SELECT limite FROM conta_especial WHERE num_conta = @num_conta)

	IF (@limite IS NOT NULL)
	BEGIN
		-- Se for conta especial
		IF (@saldo < 0 AND @saldo < (@limite * (-1)))
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('Saldo abaixo do limite permitido', 16, 1)
		END
	END
	ELSE
	BEGIN
		-- Se for conta normal
		IF (@saldo < 0)
		BEGIN
			ROLLBACK TRANSACTION
			RAISERROR ('Saldo não pode ser negativo para este tipo de conta', 16, 1)
		END
	END
END
GO
CREATE FUNCTION fn_dados_da_conta(@num_conta INT)
RETURNS @tabela TABLE(
num_conta			INT,
nome				VARCHAR(255),
saldo				DECIMAL(7, 2),
saldo_com_limite	DECIMAL(7, 2)
)
BEGIN
	-- Buscar dados base do cliente
	INSERT INTO @tabela (num_conta, nome, saldo) 
		SELECT num_conta, nome_cliente, saldo FROM conta_bancaria WHERE num_conta = @num_conta

	DECLARE @limite DECIMAL(7, 2)
	SET @limite = (SELECT limite FROM conta_especial WHERE num_conta = @num_conta)

	-- Agregar saldo com limite somente se for uma conta especial
	IF (@limite IS NOT NULL)
	BEGIN
		DECLARE @saldo DECIMAL(7, 2)
		SET @saldo = (SELECT saldo FROM conta_bancaria WHERE num_conta = @num_conta)
		UPDATE @tabela SET saldo_com_limite = (@saldo + @limite) WHERE num_conta = @num_conta
	END
	RETURN
END