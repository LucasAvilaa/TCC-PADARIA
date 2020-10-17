package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbContasPagar;

public class DaoContasPagar {

	Conexao con;
	public boolean crudContaPagar(String acao, TbContasPagar pagar) throws Exception {
		con = new Conexao(); 
		PreparedStatement ps = null;
		
		if(acao.equals("I")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR I,NULL,?,?,?,?");  
			ps.setString(1, pagar.getDescricao());
			ps.setString(2, pagar.getCategoria());
			ps.setBigDecimal(3, pagar.getValorPagar());
			ps.setDate(4, new java.sql.Date(pagar.getDataVencimento().getTime()));	
		}		
		else if(acao.equals("A")) { 			
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR A,?,?,?,?,?");
			ps.setInt(1, pagar.getIdPagar()); 
			ps.setString(2, pagar.getDescricao());
			ps.setString(3, pagar.getCategoria());
			ps.setBigDecimal(4, pagar.getValorPagar());
			ps.setDate(5, new java.sql.Date(pagar.getDataVencimento().getTime()));	
		}else if(acao.equals("E")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_PAGAR E,?,NULL,NULL,NULL,NULL");  
			ps.setInt(1, pagar.getIdPagar()); 
		}	
		if(ps.executeUpdate()>0) { 
			ps.close();
			return true;			
		}else {
			return false;
		}
	 }
	
	public TbContasPagar ContaPagarPorId(TbContasPagar pagar) { 
			TbContasPagar contas = null;
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CONTAS_PAGAR"); 
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					 contas = new TbContasPagar(); 
					 contas.setDataVencimento(rs.getDate("DATA_VENCIMENTO")); 
					 contas.setIdPagar(rs.getInt("ID_PAGAR"));
					 contas.setDescricao(rs.getString("DESCRICAO"));
					 contas.setCategoria(rs.getString("CATEGORIA")); 
					 contas.setValorPagar(rs.getBigDecimal("VALOR_PAGAR")); 
					   
				} 			
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return contas;
		}
	
	public List<TbContasPagar> listaContaPagar() {
		List<TbContasPagar> ListaContaPagar = new ArrayList<TbContasPagar>();	 
		
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CONTAS_PAGAR"); 
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {  
				TbContasPagar contas = new TbContasPagar(); 
				 contas.setDataVencimento(rs.getDate("DATA_VENCIMENTO")); 
				 contas.setIdPagar(rs.getInt("ID_PAGAR"));
				 contas.setDescricao(rs.getString("DESCRICAO"));
				 contas.setCategoria(rs.getString("CATEGORIA")); 
				 contas.setValorPagar(rs.getBigDecimal("VALOR_PAGAR")); 
				 
				 ListaContaPagar.add(contas);
				 
			} 		
			 
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return ListaContaPagar;
	}
}	