package dao;

import java.sql.PreparedStatement;

import factory.Conexao;
import model.TbCompra;
import model.TbCompraProduto;
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

/*   ARRUMAR DAQUI PRA BAIXO -- TEM UMA VIEW PARA ISSO 
	 
		public TbCompra CompraPorId(TbCompra id) {
			TbCompra cliente = new TbCompra();
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CLIENTES WHERE ID_CLI=?"); 
				ps.setInt(1, id.getIdCompra());
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) { 
					
					 							 
				} 			
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return cliente;
		}
	
	public List<TbCliente> listaCliente() {
		List<TbCliente> listacliente = new ArrayList<TbCliente>();	
		try {
			con = new Conexao();
			Statement stmt = con.getConexao().createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM VW_COMPRA");
			
			while (rs.next()) {
				TbCliente cliente = new TbCliente(); 
				
				cliente.setIdCli(rs.getString("ID_CLI"));
				cliente.setNome(rs.getString("NOME"));
				cliente.setSobrenome(rs.getString("SOBRENOME"));
				cliente.setRg(rs.getString("RG"));
				cliente.setCpf(rs.getString("CPF"));
				cliente.setDtNasc(rs.getDate("DT_NASC"));
				cliente.setAtivo(rs.getBoolean("ATIVO"));
				cliente.setSexo(rs.getString("SEXO"));
				
							
				listacliente.add(cliente);
			} 			
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return listacliente;
	}
*/	
}