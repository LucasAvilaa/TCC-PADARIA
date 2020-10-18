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
    private static String criar_editar = "/CadastroCompra.jsp"; 
    private static String excluir_item = "ControlCompra?action=Edit&idCompra="; 
	private DaoCompra Dao;
	private String acao = null;  
	private Integer idCompra = null;
	private Integer idItem = null;
	private TbCompraProduto compralista = new TbCompraProduto();
 	private TbCompra compra = new TbCompra();
	private TbProduto produto = new TbProduto();
	
    public ControlCompra() {
        super(); 
        Dao = new DaoCompra();  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String forward = "";
		 String action = request.getParameter("action");  
		 String idCom = request.getParameter("idCompra"); 
		 String idIte = request.getParameter("idItem");
		 if(idCom != null) {  
			 idCompra = Integer.parseInt(idCom); 
			 compra.setIdCompra(idCompra);
		 }	
		 
		 if(idIte != null) {
			 idItem = Integer.parseInt(idIte);
			 produto.setIdProduto(idItem);
		 }
		 if(action.equalsIgnoreCase("Tabela")) {			 	
				 try {				
	 				request.setAttribute("compra", Dao.listaCompra()); 
					forward = tabela;
				} catch (Exception e) {
					e.printStackTrace();
				}		 
		 } 
		 
		else if(action.equalsIgnoreCase("EditCompra")){   
			request.setAttribute("compra", Dao.CompraPorId(compra)); 
			request.setAttribute("itens", Dao.itensPorCompra(compra));  
			acao = "A"; 
			forward = criar_editar;
		}
		 
		else if(action.equalsIgnoreCase("CriarCompra"))  {
			forward = criar_editar;  
			System.out.println("STATUS: " + compra.getStatus());
			acao = "IC";
		}	
		
		else if(action.equalsIgnoreCase("DeleteCompra")) {
			acao = "EC";
			try {
				if(Dao.crudCompra(acao, compralista, compra, produto)) {
					System.out.println("COMPRA EXCLUIDA COM SUCESSO. ID COMPRA: " + compra.getIdCompra());
				}
				else{
					System.out.println("ERRO AO EXCLUIR COMPRA. ID COMPRA: " + compra.getIdCompra());
				}
				forward = tabela;
			} catch (Exception e) { 
				e.printStackTrace();
			}
		}
		 
		else if (action.equalsIgnoreCase("DeleteItens")) { 
			try {
				acao = "EI"; 
				if(Dao.crudCompraItens(acao, compralista, compra, produto)) {
					System.out.println("COMPRA:" +compra.getIdCompra()+ " ITEM EXCLUIDO COM SUCESSO: " + produto.getIdProduto());
				}
				else {
					System.out.println("COMPRA:" +compra.getIdCompra()+ " FALHA AO EXCLUIR ITEM: " + produto.getIdProduto());
				}
				forward = excluir_item + compra.getIdCompra();
				 
			} catch (Exception e) { 
				e.printStackTrace();
			} 
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
				   
				 	
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ERRO AO INSERIR COMPRA");
			}
			  response.sendRedirect("ControlCompra?action=Tabela");		
	}	
}