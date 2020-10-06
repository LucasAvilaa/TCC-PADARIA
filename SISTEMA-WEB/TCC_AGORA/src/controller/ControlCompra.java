package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DaoCompra;
import model.TbCompra;
import model.TbCompraProduto;
import model.TbProduto;

/**
 * Servlet implementation class ControlCliente2
 */
@WebServlet(name = "compra", urlPatterns={"/ControlCompra"})
public class ControlCompra extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static String tabela = "/TabelaCompra.jsp";
    private static String criar_editar = "/compra.jsp"; 
	private DaoCompra Dao;
	private String acao = null;  
	private TbCompraProduto compralista = new TbCompraProduto();
 	private TbCompra compra = new TbCompra();
	private TbProduto produto = new TbProduto();
	
    public ControlCompra() {
        super(); 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String forward = "";
		 String action = request.getParameter("action");  
		 String idCli = request.getParameter("idCli"); 
		 if(idCli != null) {  
//			 idcli = String.valueOf(idCli); 
//			 cliente.setIdCli(idcli);
		 }		 
		 if(action.equalsIgnoreCase("Tabela")) {			 	
				 try {				
	//				request.setAttribute("cliente", Dao.listaCliente()); 
					forward = tabela;
				} catch (Exception e) {
					e.printStackTrace();
				}		 
		 }
		 else if(action.equalsIgnoreCase("DeletarItem")) { 
					try { 
						Dao.crudCompra("EI", compralista, compra, produto); 
//						request.setAttribute("cliente", Dao.listaCliente());
						forward = tabela;
						
					} catch (Exception e) {
						e.printStackTrace();
					}
		 }
		 else if(action.equalsIgnoreCase("DeletarCompra")) { 
				try { 
					Dao.crudCompra("EC", compralista, compra, produto); 
//					request.setAttribute("cliente", Dao.listaCliente());
					forward = tabela;
					
				} catch (Exception e) {
					e.printStackTrace();
				}
	 }
		else if(action.equalsIgnoreCase("Editar")){   
//			request.setAttribute("compra", Dao.CompraPorId(compra.getId())); 
			acao = "A"; 
			forward = criar_editar;
		}
		 
		else if(action.equalsIgnoreCase("CriarCompra"))  {
			forward = criar_editar;
			acao = "IC";
		}		 
		 RequestDispatcher view = request.getRequestDispatcher(forward);
		 view.forward(request, response);
	}
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			 compralista.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
			 produto.setIdProduto(Integer.parseInt(request.getParameter("idProd")));
			 
			 try {
				 System.out.println("A��O: " + acao );
				 if(acao.equals("IC")) {	
					 	 Dao.crudCompra(acao, compralista, compra, produto);
						 System.out.println("CRIADO COM SUCESSO");
						 	}	 
				 if(request.getParameter("idCompra") != null) {
					 compra.setIdCompra(Integer.parseInt(request.getParameter("idCompra")));
					 if(acao.equals("II")) {
						 Dao.crudCompra(acao, compralista, compra, produto);
					 }		
				 }
				 	
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ERRO AO INSERIR COMPRA");
			}
			  response.sendRedirect("ControlCompra?action=Tabela");		
	}	
}