package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CalificacionDAO;
import DAO.CursoDAO;
import DAO.HelperDAO;

/**
 * Servlet implementation class Calificacion
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/calificacion" })
public class Calificacion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Calificacion() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession sessionActiva = request.getSession();
		String url = null;
		CursoDAO _dbConCurso = new CursoDAO();
		
		if(request.getParameter("list") != null){
			int usercode = Integer.parseInt(request.getParameter("userCode").toString());
			int usertype = Integer.parseInt(request.getParameter("userType").toString());
			List<Model.Curso> das = _dbConCurso.list(usercode, usertype);
			
			request.setAttribute("listCurs", das);
			if(request.getParameter("currentCursoCode") != null) {
				int code = Integer.parseInt(request.getParameter("currentCursoCode").toString());
				request.setAttribute("cursoCodeSelected", code);				
			}
						
			url = "/Vistas/ListaCalificaciones.jsp";
		}
		
		
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession sessionActiva = request.getSession();
		CalificacionDAO _dbConCalificacion = new CalificacionDAO();

		if(request.getParameter("postValue") != null){
			int cursocode = Integer.parseInt(request.getParameter("cursocode"));
			int alumnocode = Integer.parseInt(request.getParameter("alumnoCodeModify"));
			String key = request.getParameter("keyModify");
			String value;
			if(request.getParameter("valueModify") != null){
				value = request.getParameter("valueModify");				
			}else
				value = "NULL";
			
			StringBuilder ret = new StringBuilder();
			if(_dbConCalificacion.save(alumnocode, cursocode, key, value))
				ret.append("{\"status\" : true}");
			else
				ret.append("{\"message\":\"No se pudo grabar la nota correctamente\", \"status\" : false}");
			
			out.print(ret);
		}
		
	}

}
