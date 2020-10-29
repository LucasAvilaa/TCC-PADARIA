<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="css/inserirItens.css" />
<title>CAIXA</title>
</head>
<body>
	<%
   		String usuario = (String) session.getAttribute("usuario");
   		if(usuario == null){
   			response.sendRedirect("Login.xhtml");
   		}
   	%>
	<f:view>
		<jsp:include page="index.jsp" flush="false">
			<jsp:param name="cabecalho" value="cabecalho" />
		</jsp:include>
		<h2 style="background-color: white; text-align: center">CAIXA</h2>
		<div class="div-alinhada">
			<div style="background-color: rgba(255, 255, 204, 1)"  >
				<p>
					<label> NÚMERO COMANDA: <input type="number" name="idComanda" id="idComanda" value="<c:out value="${comanda}" />"/> 
											<a href="#" onclick="this.href='ControlVenda?action=pesquisaComanda&idComanda='+document.getElementById('idComanda').value">PESQUISAR</a> 
					</label>
				</p>
				<table border="1">
					<thead>
						<tr style="height: 25px; font-size: 12px">
							<th style="width: 83px;">COD. PROD</th>
							<th style="width: 258px;">PRODUTO</th>
							<th style="width: 92px;">QUANT.</th>
							<th style="width: 82px;">VALOR UNIT.</th>
							<th style="width: 100px;">SUBTOTAL</th>
							<th colspan="2">AÇÃO</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${venda}" var="venda">
						<tr>
							<td><c:out value="${venda.tbProduto.idProduto}" /></td>
							<td><c:out value="${venda.tbProduto.nomeProduto}" /></td>
							<td><c:out value="${venda.quantidade}" /></td>
							<td><c:out value="${venda.tbProduto.valorUniVenda}" /></td>
							<td><c:out value="${venda.subtotal}" /></td>
							<td><a
								href='ControlVenda?action=Edit&idComanda=<c:out value="${comanda}"/>&codItem=<c:out value="${venda.tbProduto.idProduto}"/>'><img
									src="img/edit.svg" style="width: 21px; height: 21px;"
									title="ATUALIZAR" /></a></td>
							<td><a
								href='ControlVenda?action=Delete&idComanda=<c:out value="${comanda}"/>&codItem=<c:out value="${venda.tbProduto.idProduto}"/>'><img
									src="img/trash-2.svg" style="width: 21px; height: 21px;"
									title="EXCLUIR ITEM" /></a></td>

						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div style="background-color: #CCE5FF"  >
				<form action="ControlVenda" method="post">
					<p>
						<label> PRODUTO <input type="text" value=" " />
						</label>
					</p>
					<p>
						<label> QUANTIDADE <input type="text" value=" " />
						</label>
					</p>
					<p>
						<label> PRECO UNITÁRIO <input type="text" value=" "
							readonly="readonly" />
						</label>
					</p>
					<p>
						<label> QUANTIDADE X UNITÁRIO <input type="text"
							value=" " readonly="readonly" />
						</label>
					</p>
					<p>
						<label> TOTAL <input type="text" readonly="readonly" value="<c:out value="${total.total}" />"> 
						</label>
					</p>
					<p>
						<label>
							<a href="#" onclick="abrir()"> 
								FINALIZAR COMPRA <img src="img/edit.svg"
									style="width: 21px; height: 21px;" title="FINALIZAR COMPRA" />
						 	</a>
						</label>
						
					</p>
					<p>
						<label>
						  	<a href='ControlVenda?action=Delete&idComanda=<c:out value=" "/>&codItem=<c:out value=" "/>'> 
								INSERIR ITEM <img src="img/trash-2.svg"
									style="width: 21px; height: 21px;" title="INSERIR ITEM" />
							 </a>
						</label>	
					</p>


				</form>
			</div>
		</div>
		<div style="background-color: gray">
			<p>OPERADOR: DATA: HORA:</p>
		</div>
		<div class="inserir-itens-container" id="inserir-itens-container">
			<div class="inserir-itens">
				<form action="ControlVenda" method="post"
					name="cadastroVenda">

					<fieldset id="informacoes">
						<legend>FINALIZAR COMPRA</legend>
						<p>
							<label>  
								FORMA DE PAGAMENTO:	<h:selectOneMenu style="width: 248px; height: 24px" id="formaPagamento">
								                        <f:selectItem itemValue=" "/>
								                        <f:selectItem noSelectionOption="true" itemValue="_________" itemDisabled="true"/>
								                        <f:selectItem itemValue="D" itemLabel="DINHEIRO"/>
								                        <f:selectItem itemValue="C" itemLabel="CARTÃO"/>
								                        <f:selectItem itemValue="CD" itemLabel="CARTÃO/DINHEIRO"/>
								                     </h:selectOneMenu> 
							</label> 
						</p>
						<p>
							<label> VALOR TOTAL: <input name=" " 
								value="<c:out value=" "/>" 
								style="width: 200px;" />
							</label>	
						</p>
						<p>		
							<label> DINHEIRO RECEBIDO: <input name=" "
								value="<c:out value=" "/>"  
								style="width: 200px;" />
							</label> 
						</p>
						<p>
							 <label> TROCO: <input name=" "
								value="<c:out value=" "/>" 
								style="width: 200px;" />
							</label>
						</p>

					</fieldset>
					<p>
						<input value=" RECEBER E FINALIZAR " type="submit" /> <a href="#"
							onclick="fechar();">CANCELAR</a>
					</p>
				</form>
			</div>
		</div>
	</f:view>
	<script>   
		window.onload = multiplica;

   		function abrir(){    
   	   			document.getElementById("inserir-itens-container").style.display = 'flex'; 
   		} 
   		
   		function fechar(){
   			document.getElementById("inserir-itens-container").style.display = 'none'; 
   		}  
	 
</script>

</body>
</html>