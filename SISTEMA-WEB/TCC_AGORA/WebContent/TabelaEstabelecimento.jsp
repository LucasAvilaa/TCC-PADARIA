<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>FILIAIS</title>
      <link rel="shortcut icon" href="img/Logo_Padaria.png"/>
      <link rel="stylesheet" type="text/css" href="css/CadastroCliente.css">
   </head>
   <body>
      <jsp:include page="index.xhtml">
         <jsp:param name="cabecalho" value="cabecalho"/>
      </jsp:include>
      <f:view>
      
         	<h1 class="text-center margintop" style="margin-top: 0.4em;"><span class="badge badge-secondary text-center">Lista de filiais</span></h1>
            
        
                 
         <br />
         <p>
            <a href="ControlEstabelecimento?action">
            <button class="btn btn-success" style="height: 2.2em"> Adicionar
            <img src="img/plus.svg" style="width: 31px; height: 28px; " title="ADICIONAR" />
            </button>

            </a>
         </p>
         <table border="1" class="table table-hover table-dark">
            <thead>
               <tr>
                  <th style="width: 357px; ">RAZÃO SOCIAL</th>
                  <th style="width: 166px; ">CNPJ</th> 
                  <th colspan="2" style="width: 72px; ">AÇÃO</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${estabelecimento}" var="estabelecimento">
                  <tr>
                     <td>
                        <c:out value="${estabelecimento.razaoSocial}" />
                     </td>
                     <td>
                        <c:out value="${estabelecimento.cnpj}" />
                     </td>     
                        <td><a href='ControlEstabelecimento?action=Edit&idEstab=<c:out value="${estabelecimento.idEstab}"/>&cod=<c:out value="${estabelecimento.cnpj}"/>'><button class="btn btn-success" style="height: 2.2em;"> Editar <img src="img/edit.svg" style="width: 21px; height: 21px; " title="EXCLUIR"></button></a></td>
                 		<td><a href='ControlEstabelecimento?action=Delete&idEstab=<c:out value="${estabelecimento.idEstab}"/>&cod=<c:out value="${estabelecimento.cnpj}"/>'><button class="btn btn-success" style="height: 2.2em;"> Excluir <img src="img/trash-2.svg" style="width: 21px; height: 21px; " title="EXCLUIR"></button></a></td>
                      </tr>
               </c:forEach>  
            </tbody>
         </table>
      </f:view>
   </body>
</html>