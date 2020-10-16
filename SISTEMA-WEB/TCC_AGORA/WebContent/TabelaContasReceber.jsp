<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>CONTAS A PAGAR</title>
      <link rel="shortcut icon" href="img/Logo_Padaria.png"/>
      <link rel="stylesheet" type="text/css" href="css/CadastroCliente.css">
   </head>
   <body>
      <jsp:include page="index.xhtml" flush="false">
         <jsp:param name="cabecalho" value="cabecalho"/>
      </jsp:include>
      <f:view> 
         	<h2>CONTAS A PAGAR</h2>
            
         <br />
         <p>
            <a href="ControlContasReceber?action">
            <img src="img/adicionar.png" style="width: 31px; height: 28px; " title="ADICIONAR" />
            </a>
         </p>
         <table border="1">
            <thead>
               <tr>
                  <th style="width: 147px; ">REFERÊNCIA</th>
                  <th style="width: 141px; ">METODO PAGAMENTO</th> 
                  <th style="width: 141px; ">DINHEIRO</th> 
                  <th style="width: 193px; ">CARTÃO</th> 
                  <th style="width: 105px; ">TOTAL</th>
                  <th style="width: 181px; ">DATA VENDA</th>
                  <th style="width: 181px; ">DATA PREVISTA RECEBER</th>
                  <th colspan="2" style="width: 72px; ">AÇÃO</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items=" " var="conta">
                  <tr>
                     <td>
                        <c:out value="VENDA/ " />
                     </td>
                     <td>
                        <c:out value=" " />
                     </td>
                     <td>
                        <c:out value=" " />
                     </td>
                     <td>
                        <c:out value=" " />
                     </td>
                     <td>
                     	<c:out value="R$  " /> 
                     </td>
                     <td> 
                     	<fmt:formatDate pattern="dd/MM/yyyy" value=""/> 
                     </td>
                     <td>
                        <fmt:formatDate pattern="dd/MM/yyyy" value=""/>
                     </td> 
                     <td><a href='ControlContasReceberr?action=Edit&idReceber=<c:out value=" "/>'><img src="img/refresh-icon.png" style="width: 21px; height: 21px; " title="ATUALIZAR"></a></td>
                     <td><a href='ControlContasReceber?action=Delete&idReceber=<c:out value=" "/>'><img src="img/delete.png" style="width: 21px; height: 21px; " title="EXCLUIR"></a></td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
      </f:view>
   </body>
</html>