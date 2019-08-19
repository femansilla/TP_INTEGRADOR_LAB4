package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;

import Factory.ConnectionDB;
import Factory.FactoryConnectionDB;
import Model.AlumnoCalificacion;
import Model.AlumnoPorCurso;
import Model.Carrera;
import Model.CursoPorAlumno;
import Model.CursoPorDocente;
import Model.EstadoAlumno;
import Model.Localidad;
import Model.Materia;
import Model.UserType;

public class HelperDAO {
	ConnectionDB _dbContext;
	
	public HelperDAO()
	{
		//this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
	}
	
	public boolean existActiveRelationAlumnoCurso(int alumnoCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from relationalumnocurso where alumnoCode = " + alumnoCode + " and cursocode = " + cursoCode + " and status = 'A'");
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			if(rs.absolute(1))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean existActiveRelationDocenteCurso(int userCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from relationcursodocente where docenteCode = (select id from docentes where dni = (select password from usuarios where id = " + userCode + ")) and cursocode = " + cursoCode + " and status = 'A'");
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			if(rs.absolute(1))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public ArrayList<UserType> listUserTypes(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from usertypes where Status = 'A'");
		
		ArrayList<UserType> list = new ArrayList<UserType>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				UserType type = new UserType(rs.getInt("id"), rs.getString("Descripcion"));
				list.add(type);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<EstadoAlumno> listAlumnoEstado(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from estadoalumno where Status = 'A'");
		
		ArrayList<EstadoAlumno> list = new ArrayList<EstadoAlumno>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				EstadoAlumno type = new EstadoAlumno(rs.getInt("id"), rs.getString("Descripcion"));
				list.add(type);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<AlumnoCalificacion> listAlumnosCalificacionCurso(int cursoCode){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		sql.append("select * from v_calificaciones where cursocode = " + cursoCode);
		
		ArrayList<AlumnoCalificacion> list = new ArrayList<AlumnoCalificacion>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				AlumnoCalificacion cpa = new AlumnoCalificacion(
						rs.getInt("alumnoCode"), 
						rs.getString("AlumnoDescripcion"),
						rs.getInt("cursoCode"), 
						rs.getInt("parcial1"),
						rs.getInt("parcial2"),
						rs.getInt("recuperatorio1"),
						rs.getInt("recuperatorio2"),
						new EstadoAlumno(rs.getInt("estadoCode"), rs.getString("estadoDescripcion")) 
						);
				list.add(cpa);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<CursoPorAlumno> listCursosDisponiblesAlumno(int alumnocode, int usercode, int usertype){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		sql.append("select *, null as alumnoCode, null as status from v_cursos");
		
		ArrayList<CursoPorAlumno> list = new ArrayList<CursoPorAlumno>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				CursoPorAlumno cpa = new CursoPorAlumno(
						rs.getInt("cursoCode"), 
						rs.getInt("carreraCode"), 
						rs.getString("carreraDescripcion"), 
						rs.getInt("materiaCode"),
						rs.getString("materiaDescripcion"),
						rs.getInt("semestre"), 
						rs.getString("year"), 
						rs.getInt("alumnoCode"),
						rs.getString("status")
						);
				if(this.existActiveRelationAlumnoCurso(alumnocode, rs.getInt("cursoCode"))) {
					cpa.setAlumnoCode(alumnocode);
					cpa.setStatus("A");
				}
				if(usertype != 1 ) {
					if(this.existActiveRelationDocenteCurso(usercode, rs.getInt("cursoCode")))
						list.add(cpa);
				}else
					list.add(cpa);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<CursoPorDocente> listCursosDisponibles(int code, int usertype){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		//if(usertype != 1 )
			sql.append("select * from v_cursos c left join relationcursodocente r on r.status = 'A' and c.cursocode = r.cursocode and r.docentecode = " + code);
		//else
			//sql.append("select * from v_cuursosfordocente");
		
		ArrayList<CursoPorDocente> list = new ArrayList<CursoPorDocente>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				CursoPorDocente cpd = new CursoPorDocente(
						rs.getInt("cursoCode"), 
						rs.getInt("carreraCode"), 
						rs.getString("carreraDescripcion"), 
						rs.getInt("materiaCode"),
						rs.getString("materiaDescripcion"),
						rs.getInt("semestre"), 
						rs.getString("year"), 
						rs.getInt("docenteCode"),
						rs.getString("status")
						);
				list.add(cpd);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}

	public ArrayList<AlumnoPorCurso> listAlumnosDisponibles(int cursocode, int usertype){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		//if(usertype != 1 )
			sql.append("select *, null as cursocode, null as status from v_alumnos");
		//else
			//sql.append("select * from v_alumnos");
		
		ArrayList<AlumnoPorCurso> list = new ArrayList<AlumnoPorCurso>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				AlumnoPorCurso apc = new AlumnoPorCurso(
						rs.getString("dni"),
						rs.getInt("code"), 
						String.format("%s , %s", rs.getString("nombre"), rs.getString("apellido")),
						rs.getInt("cursoCode"), 
						rs.getString("status")
						);
				if(this.existActiveRelationAlumnoCurso(rs.getInt("code"), cursocode)) {
					apc.setCursoCode(cursocode);
					apc.setStatus("A");
				}
				list.add(apc);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<Localidad> listLocalidades(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from localidades where Status = 'A'");
		
		ArrayList<Localidad> list = new ArrayList<Localidad>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Localidad type = new Localidad(rs.getInt("id"), rs.getString("Descripcion"));
				list.add(type);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<Carrera> listCarreras(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from Carreras where Status = 'A'");
		
		ArrayList<Carrera> list = new ArrayList<Carrera>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			while(rs.next()) {
				Carrera type = new Carrera(rs.getInt("id"), rs.getString("Descripcion"));
				list.add(type);
			}
					
		} catch (Exception e){
			list = null;
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public ArrayList<Materia> listMaterias(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from Materias where Status = 'A'");
		
		ArrayList<Materia> list = new ArrayList<Materia>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Materia type = new Materia(rs.getInt("id"), rs.getString("Descripcion"));
				list.add(type);
			}
					
		} catch (Exception e){
			list = null;
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}

	public static void main(String[] args) {
		HelperDAO ud = new HelperDAO();
		
		for(CursoPorDocente bol : ud.listCursosDisponibles(11, 1))
			System.out.println(bol.getCarreraDescripcion() + " " + bol.getMateriaDescripcion());
		
		
	}
}
