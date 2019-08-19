package controller;

import Model.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UsuarioDAO;

/**
 * Servlet implementation class Usuario
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/usuario"/*, "/"*/ })
public class Usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Usuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession sessionActiva = request.getSession();
		sessionActiva.setAttribute("sessionUser", null);
		response.sendRedirect("Vistas/Login.jsp");			
		
		//String url = "/Vistas/Login.jsp";
		//RequestDispatcher rd = request.getRequestDispatcher(url);
		//rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession sessionActiva = request.getSession();
		PrintWriter out = response.getWriter();
		
		if(request.getParameter("logOut") != null) {
			sessionActiva.setAttribute("sessionUser", null);
			response.sendRedirect("/Vistas/Login.jsp");
		}
		
		if(request.getParameter("btnAceptar") != null){
			request.setAttribute("valid", false);
			
			String user = request.getParameter("inputUser");
			String pass = request.getParameter("inputPassword");
			
			UsuarioDAO _dbCon = new UsuarioDAO();
			
			if(_dbCon.ValidateUser(user, pass)){
								
				Model.Usuario UsuarioLogueado = _dbCon.getUsuario(user);
	            sessionActiva.setAttribute("sessionUser", UsuarioLogueado);
				
	            String url = "/Vistas/Home.jsp";
	    		//RequestDispatcher rd = request.getRequestDispatcher(url);
	    		//rd.forward(request, response);
	            out.print("{ \"valid\": true }");
	    		
			}else{
				out.print("{ \"valid\": false }");
			}
		}
		
		if(request.getParameter("btnSave") != null) {
			String user = request.getParameter("Nombre");
			String pass = request.getParameter("Apellido");
			
			UsuarioDAO _dbCon = new UsuarioDAO();
			Model.Docente doc = new Model.Docente();
			_dbCon.save(doc);
			response.sendRedirect("Vistas/ListaDocentes.jsp");
		}
	}

}
