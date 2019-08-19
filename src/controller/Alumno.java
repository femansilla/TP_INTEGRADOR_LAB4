package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AlumnoDAO;
import DAO.HelperDAO;
import Model.AlumnoCalificacion;
import Model.CursoPorAlumno;
import Model.CursoPorDocente;
import Model.EstadoAlumno;
/**
 * Servlet implementation class Alumno
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/alumno" })
public class Alumno extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Alumno() {
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
		AlumnoDAO _dbConAlumno = new AlumnoDAO();
		request.setAttribute("localidades", _dbConHelper.listLocalidades());
		
		if(request.getParameter("code") != null) {
			int code = Integer.parseInt(request.getParameter("edit").toString());
			
		}
		
		if(request.getParameter("new") != null) {
			Model.Alumno nuevo = new Model.Alumno();
			request.setAttribute("almn", nuevo);
			url = "/Vistas/AlumnoForm.jsp";
		}
		
		if(request.getParameter("edit") != null) {
			int code = Integer.parseInt(request.getParameter("edit").toString());
			request.setAttribute("almn", _dbConAlumno.edit(code));
			
			url = "/Vistas/AlumnoForm.jsp";
		}
		
		if(request.getParameter("list") != null){
			
			ArrayList<Model.Alumno> das = _dbConAlumno.list();
			request.setAttribute("listAlmmns", das);
			
			url = "/Vistas/ListaAlumnos.jsp";
				
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
		AlumnoDAO _dbConAlumno = new AlumnoDAO();
		HelperDAO _dbConHelper = new HelperDAO();

		if(request.getParameter("alumnosPorCurso") != null){
			int cursoCode = Integer.parseInt(request.getParameter("cursoCode").toString());;
			ArrayList<AlumnoCalificacion> list = _dbConHelper.listAlumnosCalificacionCurso(cursoCode);
			StringBuilder ret = new StringBuilder();
			
			if(list.size() != 0) {
				ret.append("{ \"list\" : [");
				for(AlumnoCalificacion bol : list)
					ret.append(bol.toString() + ",");
				ret.deleteCharAt(ret.length()-1);
				ret.append("] , \"status\" : true }");				
			}else
				ret.append("{ \"message\" : \"No se pudo recuperar informacion de la base de datos\", \"status\": false}");
			
			out.print(ret);
		}
		
		if(request.getParameter("estados") != null){
			
			ArrayList<Model.EstadoAlumno> list = _dbConHelper.listAlumnoEstado();
			StringBuilder ret = new StringBuilder();
			
			if(list.size() != 0) {
				ret.append("{ \"list\" : [");
				for(EstadoAlumno bol : list)
					ret.append(bol.toString() + ",");
				ret.deleteCharAt(ret.length()-1);
				ret.append("] , \"status\" : true }");				
			}else
				ret.append("{ \"message\" : \"No se pudo recuperar informacion de la base de datos\", \"status\": false}");
			
			out.print(ret);
		}

		if(request.getParameter("delAlumnoCurso") != null) {
			int alumnoCode = Integer.parseInt(request.getParameter("alumnoCode").toString());
			int cursoCode = Integer.parseInt(request.getParameter("cursoCode").toString());
			if(_dbConAlumno.existRelationAlumnoCurso(alumnoCode, cursoCode)) {
				if(!_dbConAlumno.PendingLoadCalificacion(alumnoCode, cursoCode)) {
					if(_dbConAlumno.deleteRelationAlumnoCurso(alumnoCode, cursoCode)) 
						out.print("{ \"message\" : \"Se des matriculo correctamente del curso\", \"status\": true}");
					else
						out.print("{ \"message\" : \"No sepudo des matricular del curso\", \"status\": false}");			
				}
				else
					out.print("{ \"message\" : \"No se pudo des matricular porque tiene notas/estado pendientes de cargar.\", \"status\": false}");
			}
		}
		
		if(request.getParameter("alumnoCurso") != null) {
			int alumnoCode = Integer.parseInt(request.getParameter("alumnoCode").toString());
			int cursoCode = Integer.parseInt(request.getParameter("cursoCode").toString());
			if(!_dbConAlumno.existRelationAlumnoCurso(alumnoCode, cursoCode)) {
				if(_dbConAlumno.saveRelationDocenteCurso(alumnoCode, cursoCode, true)) 
					out.print("{ \"message\" : \"Se matriculo correctamente al alumno\", \"status\": true}");				
				else
					out.print("{ \"message\" : \"No se pudo matricular correctamente al alumno\", \"status\": false}");	
			}
			else {
				if(_dbConAlumno.saveRelationDocenteCurso(alumnoCode, cursoCode, false)) 
					out.print("{ \"message\" : \"Se matriculo correctamente al alumno\", \"status\": true}");
				else
					out.print("{ \"message\" : \"No se pudo matricular correctamente al alumno\", \"status\": false}");					
			}
		}
		
		if(request.getParameter("getMatriculacion") != null) {
			int code = Integer.parseInt(request.getParameter("code").toString());
			int userCode = Integer.parseInt(request.getParameter("userCode").toString());
			int userType = Integer.parseInt(request.getParameter("userType").toString());
			
			StringBuilder ret = new StringBuilder();
			
			ArrayList<CursoPorAlumno> list = _dbConHelper.listCursosDisponiblesAlumno(code, userCode, userType);
			
			if(list.size() != 0) {
				ret.append("{ \"list\" : [");
				for(CursoPorAlumno bol : list)
					ret.append(bol.toString() + ",");
				ret.deleteCharAt(ret.length()-1);
				ret.append("] , \"status\" : true }");				
			}else
				ret.append("{ \"message\" : \"No posee ningun curso para matricular\", \"status\": false}");
			
			out.print(ret);
		}
		
		if(request.getParameter("validateExistDNI") != null) {
			out.print((_dbConAlumno.ValidateDNIExist(Integer.parseInt(request.getParameter("validateExistDNI")))));
		}
		
		if(request.getParameter("del") != null) {
			int doc = Integer.parseInt(request.getParameter("code").toString());
			//validar que no este si esta cursando y tiene notas/estado pendiente
			if(_dbConAlumno.PendingLoadCalificacion(doc, 0)) 
				out.print("{ \"message\" : \"No se pudo eliminar porque tiene notas/estado pendientes de cargar.\" , \"status\": false}");
			else {
				try {
					if(_dbConAlumno.delete(doc)) {
						out.print("{ \"message\" : \"el alumno se elimino correctamente\", \"status\": true}");
					}else {
						out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente\" , \"status\": false}");
					}
				}catch(Exception e) {
					out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente, si el error persiste comuniquese con el administrador\" , \"status\": false}");
				}				
			}
			
		}
		
		if(request.getParameter("save") != null) { 
		  	Model.Alumno doc = new Model.Alumno();
	  	  	doc.setCode(Integer.parseInt(request.getParameter("code").toString()));
			doc.setNombre(request.getParameter("Nombre").toString());
			doc.setApellido(request.getParameter("Apellido").toString());
			doc.setDNI(request.getParameter("DNI").toString());
			//Date date1 = new Date(request.getParameter("FechaNac").toString());
			try {
				Date date1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("FechaNac").toString()+" 00:00:00");
				doc.setFechaNac(date1);				
			}catch(Exception e){
				e.printStackTrace();
			}
			doc.setSexo(request.getParameter("Sex").toString());
			doc.setLocalidad(Integer.parseInt(request.getParameter("Localidad")));
			doc.setDireccion(request.getParameter("Direccion").toString());
			
			//validar que no este dado de alta el alumno en la bbdd
			if(doc.getCode() == 0 && _dbConAlumno.ValidateDNIExist(Integer.parseInt(doc.getDNI()))) 
				out.print("{ \"message\" : \"Ya hay un alumno registrado con ese DNI\" , \"status\": false}");
			else {
				try {
					if(_dbConAlumno.save(doc)) {
						out.print("{ \"message\" : \"el alumno se registro correctamente\", \"status\": true}");
					}else {
						out.print("{ \"message\" : \"ocurrio un error al grabar los datos, intente nuevamente\" , \"status\": false}");
					}
				}catch(Exception e) {
					out.print("{ \"message\" : \"ocurrio un error al grabar los datos, intente nuevamente, si el error persiste comuniquese con el administrador\" , \"status\": false}");
				}				
			}
		}
	}

}
