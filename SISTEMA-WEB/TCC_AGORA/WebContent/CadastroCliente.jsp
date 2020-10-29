<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>CADASTRO DE CLIENTE</title>
      <link rel="shortcut icon" href="img/Logo_Padaria.png"/>
      <link rel="stylesheet" type="text/css" href="css/CadastroCliente.css">
      <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
      <script type="text/javascript" src="js/javascript.js"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
   </head>
   <body> 
   	<%
   		String usuario = (String) session.getAttribute("usuario");
   		if(usuario == null){
   			response.sendRedirect("Login.xhtml");
   		}
   	%>
      <jsp:include page="index.jsp" flush="false">
         <jsp:param name="cabecalho" value="cabecalho"/>
      </jsp:include>
      <f:view>
         <form action="ControlCliente" method="POST" name="cadastroCliente">
            
            	<h1 class="text-center margintop" style="margin-top: 0.4em;"><span class="badge badge-secondary text-center;">Cadastro de Clientes</span></h1>
           			<div class="card border bg-dark text-white" style="background-color: #fff;  margin-top: 15px; position: relative;left: 33%; width: 27em; font-family: sans-serif">
           
            
            <br />
            <p><input value="ENVIAR" type="submit" id="btn"  class="btn btn-success" style="width: 10em; height: 2.5em; margin-right:0.4em; margin-left: 3em"> <a href="ControlCliente?action=Tabela"  class="btn btn-danger" style="width: 10em; height: 2.5em;">CANCELAR</a> </p>
            <fieldset id="informacoes">
               <legend style="text-align:center; margin-top: 1em; margin-bottom: 1em;" class="bg-light text-dark">INFORMAÇÕES BÁSICAS </legend>
               <p style="text-align: center">
                  <label>
                     NOME: <input name="nome"  maxlength="50" value="<c:out value="${cliente.nome}"/>" required="required" style="width: 364px; "/>
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     SOBRENOME: <input name="sobrenome" maxlength="50" value="<c:out value="${cliente.sobrenome}"/>" required="required" style="width: 314px; "/>
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     CPF: <input name="cpf" id="cpf" value="<c:out value="${cliente.cpf}"/>" placeholder="xxx.xxx.xxx-xx" required="required" style="width: 163px; "/>
                  </label>
                  <label>
                     RG: <input name="rg" id="rg" value="<c:out value="${cliente.rg}"/>" placeholder="xx.xxx.xxx-x"  required="required" style="width: 179px; "/>
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     NASCIMENTO: <input name="data" type="date" id="data" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${cliente.dtNasc}"/>" required="required" style="width: 148px; ">
                  </label>
                  <label>
                     SEXO: 
                     <h:selectOneMenu style="width: 106px; height: 24px" id="sexo">
                        <f:selectItem itemValue="#{cliente.sexo}"/>
                        <f:selectItem noSelectionOption="true" itemValue="_________" itemDisabled="true"/>
                        <f:selectItem itemValue="M" itemLabel="MASCULINO"/>
                        <f:selectItem itemValue="F" itemLabel="FEMININO"/>
                     </h:selectOneMenu>
                  </label>
               </p>
            </fieldset>
            <fieldset id="endereco">
               <legend>ENDEREÇO</legend>
               <p style="text-align: center">
                  <label>
                     CEP: <input type="text" name="cep" id="cep" style="width: 100px; "  value="<c:out value="${endereco.cep}"/>"> 
                  </label>
                  <label>
                     CIDADE: <input type="text" name="cidade" readonly="readonly"  style="width: 205px; "value="<c:out value="${endereco.cidade}"/>">
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     BAIRRO: <input type="text" name="bairro"  readonly="readonly" contenteditable="true" style="width: 232px; "value="<c:out value="${endereco.bairro}"/>">
                  </label>
                  <label>
                     ESTADO: <input type="text" name="estado" readonly="readonly"style="width: 40px; "  value="<c:out value="${endereco.estado}"/>">
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     RUA: <input type="text" name="rua" readonly="readonly" style="width: 221px; "value="<c:out value="${endereco.rua}"/>">
                  </label>
                  <label>
                     NÚMERO: <input type="number" name="numero" style="width: 69px; "value="<c:out value="${endereco.numero}"/>">
                  </label>
               </p>
            </fieldset>
            <fieldset id="contato">
               <legend>CONTATO</legend>
               <p style="text-align: center">
                  <label>
                     EMAIL: <input type="text" name="email" style="width: 354px; "value="<c:out value="${contato.email}"/>" placeholder="seuemail@email.com">
                  </label>
               </p>
               <p style="text-align: center">
                  <label>
                     CELULAR: <input type="text" id="celular" name="celular" style="width: 174px; "value="<c:out value="${contato.numero}"/>" placeholder="(XX) XXXXX-XXXX ">
                  </label>	
               </p>
            </fieldset>
            </div>
         </form>
      </f:view> 
   </body>  
 <script>	
     $("#cep").mask("99999-999"); 
     $("#celular").mask("(99)99999-9999");
     $("#rg").mask("99.999.999-9");
     $("#cpf").mask("999.999.999-99");
     
     const $campoCep = document.querySelector('[name=cep]');
     
     const $campoCidade = document.querySelector('[name=cidade]');
     const $campoRua = document.querySelector('[name=rua]');
     const $campoEstado = document.querySelector('[name=estado]');
     const $campoBairro = document.querySelector('[name=bairro]');
     
     $campoCep.addEventListener("blur", informacoes => {
      	const cep = informacoes.target.value;	
        	
     	fetch(`https://viacep.com.br/ws/`+cep+`/json/`)
     	.then(respostaDoServer => {			
     	return respostaDoServer.json();  
     	})
     	.then(dadosDoCep => {
     	console.log(dadosDoCep); 
     	$campoCidade.value = dadosDoCep.localidade;
     	$campoBairro.value = dadosDoCep.bairro;
     	$campoRua.value = dadosDoCep.logradouro;
     	$campoEstado.value = dadosDoCep.uf;
     
     });
     }); 
 	</script> 
</html>	