package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbFornecedores;

public class DaoFornecedores {
 
		Conexao con;
	public boolean crudFornecedor(String acao, TbFornecedores forn) throws Exception {
			con = new Conexao(); 
			PreparedStatement ps = null;
			 
			if(acao.equals("I")) { 
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FORNECEDORES I,NULL,?,?,?");
				ps.setString(1, forn.getCnpj());
				ps.setString(2, forn.getRazaoSocial());
				ps.setBoolean(3, forn.getAtivo());
			}				
			else if(acao.equals("A")) { 			
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FORNECEDORES A,?,?,?,?");
				ps.setString(1, forn.getIdForn());
				ps.setString(2, forn.getCnpj());
				ps.setString(3, forn.getRazaoSocial());
				ps.setBoolean(4, forn.getAtivo());
			}
			else if(acao.equals("E")){ 
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FORNECEDORES E,?,NULL,NULL,NULL");  
				ps.setString(1, forn.getIdForn());
			} 
			if(ps.executeUpdate()>0) { 
				ps.close();
				return true;			
			}else {
				return false;
			}
}
		
	public TbFornecedores fornecedorPorId(TbFornecedores id) {
			TbFornecedores forn = new TbFornecedores();
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_FORNECEDORES WHERE ID_FORN = ?"); 
				ps.setString(1, forn.getIdForn());
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					forn.setIdForn(rs.getString("ID_FORN"));
					forn.setCnpj(rs.getString("CPNJ"));
					forn.setRazaoSocial(rs.getString("RAZAO_SOCIAL"));
					forn.setAtivo(rs.getBoolean("ATIVO")); 							 
				} 	
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return forn;
		}
		
	public List<TbFornecedores> listaFornecedor() {
			List<TbFornecedores> listaforn = new ArrayList<TbFornecedores>();	
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_FORNECEDORES");  
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) {
					TbFornecedores forn = new TbFornecedores(); 
					
					forn.setIdForn(rs.getString("ID_FORN"));
					forn.setCnpj(rs.getString("CPNJ"));
					forn.setRazaoSocial(rs.getString("RAZAO_SOCIAL"));
					forn.setAtivo(rs.getBoolean("ATIVO")); 
								
					listaforn.add(forn);
				} 
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return listaforn;
		}	
}