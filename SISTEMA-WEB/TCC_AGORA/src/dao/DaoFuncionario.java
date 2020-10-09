package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import factory.Conexao;
import model.TbFuncionario;

public class DaoFuncionario {
 
		Conexao con;
	public boolean crudFuncionario(String acao,TbFuncionario func) throws Exception {
			con = new Conexao(); 
			PreparedStatement ps = null;
			
			if(acao.equals("I")) {
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FUNCIONARIOS I,NULL,?,?,?,?,?,?,?,?"); 
				ps.setString(1, func.getNome());
				ps.setString(2, func.getSobrenome());
				ps.setString(3, func.getRg());
				ps.setString(4, func.getCpf());
				ps.setDate(5, new java.sql.Date(func.getDtNasc().getTime()));
				ps.setString(6, func.getSexo()); 
				ps.setString(7, func.getCargo());
				ps.setBoolean(8, func.getAtivo());
			}				
			else if(acao.equals("A")) { 			
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FUNCIONARIOS A,?,?,?,?,?,?,?,?,?");
				ps.setString(1, func.getIdFunc());
				ps.setString(2, func.getNome());
				ps.setString(3, func.getSobrenome());
				ps.setString(4, func.getRg());
				ps.setString(5, func.getCpf());
				ps.setDate(6, new java.sql.Date(func.getDtNasc().getTime()));
				ps.setString(7, func.getSexo());
				ps.setString(8, func.getCargo());
				ps.setBoolean(9, func.getAtivo());
			}
			else if(acao.equals("E")){ 
				ps = con.getConexao().prepareStatement("EXEC PROC_CRUD_FUNCIONARIOS E,?,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL");  
				ps.setString(1, func.getIdFunc());
			} 
			if(ps.executeUpdate()>0) { 
				ps.close();
				return true;			
			}else {
				return false;
			}
}
	
	public TbFuncionario funcionarioPorId(TbFuncionario id) {
				TbFuncionario func = new TbFuncionario();
				try {
					con = new Conexao();
					PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_FUNCIONARIOS WHERE ID_FUNC=?"); 
					ps.setString(1, id.getIdFunc());
					ResultSet rs = ps.executeQuery();
					
					while (rs.next()) { 
						func.setIdFunc(rs.getString("ID_FUNC"));
						func.setNome(rs.getString("NOME"));
						func.setSobrenome(rs.getString("SOBRENOME"));
						func.setRg(rs.getString("RG"));
						func.setCpf(rs.getString("CPF"));
						func.setCargo(rs.getString("CARGO"));
						func.setDtNasc(rs.getDate("DT_NASC"));
						func.setAtivo(rs.getBoolean("ATIVO"));
						if(rs.getString("SEXO").equals("M")) {
							func.setSexo("MASCULINO");	
						}else {
							func.setSexo("FEMININO");
						}  
					} 	
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}	 
				return func;
			}
	
	public List<TbFuncionario> listaFuncionario() {
			List<TbFuncionario> listafunc = new ArrayList<TbFuncionario>();	
			try {
				con = new Conexao();
				PreparedStatement ps = con.getConexao().prepareStatement("SELECT * FROM TB_FUNCIONARIOS"); 
				ResultSet rs = ps.executeQuery();
				
				while (rs.next()) {
					TbFuncionario func = new TbFuncionario(); 
					
					func.setIdFunc(rs.getString("ID_FUNC"));
					func.setNome(rs.getString("NOME"));
					func.setSobrenome(rs.getString("SOBRENOME"));
					func.setRg(rs.getString("RG"));
					func.setCpf(rs.getString("CPF"));
					func.setCargo(rs.getString("CARGO"));
					func.setDtNasc(rs.getDate("DT_NASC"));
					func.setAtivo(rs.getBoolean("ATIVO"));
					func.setSexo(rs.getString("SEXO"));
								
					listafunc.add(func);
				} 	
				ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
			return listafunc;
		}
	
}
