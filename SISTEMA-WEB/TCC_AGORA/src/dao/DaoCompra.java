package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbCompra;
import model.TbCompraProduto;
import model.TbFornecedore;
import model.TbProduto;

public class DaoCompra {

	Conexao con;
	public boolean crudCompra(String acao,TbCompraProduto compralista, TbCompra compra, TbProduto produto) throws Exception {
		con = new Conexao(); 
		PreparedStatement ps = null;
		
		if(acao.equals("IC")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_COMPRA_ESTAB IC,NULL,?,?"); 
			ps.setInt(1, compralista.getQuantidade());
			ps.setInt(2, produto.getIdProduto());			
		}		
		else if(acao.equals("II")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_COMPRA_ESTAB II,?,?,?"); 
			ps.setInt(1, compra.getIdCompra());
			ps.setInt(2, produto.getIdProduto());			
			ps.setInt(3, compralista.getQuantidade());
		}
		else if(acao.equals("A")) { 			
			ps = con.getConexao().prepareStatement("EXEC PROC_COMPRA_ESTAB A,?,NULL,?");
			ps.setInt(1, compra.getIdCompra()); 
			ps.setInt(2, produto.getIdProduto());			
			ps.setInt(3, compralista.getQuantidade());
		}
		else if(acao.equals("EI")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_COMPRA_ESTAB EI,?,?,NULL");  
			ps.setInt(1, compra.getIdCompra()); 
			ps.setInt(2, produto.getIdProduto());			
		}
		else if(acao.equals("EC")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_COMPRA_ESTAB EC,?,NULL,NULL");   
			ps.setInt(1, compra.getIdCompra());
		} 
		if(ps.executeUpdate()>0) { 
			ps.close();
			return true;			
		}else {
			return false;
		}
}
 
	 
		public TbCompra CompraPorId(TbCompra id) {
			TbCompra compra = new TbCompra(); 
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_COMPRAS WHERE ID_COMPRA = ?"); 
				ps.setInt(1, id.getIdCompra());
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					compra.setIdCompra(rs.getInt("ID_COMPRA"));
					if(rs.getString("STATUS").equals("F")) {
						compra.setStatus("FINALIZADO");
					}else {
						compra.setStatus("PENDENTE");
					} 
					compra.setDataCriada(rs.getDate("DATA_CRIADA"));
					compra.setDataFinalizada(rs.getDate("DATA_FINALIZADA"));   
				} 			
				
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return compra;
		}
		
		public TbCompraProduto itensPorCompra(TbCompra id) {
			TbCompraProduto itens = new TbCompraProduto();
			TbProduto produto = new TbProduto();
			TbFornecedore fornecedor = new TbFornecedore(); 
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM VW_COMPRA WHERE ID_COMPRA = ?"); 
				ps.setInt(1, id.getIdCompra());
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					itens.setQuantidade(rs.getInt("QUANTIDADE"));
					
					produto.setNomeProduto(rs.getString("NOME_PRODUTO"));
					produto.setValorUniCompra(rs.getBigDecimal("VALOR_UNI_COMPRA"));
					
					fornecedor.setRazaoSocial(rs.getString("RAZAO_SOCIAL"));
					produto.setTbFornecedore(fornecedor);
					itens.setTbProduto(produto); 
				} 			
				
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return itens;
		}
		
		
		
	 
	public List<TbCompra> listaCompra() {
		List<TbCompra> listaCompra = new ArrayList<TbCompra>();	
		
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_COMPRAS");
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				TbCompra compra = new TbCompra(); 
				compra.setIdCompra(rs.getInt("ID_COMPRA")); 
				if(rs.getString("STATUS").equals("F")) {
					compra.setStatus("FINALIZADO");
				}else {
					compra.setStatus("PENDENTE");
				}
				compra.setDataCriada(rs.getDate("DATA_CRIADA"));
				compra.setDataFinalizada(rs.getDate("DATA_FINALIZADA")); 
				
				listaCompra.add(compra);
			} 			
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return listaCompra;
	}  	
}