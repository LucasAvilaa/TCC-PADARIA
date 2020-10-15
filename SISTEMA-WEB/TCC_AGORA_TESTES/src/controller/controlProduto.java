package controller;

import java.math.BigDecimal;
import java.sql.Timestamp;

import dao.daoProdutos;
import model.TbProduto;

public class controlProduto {
	
	public boolean controlProd( String acao, String categoria, Timestamp dataCadastro, String descricaoProduto, String nomeProduto, BigDecimal valorUniCompra, BigDecimal valorUniVenda, Integer idProduto) throws Exception {
		TbProduto model = new TbProduto();
		model.setCategoria(categoria);
		model.setDataCadastro(dataCadastro);
		model.setDescricaoProduto(descricaoProduto);
		model.setNomeProduto(nomeProduto);
		model.setValorUniCompra(valorUniCompra);
		model.setValorUniVenda(valorUniVenda);
		model.setIdProduto(idProduto);
		
		daoProdutos dao = new daoProdutos();
		
		if(dao.crudProdutos(acao, model)) {
			return true;
		}else {
			return false;
		}
	}
}