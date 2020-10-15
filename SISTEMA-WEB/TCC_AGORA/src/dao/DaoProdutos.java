package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbProduto;

public class DaoProdutos {
 
		Conexao con;
	public boolean crudProduto(String acao,TbProduto prod) throws Exception {
			con = new Conexao(); 
			PreparedStatement ps = null;			
			
			if(acao.equals("I")) {
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_PRODUTOS I,NULL,?,?,?,?,?,?"); 
				ps.setString(1, prod.getNomeProduto());
				ps.setString(2, prod.getDescricaoProduto());
				ps.setString(3, prod.getCategoria());
				ps.setBigDecimal(4, prod.getValorUniCompra());
				ps.setBigDecimal(5,  prod.getValorUniVenda());
				ps.setDate(6, new java.sql.Date(prod.getDataCadastro().getTime()));
				 
			}				
			else if(acao.equals("A")) { 			
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_PRODUTOS I,?,?,?,?,?,?,?");
				ps.setInt(1, prod.getIdProduto());
				ps.setString(2, prod.getNomeProduto());
				ps.setString(3, prod.getDescricaoProduto());
				ps.setString(4, prod.getCategoria());
				ps.setBigDecimal(5, prod.getValorUniCompra());
				ps.setBigDecimal(6,  prod.getValorUniVenda());
				ps.setDate(7, new java.sql.Date(prod.getDataCadastro().getTime()));
			}
			else if(acao.equals("E")){ 
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_PRODUTOS E,?,NULL,NULL,NULL,NULL,NULL,NULL");  
				ps.setInt(1, prod.getIdProduto());
			} 
			if(ps.executeUpdate()>0) { 
				ps.close();
				return true;			
			}else {
				return false;
			}
}
		
	public TbProduto produtoPorId(TbProduto id) {
				TbProduto produto = new TbProduto();
				try {
					con = new Conexao();
					PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_PRODUTOS WHERE ID_PRODUTO=?"); 
					ps.setInt(1, id.getIdProduto());
					ResultSet rs = ps.executeQuery();
					
					while (rs.next()) { 
						produto.setIdProduto(rs.getInt("ID_PRODUTO"));
						produto.setIdProduto(rs.getInt("ID_FORN_PROD"));
						produto.setNomeProduto(rs.getString("NOME_PRODUTO"));
						produto.setDescricaoProduto(rs.getString("DESCRICAO_PRODUTO"));
						produto.setCategoria(rs.getString("CATEGORIA"));
						produto.setValorUniCompra(rs.getBigDecimal("VALOR_UNI_COMPRA"));
						produto.setValorUniVenda(rs.getBigDecimal("VALOR_UNI_VENDA"));
						produto.setDataCadastro(rs.getDate("DATA_CADASTRO"));							 
					}
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("ERRO AO BUSCAR PRODUTO POR ID ");
				}	 
				
				return produto;
			}
		
	public List<TbProduto> listaProdutos() {
			List<TbProduto> listaprod = new ArrayList<TbProduto>();	
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_PRODUTOS"); 
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) {
					TbProduto produto = new TbProduto(); 
					
					produto.setIdProduto(rs.getInt("ID_PRODUTO"));
					produto.setIdProduto(rs.getInt("ID_FORN_PROD"));
					produto.setNomeProduto(rs.getString("NOME_PRODUTO"));
					produto.setDescricaoProduto(rs.getString("DESCRICAO_PRODUTO"));
					produto.setCategoria(rs.getString("CATEGORIA"));
					produto.setValorUniCompra(rs.getBigDecimal("VALOR_UNI_COMPRA"));
					produto.setValorUniVenda(rs.getBigDecimal("VALOR_UNI_VENDA"));
					produto.setDataCadastro(rs.getDate("DATA_CADASTRO"));	
			 			
					listaprod.add(produto);
				} 	
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ERRO AO BUSCAR A LISTA PRODUTO ");
			}	 
			return listaprod;
		}
	
}
