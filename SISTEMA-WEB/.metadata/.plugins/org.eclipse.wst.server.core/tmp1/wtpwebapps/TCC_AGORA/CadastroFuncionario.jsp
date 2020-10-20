<%@taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>CADASTRO DE FUNCIONÁRIOS</title>
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
         <form action="ControlFuncionario" method="POST" name="cadastrofuncionario">
           
            	<h2>CADASTRO DE FUNCIONÁRIOS</h2>
            
           
            <br />
            <p><input value="ENVIAR" type="submit" id="btn"> <a href="ControlFuncionario?action=tabela">CANCELAR</a> </p>
            <fieldset id="informacoes">
               <legend>INFORMAÇÕES BÁSICAS </legend>
               <p>
                  <label>
                     NOME: <input name="nome"  maxlength="50" value="<c:out value="${funcionario.nome}"/>" required="required" style="width: 364px; "/>
                  </label>
               </p>
               <p>
                  <label>
                     SOBRENOME: <input name="sobrenome" maxlength="50" value="<c:out value="${funcionario.sobrenome}"/>" required="required" style="width: 314px; "/>
                  </label>
               </p>
               <p>
                  <label>
                     CPF: <input name="cpf" id="cpf" value="<c:out value="${funcionario.cpf}"/>" placeholder="xxx.xxx.xxx-xx" required="required" style="width: 163px; "/>
                  </label>
                  <label>
                     RG: <input name="rg" id="rg" value="<c:out value="${funcionario.rg}"/>" placeholder="xx.xxx.xxx-x"  required="required" style="width: 179px; "/>
                  </label>
               </p>
               <p>
                  <label>
                     NASCIMENTO: <input name="data" type="date" id="data" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${funcionario.dtNasc}"/>"   required="required" style="width: 148px; ">
                  </label>
                  <label>
                     SEXO: 
                     <h:selectOneMenu style="width: 106px; height: 24px" id="sexo">
                        <f:selectItem itemValue="#{funcionario.sexo}"/>
                        <f:selectItem noSelectionOption="true" itemValue="_________" itemDisabled="true"/>
                        <f:selectItem itemValue="M" itemLabel="MASCULINO"/>
                        <f:selectItem itemValue="F" itemLabel="FEMININO"/>
                     </h:selectOneMenu>
                  </label>
               </p>
               <p>
                  <label>
                     <h:outputText value="CARGO: "/>
                     <h:selectOneMenu style="width: 166px; " id="cargo">
                        <f:selectItem noSelectionOption="true" itemValue="#{funcionario.cargo}"/>
                        <f:selectItems value="#{tbHierarquia.hierarquia}"  itemValue="#{tbHierarquia.hierarquia}"/>
                     </h:selectOneMenu>
                  </label>
               </p>
            </fieldset>
           <fieldset id="endereco">
               <legend>ENDEREÇO</legend>
               <p>
                  <label>
                     CEP: <input type="text" name="cep" id="cep" style="width: 100px; "  value="<c:out value="${endereco.cep}"/>"> 
                  </label>
                  <label>
                     CIDADE: <input type="text" name="cidade" readonly="readonly"  style="width: 205px; "value="<c:out value="${endereco.cidade}"/>">
                  </label>
               </p>
               <p>
                  <label>
                     BAIRRO: <input type="text" name="bairro"  readonly="readonly" contenteditable="true" style="width: 232px; "value="<c:out value="${endereco.bairro}"/>">
                  </label>
                  <label>
                     ESTADO: <input type="text" name="estado" readonly="readonly"style="width: 40px; "  value="<c:out value="${endereco.estado}"/>">
                  </label>
               </p>
               <p>
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
               <p>
                  <label>
                     EMAIL: <input type="text" name="email" style="width: 354px; "value="<c:out value="${contato.email}"/>" placeholder="seuemail@email.com">
                  </label>
               </p>
               <p>
                  <label>
                     CELULAR: <input type="text" id="celular" name="celular" style="width: 174px; "value="<c:out value="${contato.numero}"/>" placeholder="(XX) XXXXX-XXXX ">
                  </label>
               </p>
            </fieldset>
         </form>
      </f:view>
   </body>
   <script>	
      $("#cep").mask("99999-999");
      //	$("#data").mask("99/99/9999");
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