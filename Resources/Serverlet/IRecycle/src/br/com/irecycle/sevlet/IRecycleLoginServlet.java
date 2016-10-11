package br.com.irecycle.sevlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.irecycle.service.UserService;

@WebServlet("/Login")
public class IRecycleLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IRecycleLoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
		
		UserService login = new UserService();	
		String result = login.validaLogin(user, pass);
			
		response.getWriter().append(result);
		
		response.setCharacterEncoding("UTF-8");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
