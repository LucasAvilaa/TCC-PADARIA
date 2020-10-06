<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@taglib
	uri="http://java.sun.com/jstl/fmt" prefix="fmt1"%><%@taglib
	uri="http://java.sun.com/jsf/html" prefix="h"%><%@taglib
	uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tabela Cliente</title>

		<link rel="stylesheet" type="text/css" href="css/CadastroCliente.css">		
</head>
<body>
	<f:view>
	<a href="ControlCliente?action">
		<img src="img/adicionar.png" style="width: 21px; height: 21px; " title="ADICIONAR">
		
	</a>
	<br>
	
	<table border="1">			
		 <thead>
			<tr>
				<th style="width: 147px; ">NOME</th>
				<th style="width: 141px; ">SOBRENOME</th>
				<th style="width: 105px; ">RG</th>	
				<th style="width: 127px; ">CPF</th>
				<th style="width: 208px; height: 34px">DATA NASCIMENTO</th>
				<th style="width: 67px; ">SEXO</th>
				<th colspan="2" style="width: 72px; ">AÇÃO</th>
			</tr>
		</thead>
		<tbody>
			 <c:forEach items="${cliente}" var="cliente">
				<tr> 
					<td><c:out value="${cliente.nome}" /></td>
					<td><c:out value="${cliente.sobrenome}" /></td>
					<td><c:out value="${cliente.rg}" /></td>
					<td><c:out value="${cliente.cpf}" /></td> 
					<td><fmt:formatDate pattern="dd/MM/yyyy" value="${cliente.dtNasc}" /></td> 
					<td><c:out value="${cliente.sexo}" /></td>
					<td><a href='ControlCliente?action=edit&idCli=<c:out value="${cliente.idCli}"/>'><img src="img/refresh-icon.png" style="width: 21px; height: 21px; " title="ATUALIZAR"></a></td>
					<td><a href='ControlCliente?action=delete&idCli=<c:out value="${cliente.idCli}"/>'><img src="img/delete.png" style="width: 21px; height: 21px; " title="EXCLUIR"></a></td>				
				</tr> 
			</c:forEach>
		</tbody>		
	</table>	
	</f:view>
		
	</body>
</html>