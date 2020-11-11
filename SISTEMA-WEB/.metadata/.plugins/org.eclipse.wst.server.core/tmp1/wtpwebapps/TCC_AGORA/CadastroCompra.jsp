	<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PEDIDO DE COMPRA</title>
<link rel="shortcut icon" href="img/Logo_Padaria.png" />
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/inserirItens.css"
	media="screen" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
	<style>
	th, td{
		padding: 6px;
	}
	table{
		width: 99%;
		margin: 0 auto; 
		border: none;
		border-radius: 0px 15px 15px 15px;
	}
</style>
</head> 

<body> 
	<jsp:include page="index.jsp"></jsp:include>
	<%
   		String usuario = (String) session.getAttribute("usuario");
   		if(usuario == null){
   			response.sendRedirect("Login.xhtml");
   		}
   	%>
	<f:view>
		<form action="ControlItensCompra" method="post" name="cadastroCompra">

			<h1 class="text-center margintop" style="margin-top: 0.4em;"><span class="badge badge-secondary text-center">PEDIDO DE COMPRA</span></h1>
            

			<br /> 
			<p> 
				<a  href="ControlCompra?action=ConfirmarCompra&idCompra=<c:out value="${compra.idCompra}"/>">
					<input type="button" value=" CONFIRMAR COMPRA" class="btn btn-success" style="width: 12em; height: 2.5em; margin-right:0.4em" />
				</a>
				<a href="ControlCompra?action=FinalizarCompra&idCompra=<c:out value="${compra.idCompra}"/>">
					<input type="button" value=" FINALIZAR COMPRA " class="btn btn-primary" style="width: 12em; height: 2.5em; margin-right:0.4em"/>
				</a>
				<a href="ControlCompra?action=Tabela"> 
					<input type="button" value=" VOLTAR " class="btn btn-danger" style="height: 2.5em;" /> 
				</a>
				
			</p> 
			<br />
			
			<fieldset id="informacoes" style="margin: 0 auto;">
			<div style="background-color: rgba(0,0,0, 0.6); height: 120px; padding-top: 15px; width: 60%; padding-left: 19px; margin-left: 6px; border-radius: 15px 15px 0px 0px">
				<p >
					<label class="text-white font-weight-bold"> REFERÊCIA: <c:out value="COMPRA/${compra.idCompra}" />
					</label> <label style="padding-left: 90px" class="text-white font-weight-bold"> DATA CRIADA: <fmt:formatDate
							pattern="dd/MM/yyyy hh:mm:ss" value="${compra.dataCriada}" />
					</label>
				</p>
				<p>
					<label class="text-white font-weight-bold"> 
						SITUAÇÃO: <c:out value="${compra.status}" />
					</label>
					<label style="padding-left: 100px; " class="text-white font-weight-bold"> 
						DATA FINALIZADA: <fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss" value="${compra.dataFinalizada}" />
					</label>
				</p> 
			</div>
				<table border="1" class="table-dark">
					<thead>
						<tr>
							<th style="width: 300px">PRODUTO</th>
							<th style="width: 300px">FORNECEDOR</th>
							<th style="text-align: center;">QUANTIDADE</th>
							<th style="text-align: center;">VALOR UNITÁRIO</th>
							<th style="text-align: center;">SUBTOTAL</th>
							<th colspan="2" style="text-align: center;" >AÇÃO</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${itens}" var="itens">
							<tr>
								<td>
									<c:out value="${itens.tbProduto.nomeProduto}"></c:out>
								</td>
								<td><c:out value="${itens.tbProduto.tbFornecedore.razaoSocial}"></c:out>
								</td>
								<td align="center" >
									<c:out value="${itens.quantidade}" />
									
								</td>
								<td  align="center">  
									<c:out value="${itens.tbProduto.valorUniCompra}"></c:out>
								</td>
								<td align="center"> 
									<c:out value="${itens.subtotal}"></c:out>
								</td>
								<td><a href='ControlCompra?action=EditItens&idCompra=<c:out value="${compra.idCompra}"/>&idItem=<c:out value="${itens.tbProduto.idProduto}"/>'>
								 		<span class="btn btn-success" style="height: 2.2em; width: 3em;"> <img src="img/edit.svg" style="width: 21px; height: 21px; " title="EDITAR" /> </span>
										
									</a>
								</td>
							 	<td><a href='ControlCompra?action=DeleteItens&idCompra=<c:out value="${compra.idCompra}"/>&idItem=<c:out value="${itens.tbProduto.idProduto}"/>'>
									  	<span class="btn" style="height: 2.2em; width: 3em; background-color: #ee0000"><img src="img/trash-2.svg" style="width: 21px; height: 21px; " title="EXCLUIR" /></span>
									</a>
								</td>

							</tr>
						</c:forEach>
						<tr>
							<td colspan="7">
								<a href="#" onclick="this.href='ControlCompra?action=InserirItens'" style="font-weight: bold; ">INSERIR ITENS</a>
							</td>
						</tr> 
						<tr>
							<td colspan="4" align="right">TOTAL</td>
							<td colspan="3"><c:out value="R$ ${total.total}"></c:out></td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</form>
		<div class="inserir-itens-container" id="inserir-itens-container">
			<div class="inserir-itens">
				<form action="ControlCompra" method="post" name="cadastroItensCompra">

					<fieldset id="informacoes">
					<legend class="text-center margintop h2" style="margin-top: 0.4em;"><span class="badge badge-secondary text-center">ITEM</span></legend>
 
						<p style="text-align:center; "  >
							<label  class="font-weight-bold" style="text-align: left" > NOME: <br /><h:selectOneMenu style="height: 1.5em; width: 20em"   id="idProd">
									<f:selectItem itemValue="#{item.tbProduto.idProduto}"	itemLabel="#{item.tbProduto.nomeProduto}" />
									<f:selectItem noSelectionOption="true" itemValue="___________________" itemDisabled="true" />
									<f:selectItems value="#{tbProduto.lista}" itemValue="#{tbProduto.lista}" />
								</h:selectOneMenu>
							</label>
						</p> 
						<p style="text-align:center">
							<label  class="font-weight-bold" style="text-align: left"> QUANTIDADE: <br /><input name="quantidade" id="quantidade" onchange="validaNumero()"  type="number"
								value="<c:out value="${item.quantidade}"/>" required="required"
								style="height: 1.5em; width: 20em" />
							</label>
						</p> 
						 
					</fieldset>
					<p>
						<input value="ADICIONAR" type="submit" class="btn btn-success" style="width: 198px;" />
						<a href="#" onclick="this.href='ControlCompra?action=EditCompra&idCompra='+ ${compra.idCompra}" class="btn btn-dark " style="width: 120px;">CANCELAR</a>
					</p>
				</form>
			</div>
		</div>
	</f:view>
	<script>     
	function validaNumero(){
		if(document.getElementById("quantidade").value < 0 ){
			document.getElementById("quantidade").value = "";
			window.alert("A QUANTIDADE NÃO PODE SER NEGATIVA");
		}
	} 
		var url_atual = window.location.href;
		   if(url_atual.indexOf("/ControlCompra?action=EditItens&idCompra=") != -1){
			   document.getElementById("inserir-itens-container").style.display = 'flex';  
		   }	 
		   if(url_atual.indexOf("/ControlCompra?action=InserirItens") != -1){
			   document.getElementById("inserir-itens-container").style.display = 'flex';  
		   }
		    
		   function abrir(){
			document.getElementById("inserir-itens-container").style.display = 'flex';
		   }
			   function fechar(){
				   document.getElementById("inserir-itens-container").style.display = 'none'; 
			   }   
	   </script>
</body> 
</html>