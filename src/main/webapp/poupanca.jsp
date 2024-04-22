<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css" />
<title>Conta Poupanca</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="contaPoupanca" method="post">
			<p class="title">
				<b>Conta Poupanca</b>
			</p>
			<table>
				<tr>
					<td colspan="3"><input class="input_data_small" type="number"
						id="numero" name="numero" placeholder="Numero da Conta"
						value='<c:out value="${conta.num_conta}"></c:out>'></td>
					<td><input type="submit" id="botao" name="botao"
						value="Buscar"></td>
				</tr>
				<tr>
					<td colspan="4"><input class="input_data" type="text"
						id="nome" name="nome" placeholder="Nome do Cliente"
						value='<c:out value="${conta.nomeCliente}"></c:out>'></td>
				</tr>
				<tr>
				<td colspan="4"><input class="input_data" type="number"
					id="diaRendimento" name="diaRendimento" step="1"
					placeholder="Dia de rendimento"
					value='<c:out value="${conta.diaDeRendimento}"></c:out>'></td>
				</tr>
				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Cadastrar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Alterar"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Excluir"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Listar"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty erro}">
			<H2>
				<b><c:out value="${erro}"></c:out></b>
			</H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<H3>
				<b><c:out value="${saida}"></c:out></b>
			</H3>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty contas}">
			<table class="table_round">
				<thead>
					<tr>
						<th>Numero da Conta</th>
						<th>Nome do Cliente</th>
						<th>Saldo</th>
						<th>Dia de Rendimento</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${contas}">
						<tr>
							<td><c:out value="${c.numConta}" /></td>
							<td><c:out value="${c.nomeCliente}" /></td>
							<td><c:out value="${c.saldo}" /></td>
							<td><c:out value="${c.diaDeRendimento}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>