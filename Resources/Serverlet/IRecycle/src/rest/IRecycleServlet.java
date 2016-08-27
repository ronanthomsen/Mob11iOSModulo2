package rest;

import java.io.IOException;
import java.util.List;

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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

 

/**
 * Servlet implementation class MercadoServlet
 */
@WebServlet("/validaQRCode")
public class IRecycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IRecycleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String id = request.getParameter("id");
		
		if(id.equals("fiap")){
			response.getWriter().append("true");
		}else{
			response.getWriter().append("false");
		}
		
		response.setCharacterEncoding("UTF-8");   
					
		//response.getWriter().append("NULL");
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doGet(request, response);
				 
	}

}
