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

import DAO.HelperDAO;
import DAO.UsuarioDAO;
import Model.*;

/**
 * Servlet implementation class Docente
 */
@WebServlet(asyncSupported = true,  urlPatterns = { "/docente" })
public class Docente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Docente() {
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
		UsuarioDAO _dbConUsuario = new UsuarioDAO();
		request.setAttribute("userTypes", _dbConHelper.listUserTypes());
		request.setAttribute("localidades", _dbConHelper.listLocalidades());
		
		/*
		 * if(request.getParameter("code") != null) { int code =
		 * Integer.parseInt(request.getParameter("code").toString()); int usertypecode =
		 * Integer.parseInt(request.getParameter("usertype").toString()); StringBuilder
		 * ret = new StringBuilder(); ret.append("["); for(CursosPorDocente bol :
		 * _dbConHelper.listCursosDisponibles(code, usertypecode))
		 * ret.append(bol.toString() + ","); ret.deleteCharAt(ret.length()-1);
		 * ret.append("]"); out.print(ret); }
		 */
		
		if(request.getParameter("new") != null) {
			Model.Docente nuevo = new Model.Docente();
			request.setAttribute("user", nuevo);
			url = "/Vistas/DocenteForm.jsp";
		}
		
		if(request.getParameter("edit") != null) {
			int code = Integer.parseInt(request.getParameter("edit").toString());
			request.setAttribute("user", _dbConUsuario.edit(code));
			
			url = "/Vistas/DocenteForm.jsp";
		}
		
		if(request.getParameter("list") != null){
			
			List<Model.Docente> das = _dbConUsuario.list();
			request.setAttribute("listDocs", das);
			
			url = "/Vistas/ListaDocentes.jsp";
				
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
		UsuarioDAO _dbConUsuario = new UsuarioDAO();
		HelperDAO _dbConHelper = new HelperDAO();
		
		if(request.getParameter("delDocenteCurso") != null) {
			int docenteCode = Integer.parseInt(request.getParameter("docenteCode").toString());
			int cursoCode = Integer.parseInt(request.getParameter("cursoCode").toString());
			if(_dbConUsuario.existRelationDocenteCurso(docenteCode, cursoCode)) {
				if(_dbConUsuario.deleteRelationDocenteCurso(docenteCode, cursoCode)) 
					out.print("{ \"message\" : \"el docente se elimino correctamente como responsable del curso\", \"status\": true}");	
				else
					out.print("{ \"message\" : \"el docente no sepudo eliminar como responsable del curso\", \"status\": false}");					
			}
		}
		
		if(request.getParameter("docenteCurso") != null) {
			int docenteCode = Integer.parseInt(request.getParameter("docenteCode").toString());
			int cursoCode = Integer.parseInt(request.getParameter("cursoCode").toString());
			if(!_dbConUsuario.existRelationDocenteCurso(docenteCode, cursoCode)) {
				if(_dbConUsuario.saveRelationDocenteCurso(docenteCode, cursoCode, true)) 
					out.print("{ \"message\" : \"el docente se guardo correctamente como responsable del curso\", \"status\": true}");				
				else
					out.print("{ \"message\" : \"el docente no se pudo grabar correctamente como responsable del curso\", \"status\": false}");	
			}
			else {
				if(_dbConUsuario.saveRelationDocenteCurso(docenteCode, cursoCode, false)) 
					out.print("{ \"message\" : \"el docente se guardo correctamente como responsable del curso\", \"status\": true}");
				else
					out.print("{ \"message\" : \"el docente no se pudo grabar correctamente como responsable del curso\", \"status\": false}");					
			}
		}
		
		if(request.getParameter("code") != null) {
			int code = Integer.parseInt(request.getParameter("code").toString());
			//int usertypecode = Integer.parseInt(request.getParameter("usertype").toString());
			StringBuilder ret = new StringBuilder();
			ret.append("[");
			for(CursoPorDocente bol : _dbConHelper.listCursosDisponibles(code, 0))
				ret.append(bol.toString() + ",");
			ret.deleteCharAt(ret.length()-1);
			ret.append("]");
			out.print(ret);
		}
		
		if(request.getParameter("validateExistDNI") != null) {
			out.print((_dbConUsuario.ValidateDNIExist(Integer.parseInt(request.getParameter("validateExistDNI")))));
		}
		
		if(request.getParameter("del") != null) {
			int doc = Integer.parseInt(request.getParameter("doc").toString());
			int usr = Integer.parseInt(request.getParameter("usr").toString());
			
			//primero valido q no este dando ningun curso
			if(!_dbConUsuario.validateNoTeachCurso(doc)) {
				//ahora si elimino
				try {
					if(_dbConUsuario.deleteDocente(doc)) {
						if(_dbConUsuario.deleteUser(usr))
							out.print("{ \"message\" : \"el docente se elimino correctamente\", \"status\": true}");					  
						else
							out.print("{ \"message\" : \"los datos del docente no se eliminaron correctamente\" , \"status\": false}");
					}
					else
						out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente\", \"status\": false}");
				}catch(Exception e) {
					out.print("{ \"message\" : \"ocurrio un error al eliminar los datos, intente nuevamente. Si el error persiste comuniquese con el administrador\", \"status\": false}");
				}
			}
			else
				out.print("{ \"message\" : \"El docente que intenta eliminar tiene uno o mas cursos a cargo todavia, no se puede realizar la accion.\", \"status\": false}");
		}
		
		if(request.getParameter("save") != null) { 
		  	Model.Docente doc = new Model.Docente();
	  	  	doc.setCode(Integer.parseInt(request.getParameter("docenteCode").toString()));
			doc.setNombre(request.getParameter("Nombre").toString());
			doc.setApellido(request.getParameter("Apellido").toString());
			doc.setDNI(request.getParameter("DNI").toString());
			doc.setSexo(request.getParameter("Sex").toString());
			doc.setLocalidad(Integer.parseInt(request.getParameter("Localidad")));
			doc.setDireccion(request.getParameter("Direccion").toString());
		  
		  String username = String.format("%s%s", request.getParameter("Nombre").toString().substring(0, 1), request.getParameter("Apellido").toString());
		  try {
			  if(doc.getCode() == 0 && _dbConUsuario.ValidateDNIExist(Integer.parseInt(doc.getDNI())))
				  out.print("{ \"message\" : \"Ya hay un docente registrado con ese DNI\" , \"status\": false}");
			  else {
				  if(_dbConUsuario.save(doc)) {
					  if(doc.getCode() != 0) {
						  if(_dbConUsuario.saveType(username.toString(), Integer.parseInt(request.getParameter("userType").toString()), false))
							  out.print("{ \"message\" : \"el docente se grabo correctamente\", \"status\": true}");
						  else
							  out.print("{ \"message\" \"los datos del docente no se grabaron correctamente\": , \"status\": false}");
					  }else {
						  if(_dbConUsuario.saveType(username.toString(), Integer.parseInt(request.getParameter("userType").toString()), true))
							  out.print("{ \"message\" : \"el docente se grabo correctamente\", \"status\": true}");
						  else
							  out.print("{ \"message\" \"los datos del docente no se grabaron correctamente\": , \"status\": false}");
					  }  
				  }
				  else
					  out.print("{ \"message\" \"ocurrio un error al grabar los datos, intente nuevamente\": , \"status\": false}");				  
			  }
		  }catch(Exception e) {
			  out.print("{ \"message\" \"ocurrio un error al grabar los datos, intente nuevamente, si el error persiste comuniquese con el administrador\": , \"status\": false}");
		  }
		}		 
	}

}
