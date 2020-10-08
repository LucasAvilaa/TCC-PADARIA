package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbCliente;

public class DaoCliente {

	Conexao con;
	public boolean crudCliente(String acao,TbCliente tbclientes) throws Exception {
		con = new Conexao(); 
		PreparedStatement ps = null;
		
		if(acao.equals("I")) {
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CLIENTE I,NULL,?,?,?,?,?,?,?"); 
			ps.setString(1, tbclientes.getNome());
			ps.setString(2, tbclientes.getSobrenome());
			ps.setString(3, tbclientes.getRg());
			ps.setString(4, tbclientes.getCpf());
			ps.setDate(5, new java.sql.Date(tbclientes.getDtNasc().getTime()));
			ps.setString(6, tbclientes.getSexo()); 
			ps.setBoolean(7, tbclientes.getAtivo());
		}		
		else if(acao.equals("A")) { 			
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CLIENTE A,?,?,?,?,?,?,?,?");
			ps.setString(1, tbclientes.getIdCli());
			ps.setString(2, tbclientes.getNome());
			ps.setString(3, tbclientes.getSobrenome());
			ps.setString(4, tbclientes.getRg());
			ps.setString(5, tbclientes.getCpf());
			ps.setDate(6, new java.sql.Date(tbclientes.getDtNasc().getTime()));
			ps.setString(7, tbclientes.getSexo()); 
			ps.setBoolean(8, tbclientes.getAtivo());
		}else if(acao.equals("E")){ 
			ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_CLIENTE E,?,NULL,NULL,NULL,NULL,NULL,NULL,NULL");  
			ps.setString(1, tbclientes.getIdCli());
		} 
		if(ps.executeUpdate() > 0) { 
			ps.close();
			return true;			
		}else {
			return false;
		}
}
	
	public TbCliente ClientePorId(TbCliente id) {
		TbCliente cliente = new TbCliente();
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CLIENTES WHERE ID_CLI=?"); 
			ps.setString(1, id.getIdCli());
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) { 
				cliente.setIdCli(rs.getString("ID_CLI"));
				cliente.setNome(rs.getString("NOME"));
				cliente.setSobrenome(rs.getString("SOBRENOME"));
				cliente.setRg(rs.getString("RG"));
				cliente.setCpf(rs.getString("CPF"));
				cliente.setDtNasc(rs.getDate("DT_NASC"));
				cliente.setAtivo(rs.getBoolean("ATIVO"));
				cliente.setSexo(rs.getString("SEXO"));	
				
			} 	
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return cliente;
}
	
	public List<TbCliente> listaCliente() {
		List<TbCliente> listacliente = new ArrayList<TbCliente>();	
		try {
			con = new Conexao();
			PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_CLIENTES"); 
			ResultSet rs = ps.executeQuery();
			
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
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	 
		return listacliente;
	}
}	