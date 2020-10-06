package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbComanda;
import model.TbContasReceber;

public class DaoContasReceber {

	Conexao con;
	public boolean crudContasReceber(String acao, TbContasReceber receber, TbComanda comanda) throws Exception {
		con = new Conexao(); 
		PreparedStatement ps = null;
		
		if(acao.equals("I")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_RECEBER I,NULL,?,?,?,?,?,?"); 
			ps.setString(1, receber.getMetodoPagamento());
			ps.setBigDecimal(2, receber.getDinheiro());
			ps.setBigDecimal(3, receber.getDebito());
			ps.setBigDecimal(4, receber.getCredito());
			ps.setDate(5, new java.sql.Date(receber.getDataCompra().getTime()));
			ps.setDate(6, new java.sql.Date(receber.getDataPrevistaReceber().getTime()));
		}		
		else if(acao.equals("A")) { 			
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_RECEBER A,?,?,?,?,?,?,?");
			ps.setInt(1, comanda.getIdComanda());
			ps.setString(2, receber.getMetodoPagamento());
			ps.setBigDecimal(3, receber.getDinheiro());
			ps.setBigDecimal(4, receber.getDebito());
			ps.setBigDecimal(5, receber.getCredito());
			ps.setDate(6, new java.sql.Date(receber.getDataCompra().getTime()));
			ps.setDate(7, new java.sql.Date(receber.getDataPrevistaReceber().getTime())); 
		}else if(acao.equals("E")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CONTAS_RECEBER E,?,NULL,NULL,NULL,NULL,NULL,NULL");  
			ps.setInt(1, comanda.getIdComanda()); 
		} 
		if(ps.executeUpdate()>0) { 
			ps.close();
			return true;			
		}		
		else {
			return false;
		}		
}
	
	public TbContasReceber ContaReceberPorId(Integer id) {
			TbContasReceber receber = new TbContasReceber();
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CONTAS_RECEBER WHERE ID_COMANDA_RECEBER=?"); 
				ps.setInt(1, id);
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					receber.setIdReceber(Integer.parseInt(rs.getString("ID_RECEBER")));
					receber.setCredito(rs.getBigDecimal("CREDITO")); 	
					receber.setDebito(rs.getBigDecimal("DEBITO")); 
					receber.setDinheiro(rs.getBigDecimal("DINHEIRO"));
					receber.setDataCompra(rs.getDate("DATA_COMPRA"));
					receber.setDataPrevistaReceber(rs.getDate("DATA_PREVISTA_RECEBER"));
					receber.setMetodoPagamento(rs.getString("METODO_PAGAMENTO"));
				} 
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return receber;
		}
		
	public List<TbContasReceber> ListaReceber() {
		List<TbContasReceber> ListaContaReceber = new ArrayList<TbContasReceber>();	
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CONTAS_RECEBER");
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				TbContasReceber receber = new TbContasReceber();
				TbComanda comanda = new TbComanda();
				
				comanda.setIdComanda(Integer.parseInt(rs.getString("ID_COMANDA_RECEBER")));
				receber.setTbComanda(comanda);
				
				receber.setIdReceber(Integer.parseInt(rs.getString("ID_RECEBER")));				
				receber.setCredito(rs.getBigDecimal("CREDITO")); 	
				receber.setDebito(rs.getBigDecimal("DEBITO")); 
				receber.setDinheiro(rs.getBigDecimal("DINHEIRO"));
				receber.setDataCompra(rs.getDate("DATA_COMPRA"));
				receber.setDataPrevistaReceber(rs.getDate("DATA_PREVISTA_RECEBER"));
				receber.setMetodoPagamento(rs.getString("METODO_PAGAMENTO"));
							
				ListaContaReceber.add(receber);
			} 	
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
			e.getClass();
		}	 
		return ListaContaReceber;
	}
}	