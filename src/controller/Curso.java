package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CursoDAO;
import DAO.HelperDAO;
import Model.AlumnoPorCurso;
import Model.Carrera;
import Model.CursoPorDocente;
import Model.CursoPorAlumno;
import Model.Materia;

/**
 * Servlet implementation class newservlert
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/curso" })
public class Curso extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Curso() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession sessionActiva = request.getSession();
		String url = null;
		
		HelperDAO _dbConHelper = new HelperDAO();
		CursoDAO _dbConCurso = new CursoDAO();
		request.setAttribute("materias", _dbConHelper.listMaterias());
		request.setAttribute("carreras", _dbConHelper.listCarreras());
				
		if(request.getParameter("new") != null) {
			Model.Curso nuevo = new Model.Curso();
			request.setAttribute("curs", nuevo);
			url = "/Vistas/CursoForm.jsp";
		}
		
		if(request.getParameter("edit") != null) {
			int code = Integer.parseInt(request.getParameter("edit").toString());
			request.setAttribute("curs", _dbConCurso.edit(code));
			
			url = "/Vistas/CursoForm.jsp";
		}
		
		if(request.getParameter("list") != null){
			int usercode = Integer.parseInt(request.getParameter("userCode").toString());
			int usertype = Integer.parseInt(request.getParameter("userType").toString());
			List<Model.Curso> das = _dbConCurso.list(usercode, usertype);
			
			request.setAttribute("listCurs", das);
			
			url = "/Vistas/ListaCursos.jsp";
				
		}
				
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		String url = null;
		CursoDAO _dbConCurso = new CursoDAO();
		HelperDAO _dbConHelper = new HelperDAO();
		
		if(request.getParameter("save") != null) { 
		  	Model.Curso doc = new Model.Curso();
		  	doc.setId(Integer.parseInt(request.getParameter("Code").toString()));
			doc.setSemestre(Integer.parseInt(request.getParameter("Semestre").toString()));
			doc.setYear(request.getParameter("Year").toString());
			doc.setCarrera(Integer.parseInt(request.getParameter("Carrera").toString()));
			doc.setMateria(Integer.parseInt(request.getParameter("Materia").toString()));
			
			//validar que no exista este curso
			if(!_dbConCurso.validateCursoExist(doc.getCarrera().getCode(), doc.getMateria().getCode(), doc.getSemestre(), doc.getYear())) {
				try {
					if(_dbConCurso.save(doc)) {
						out.print("{ \"message\" : \"el curso se grabo correctamente\", \"status\": true}");
					}else {
						out.print("{ \"message\" : \"ocurrio un error al grabar los datos, intente nuevamente\": , \"status\": false}");
					}
				}catch(Exception e) {
					out.print("{ \"message\" : \"ocurrio un error al grabar los datos, intente nuevamente, si el error persiste comuniquese con el administrador\": , \"status\": false}");
				}				
			} else
				out.print("{ \"message\" : \"El curso ya existe\" , \"status\": false}");
			
		}
		
		if(request.getParameter("code") != null) {
			int code = Integer.parseInt(request.getParameter("code").toString());
			int usertype = 1;
			
			StringBuilder ret = new StringBuilder();
			ret.append("[");
			for(AlumnoPorCurso bol : _dbConHelper.listAlumnosDisponibles(code, usertype))
				ret.append(bol.toString() + ",");
			ret.deleteCharAt(ret.length()-1);
			ret.append("]");
			out.print(ret);
		}
		
		if(request.getParameter("del") != null) {
			int code = Integer.parseInt(request.getParameter("Code").toString());
			//primero valido q ningun docente este dando este curso
			if(!_dbConCurso.validateNoTeachCurso(code)) {
				//ahora si elimino
				try {
					if(_dbConCurso.delete(code))
						out.print("{ \"message\" : \"el curso se elimino correctamente\", \"status\": true}");					  
					else
						out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente\", \"status\": false}");
				}catch(Exception e) {
					out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente. Si el error persiste comuniquese con el administrador\", \"status\": false}");
				}
			}
			else
				out.print("{ \"message\" : \"El curso que intenta eliminar tiene uno o mas docentes a cargo todavia, no se puede realizar la accion.\", \"status\": false}");
		}
	}

}
