package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DaoContasPagar;
import model.TbCompra;
import model.TbContasPagar;

@WebServlet(name = "venda", urlPatterns = { "/ControlVenda" })
public class ControlVenda extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String tabela = "/TabelaVenda.jsp";
	private static String criar_editar = "/venda.jsp";
	private DaoContasPagar Dao;
	private String acao = null;
	private Integer idCompra = null;
	private Integer idPagar = null;
	private TbContasPagar pagar = new TbContasPagar();
	private TbCompra compra = new TbCompra();

	public ControlVenda() {
		super();
		Dao = new DaoContasPagar();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward = "";
		String action = request.getParameter("action");
		String idComp = request.getParameter("idCompra");
		String idPag = request.getParameter("idPagar");
		if (idComp != null) {
			idCompra = Integer.parseInt(idComp);
			compra.setIdCompra(idCompra);
		}
		if (idPag != null) {
			idPagar = Integer.parseInt(idPag);
			pagar.setIdPagar(idPagar);
		}
		if (action.equalsIgnoreCase("tabela")) {
			try {
				request.setAttribute("conta", Dao.listaContaPagar());
				forward = tabela;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action.equalsIgnoreCase("delete")) {
			try {
				acao = "E";
				// Dao.crudContaPagar(acao, pagar, compra);
				request.setAttribute("conta", Dao.listaContaPagar());
				forward = tabela;

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (action.equalsIgnoreCase("edit")) {
			request.setAttribute("conta", Dao.ContaPagarPorId(pagar));
			acao = "A";
			forward = criar_editar;
		} else {
			forward = criar_editar;
			acao = "I";
		}
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		// pagar.setIdPagar(idPagar); ARRUMAR OS SET
		// pagar.setTbCompra(request.getparam);
		Date dataVencimento = null;
		if (request.getParameter("dataVencimento") != null) {
			try {
				dataVencimento = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("dataCadastro"));
				pagar.setDataVencimento(dataVencimento);
			} catch (ParseException e) {
				e.printStackTrace();
				System.out.println("ERRO NA CONVERS�O DA DATA");
			}
		}
		try {
			System.out.println("A��O: " + acao);
			if (acao.equals("I")) {
				// if(Dao.crudContaPagar(acao, pagar, compra)) {
				System.out.println("CRIADO COM SUCESSO");
			}
			// }
			else {
				pagar.setIdPagar(idPagar);
				// Dao.crudContaPagar(acao, pagar, compra);
				System.out.println("ALTERADO COM SUCESSO: " + pagar.getIdPagar());
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERRO AO INSERIR VENDA");
		}
		response.sendRedirect("ControlVenda?action=tabela");
	}
}