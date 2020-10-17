package controller;

import dao.daoEnderecoContato;
import model.TbContato;
import model.TbEndereco;

public class controlEndCont {
	
	public boolean controlEndConta(String acao, String bairro, String cep,  String cidade, Integer numero,  String rua,  String estado,  String email,  String numeroTel, boolean numeroAtivo, String cpf) throws Exception {
		TbEndereco modelEnd = new TbEndereco();
		modelEnd.setBairro(bairro);
		modelEnd.setCep(cep);
		modelEnd.setCidade(cidade);
		modelEnd.setEstado(estado);
		modelEnd.setNumero(numero);
		modelEnd.setRua(rua); 
		
		TbContato modelCont = new TbContato();
		modelCont.setEmail(email);
		modelCont.setNumero(numeroTel);
		modelCont.setNumeroAtivo(numeroAtivo); 
		
		daoEnderecoContato crud = new daoEnderecoContato();
		if(crud.crudEndCont(acao, modelEnd, modelCont, cpf)) {
			return true;
		}		
		return false;
	}	
}