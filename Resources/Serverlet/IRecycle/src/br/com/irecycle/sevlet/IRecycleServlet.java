package br.com.irecycle.sevlet;

import java.io.IOException;

/*
 * Caso de problema para importar as classes de serverLet basta seguir as istrucoes:
 * 
 * Right click on project ---> Properties ---> Java Build Path ---> Add Library... 
 * ---> Server Runtime ---> Apache Tomcat ----> Finish.
 * 
 * */
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.irecycle.service.QRCodeService;

@WebServlet("/validaQRCode")
public class IRecycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IRecycleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		
		if(!id.isEmpty()){
			QRCodeService code = new QRCodeService();
			
			String result = code.validateQRCode(id);
			
			response.getWriter().append(result);
		}else{
			response.getWriter().append("false");
		}
		response.setCharacterEncoding("UTF-8");   
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);			 
	}

}
