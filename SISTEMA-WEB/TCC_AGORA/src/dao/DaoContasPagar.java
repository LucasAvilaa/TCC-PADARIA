package dao;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import factory.Conexao;
import model.TbCliente;
import model.TbCompra;
import model.TbCompraProduto;
import model.TbContasPagar;
import model.TbProduto;

public class DaoContasPagar {

	Conexao con;
	public boolean crudContaPagar(String acao, TbContasPagar pagar, TbCompra compra) throws Exception {
		con = new Conexao(); 
		PreparedStatement ps = null;
		
		if(acao.equals("I")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR I,NULL,?,?"); 
			ps.setInt(1, compra.getIdCompra());
			ps.setDate(2, new java.sql.Date(pagar.getDataVencimento().getTime()));	
		}		
		else if(acao.equals("A")) { 			
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR A,?,?,?");
			ps.setInt(1, pagar.getIdPagar());
			ps.setInt(2, compra.getIdCompra());
			ps.setDate(3, new java.sql.Date(pagar.getDataVencimento().getTime()));	
		}else if(acao.equals("E")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR E,?,NULL,NULL");  
			ps.setInt(1, pagar.getIdPagar()); 
		}	
		if(ps.executeUpdate()>0) { 
			ps.close();
			return true;			
		}else {
			return false;
		}
	 }
	
	public TbCompraProduto ContaPagarPorId(Integer pagar) {
			TbCompraProduto produto = new TbCompraProduto();
			TbCompra compra = new TbCompra();
			TbProduto prod = new TbProduto();
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM VW_CONTAS_PAGAR WHERE ID_COMPRA_PRODUTO = ?"); 
				ps.setInt(1, pagar);
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					compra.setIdCompra(Integer.parseInt( rs.getString("ID_COMPRA_PRODUTO")));
					prod.setDescricaoProduto(rs.getString("DESCRICAO_PRODUTO"));
					prod.setValorUniCompra(new BigDecimal(rs.getString("VALOR_UNI_COMPRA")));
	
					produto.setTbCompra(compra);
					produto.setTbProduto(prod);
					produto.setId(Integer.parseInt(rs.getString("ID_PRODUTO")));
					produto.setQuantidade(Integer.parseInt(rs.getString("QUANTIDADE")));		 
				} 			
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return produto;
		}
	
	public List<TbCliente> listaContaPagar() {
		List<TbCliente> ListaContaPagar = new ArrayList<TbCliente>();	
		TbCompraProduto produto = new TbCompraProduto();
		TbCompra compra = new TbCompra();
		TbProduto prod = new TbProduto();
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM VW_CONTAS_PAGAR"); 
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) { 
				compra.setIdCompra(Integer.parseInt( rs.getString("ID_COMPRA_PRODUTO")));
				prod.setDescricaoProduto(rs.getString("DESCRICAO_PRODUTO"));
				prod.setValorUniCompra(new BigDecimal(rs.getString("VALOR_UNI_COMPRA")));

				produto.setTbCompra(compra);
				produto.setTbProduto(prod);
				produto.setId(Integer.parseInt(rs.getString("ID_PRODUTO")));
				produto.setQuantidade(Integer.parseInt(rs.getString("QUANTIDADE")));		 
			} 		
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return ListaContaPagar;
	}
}	