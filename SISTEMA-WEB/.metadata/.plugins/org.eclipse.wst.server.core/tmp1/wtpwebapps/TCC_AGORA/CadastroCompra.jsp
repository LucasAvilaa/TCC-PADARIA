<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>PEDIDO DE COMPRA</title> 
      <link rel="shortcut icon" href="img/Logo_Padaria.png"/>
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
     <link rel="stylesheet" type="text/css" href="css/inserirItens.css" media="screen" /> 
      <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
   </head>
   <body>
      <jsp:include page="index.xhtml" flush="false">
         <jsp:param name="cabecalho" value="cabecalho"/>
      </jsp:include>
   
  <f:view >  
         <form action="ControlCompra" method="POST" name="cadastroCompra">
            
            	<h2>PEDIDO COMPRA</h2>
           
            <br />
            <p>
            	<input value="ENVIAR" type="submit" id="btn"> <a href="ControlCompra?action=Tabela">CANCELAR</a> 
            </p>
            <br />
            <fieldset id="informacoes"> 
               <p>
                  <label>
                     REFERÊCIA: <c:out value="COMPRA/${compra.idCompra}"/>
                  </label>
                  <label style="padding-left: 90px">
                     DATA COMPRA: <fmt:formatDate pattern="dd/MM/yyyy" value="${compra.dataCriada}"/>
                  </label>
               </p> 
               <p> 
                  <label >
                     SITUAÇÃO: <c:out value="${compra.status}"/>
                  </label>
                  <label style="padding-left: 168px">
                     DATA FINALIZADA: <fmt:formatDate pattern="dd/MM/yyyy" value="${compra.dataFinalizada}" />
                  </label>
               </p>
                
            	 <br />
            		<table border="1">
            			<thead>
            				<tr> 
            					<th style="width: 193px; " >PRODUTO</th>
            					<th style="width: 195px; ">FORNECEDOR</th>
            					<th style="width: 125px; ">QUANTIDADE</th>
            					<th style="width: 154px; ">VALOR UNITÁRIO</th>
            					<th style="width: 94px; ">SUBTOTAL</th>
            					<th colspan="2">AÇÃO</th>
            				</tr>
            			</thead>
            			<tbody>
            				<c:forEach items="${itens}" var="itens">
            					<tr>
            						<td> 
            							<c:out value="${itens.tbProduto.nomeProduto}"></c:out>
           							</td> 
           							<td>
           							 	<c:out value="${itens.tbProduto.tbFornecedore.razaoSocial}"></c:out>
           							</td>
									<td contenteditable="true" align="center">
            							<c:out value="${itens.quantidade}" />
           							</td>
           							<td contenteditable="true" align="center">
            							<c:out value="${itens.tbProduto.valorUniCompra}" />
           							</td>
           							<td id="subtotal"  >
            							<c:out value="${itens.quantidade}*${itens.tbProduto.valorUniCompra}" />
            						 
           							</td>
            						<td><a href='ControlCompra?action=EditItens&idCompra=<c:out value="${compra.idCompra}"/>&idItem=<c:out value="${itens.tbProduto.idProduto}"/>'><img src="img/refresh-icon.png" style="width: 21px; height: 21px; " title="ATUALIZAR"></a></td>
                 					<td><a href='ControlCompra?action=DeleteItens&idCompra=<c:out value="${compra.idCompra}"/>&idItem=<c:out value="${itens.tbProduto.idProduto}"/>'><img src="img/delete.png" style="width: 21px; height: 21px; " title="EXCLUIR"></a></td>
                 
            					</tr>
            				</c:forEach>
            				 	<tr>
	            					<td colspan="7">
	            						<a href="#" onclick="abrir();">INSERIR ITENS</a>
	            					</td>
	            				</tr>	
	            				<tr><td colspan="7" style="color: white">  0  </td> </tr>
	            			 	<tr>	
	            			 		<td colspan="4">TOTAL</td>
	            			 		<td colspan="3">R$ XXX,XX</td>
            					</tr> 
            			</tbody>
            		</table>
            </fieldset>
         </form>
         <div class="inserir-itens-container" id="inserir-itens-container"> 
         	<div class="inserir-itens">
		         <form action="ControlCompra" method="POST" name="cadastroCompra">
		            
		            	<h2>INSERIR PRODUTO</h2>
		           
		            <br />
		            <p><input value="INSERIR" type="submit" id="btn"> <a href="#" onclick="fechar();">CANCELAR</a> </p>
		            <fieldset id="informacoes">
		               <legend>INFORMAÇÕES BÁSICAS </legend>
		               <p>
		                  <label>
		                     NOME: <input name="nomeProduto"  maxlength="50" value="<c:out value="${produto.nomeProduto}"/>" required="required" style="width: 291px; "/>
		                  </label>
		               </p>
		               <p>
		                  <label>
		                     DESCRIÇÃO: <input name="descricao" maxlength="50" value="<c:out value="${produto.descricaoProduto}"/>" required="required"  style="width: 248px; "/>
		                  </label>
		               </p>
		               <p>
		                  <label>
		                     CATEGORIA: 
		                  		 <h:selectOneMenu style="width: 195px; height: 24px" id="categoria">
			                        <f:selectItem itemValue="#{produto.categoria}" itemDisabled="true"/>
			                        <f:selectItem noSelectionOption="true" itemValue="___________" itemDisabled="true"/>
			                        <f:selectItem itemValue="MERCEARIA" itemLabel="MERCEARIA"/>
			                        <f:selectItem itemValue="PRODUCAO" itemLabel="PRODUÇÃO"/>
			                        <f:selectItem itemValue="REFRIGERANTE" itemLabel="REFRIGERANTE   "/>
			                         <f:selectItem itemValue="LANCHES" itemLabel="LANCHES"/>
			                         <f:selectItem itemValue="DOCES" itemLabel="DOCES"/>
			                        <f:selectItem itemValue="COPA" itemLabel="COPA"/>
		                     	</h:selectOneMenu>
		                  </label>
		                </p>
		                <p>
		                  <label>
		                     VALOR COMPRA: <input name="vUnitCompra" value="<c:out value="${produto.valorUniCompra}"/>" placeholder="R$000,00"  required="required" style="width: 90px; "/>
		                  </label>
		                  <label>
		                     VALOR VENDA: <input name="vUnitVenda" type="text" value="<c:out value="${produto.valorUniVenda}"/>" required="required" placeholder="R$000,00"  style="width: 90px; ">
		                  </label>
		               </p>  
		                 <p>  
		                  <label>
		                     FORNECEDOR: 
		                     <h:selectOneMenu style="width: 180px; height: 24px" id="fornecedor" >                     
		                        <f:selectItem itemValue="#{produto.tbFornecedore.razaoSocial}"/> 
		                        <f:selectItem noSelectionOption="true" itemValue="___________________" itemDisabled="true"/> 
		                        <f:selectItems value="#{tbFornecedore.fornecedores}" itemValue="#{tbFornecedore.fornecedores}"/>
		                     </h:selectOneMenu>
		                  </label>
		               </p> 
		               
		            </fieldset> 
		         </form> 
		         </div>
         </div>
   </f:view>
   </body>  
   <script>
   		function abrir(){
   			document.getElementById("inserir-itens-container").style.display = 'block';	 
   		}
   		
   		function fechar(){
   			document.getElementById("inserir-itens-container").style.display = 'none'; 
   		}
   </script>
</html>	