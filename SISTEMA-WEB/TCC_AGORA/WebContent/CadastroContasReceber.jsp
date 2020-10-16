<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>CONTAS A RECEBER</title>
      <link rel="shortcut icon" href="img/Logo_Padaria.png"/>
      <link rel="stylesheet" type="text/css" href="css/CadastroCliente.css">
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
   </head>
   <body>
      <jsp:include page="index.xhtml" flush="false">
         <jsp:param name="cabecalho" value="cabecalho"/>
      </jsp:include>
  <f:view>  
         <form action="ControlContasReceber" method="POST" name="cadastroContasReceber">
            
            	<h2>CONTAS A RECEBER</h2>
           
            <br />
            <p><input value="ENVIAR" type="submit" id="btn"> <a href="ControlContasReceber?action=Tabela">CANCELAR</a> </p>
            <fieldset id="informacoes">
               <legend>INFORMAÇÕES BÁSICAS </legend>
               <p>
               	<label>
                     REFERÊNCIA VENDA: <input name="idVenda" maxlength="50" value="<c:out value=""/>"   style="width: 248px; "/>
                  </label>
                  <label>
                     METODO DE PAGAMENTO: 
                      <h:selectOneMenu style="width: 150px; height: 24px" id="condicaoPagamento">
	                        <f:selectItem itemValue="#{receber.metodoPagamento}"/>
	                        <f:selectItem noSelectionOption="true" itemValue="_________"/>
	                        <f:selectItem itemValue="DINHEIRO" itemLabel="DINHEIRO"/>
	                        <f:selectItem itemValue="CARTÃO" itemLabel="CARTÃO"/>
	                        <f:selectItem itemValue="CARTÃO/DINHEIRO" itemLabel="CARTÃO/DINHEIRO"/>
                     </h:selectOneMenu> 
                  </label>
               </p> 
               <p>
                  <label>
                     DINHEIRO: <input name="dinheiro" value="<c:out value="${receber.dinheiro}"/>"   style="width: 248px; "/>
                  </label>
               </p>   
               <p>
                  <label>
                     CARTÃO DEBITO: <input name="debito" value="<c:out value="${receber.debito}"/>"   style="width: 248px; "/>
                  </label>
               </p>
               <p>
                  <label>
                     CARTÃO CRÉDITO: <input name="credito" value="<c:out value="${receber.credito}"/>"   style="width: 248px; "/>
                  </label>
               </p> 
                <p>
                  <label>
                     TOTAL: <input name="total" type="number" readonly="readonly" value='<c:out value=""></c:out>' placeholder="R$000,00"  required="required" style="width: 90px; "/>
                  </label> 
               </p>   
               <p>
                  <label>
                     DATA DA VENDA: <input name="dataVenda"  value="<fmt:formatDate pattern="dd/MM/yyyy" value="" />" style="width: 100px; "/>
                  </label> 
               </p>  
               <p>
                  <label>
                     DATA PREVISTA RECEBER: <input name="dataPrevista" value="<fmt:formatDate pattern="dd/MM/yyyy" value="" />" style="width: 100px; "/>
                  </label> 
               </p>  
            </fieldset> 
         </form>
   </f:view>
   </body> 
   </body> 
</html>	