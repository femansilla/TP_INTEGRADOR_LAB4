package DAO;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;

import Factory.ConnectionDB;
import Factory.FactoryConnectionDB;
import Model.Alumno;
import Model.Localidad;

public class AlumnoDAO {

	ConnectionDB _dbContext;
	
	public AlumnoDAO()
	{
		//this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
	}

	public ArrayList<Alumno> list(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("Select * from v_alumnos");
		
		ArrayList<Alumno> list = new ArrayList<Alumno>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Alumno doc = new Alumno();
				doc.setCode(rs.getInt("Code"));
				doc.setNombre(rs.getString("Nombre"));
				doc.setApellido(rs.getString("Apellido"));
				doc.setDNI(rs.getString("dni"));
				java.sql.Date dbSqlDate = rs.getDate("fecha_nac");
				java.util.Date dbSqlDateConverted = new java.util.Date(dbSqlDate.getTime());
				doc.setFechaNac(dbSqlDateConverted);
				doc.setSexo(rs.getString("sexo"));
				doc.setLocalidad(new Localidad(rs.getInt("localidadCode"), rs.getString("localidadDescripcion")));
				doc.setDireccion(rs.getString("direccion"));
				
				list.add(doc);
			}
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public Alumno edit(int id) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM v_alumnos where code = " + id );
		Alumno doc = new Alumno();
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			rs.next();
			
			doc.setCode(rs.getInt("Code"));
			doc.setNombre(rs.getString("Nombre"));
			doc.setApellido(rs.getString("Apellido"));
			doc.setDNI(rs.getString("dni"));
			java.sql.Date dbSqlDate = rs.getDate("fecha_nac");
			java.util.Date dbSqlDateConverted = new java.util.Date(dbSqlDate.getTime());
			doc.setFechaNac(dbSqlDateConverted);
			doc.setSexo(rs.getString("sexo"));
			doc.setLocalidad(new Localidad(rs.getInt("localidadCode"), rs.getString("localidadDescripcion")));
			doc.setDireccion(rs.getString("direccion"));
			
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return doc;
	}
	
	public boolean save(Alumno doc) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		String date = new SimpleDateFormat("yyyy-MM-dd").format(doc.getFechaNac());
		if(doc.getCode() == 0) {
			sql.append("insert into alumnos (Nombre, Apellido, DNI, fecha_nac, Sexo, LocalidadCode, Direccion) values ('"
					+ doc.getNombre() +"', '" + doc.getApellido() + "', '" + doc.getDNI() + "', '" + date + "', '" 
					+ doc.getSexo() + "', " + doc.getLocalidad().getCode() + ", '" + doc.getDireccion() +"')");
		}
		else {
			sql.append("update alumnos set Nombre = '" + doc.getNombre() + "', Apellido = '" + doc.getApellido() + "', DNI = '" 
						+ doc.getDNI() + "', fecha_nac = '" + date + "', Sexo = '" + doc.getSexo() 
						+ "', LocalidadCode = " + doc.getLocalidad().getCode() + ", Direccion = '" + doc.getDireccion() + "' where id = " + doc.getCode());
		}
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			throw e;
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean delete(int id) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update alumnos set status = 'I' where id = " + id);
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public static void main(String[] args) {
		AlumnoDAO ud = new AlumnoDAO();
		//Usuario user =  ud.getUsuario("Admin");
		//System.out.println(ud.ValidateUser("Admin", "Admin"));
//		List<Docente> docs = ud.list();
//		Docente doc = ud.edit(11); 
//		//for(Docente doc : docs) {
//			System.out.println(doc.getCode());
//			System.out.println(String.format("%s, %s",doc.getNombre(), doc.getApellido()));
//			System.out.println(doc.getDNI());
//			System.out.println(doc.getSexo());
//			System.out.println(doc.getLocalidad().getDescripcion());
//			System.out.println(doc.getDireccion());
//			System.out.println(doc.getUsername());
//			System.out.println(doc.getUsertype().getDescripcion());
		//}
		//System.out.println(user.getId());
		//System.out.println(user.getUsername());
		//System.out.println(user.getUsertype());
		//boolean bol= ud.ValidateDNIExist(40425828);
		//System.out.println(bol);
		
		
	}

	public boolean ValidateDNIExist(int DNI) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from v_alumnos where dni ='" + DNI + "'");
		
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

	public boolean existRelationAlumnoCurso(int alumnoCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from relationalumnocurso where alumnoCode = " + alumnoCode + " and cursocode = " + cursoCode + " and (status = 'I' or status = 'A')");
		
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

	public boolean saveRelationDocenteCurso(int alumnoCode, int cursoCode, boolean nnew) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		if(!nnew)
			sql.append("update relationalumnocurso set Status = 'A' where alumnocode = "	+ alumnoCode + " and cursocode = " + cursoCode);
		else
			sql.append("insert into relationalumnocurso (alumnoCode, cursoCode) values ("	+ alumnoCode + ", " + cursoCode + ")");				
		try {			
			if(this._dbContext.execute(sql.toString()))
				return true;
			
		} catch (Exception e){
			throw e;
		} finally {
			this._dbContext.close();
		}
		return false;
	}

	public boolean deleteRelationAlumnoCurso(int alumnoCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update relationalumnocurso set Status = 'I' where alumnoCode = "	+ alumnoCode + " and cursocode = " + cursoCode);				
		try {			
			if(this._dbContext.execute(sql.toString()))
				return true;
			
		} catch (Exception e){
		
		} finally {
			this._dbContext.close();
		}
		return false;
	}

	public boolean PendingLoadCalificacion(int alumnoCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		if(cursoCode != 0)
			sql.append("select * from calificaciones where alumnoCode = " + alumnoCode + " and cursocode = " + cursoCode 
				+ " and (parcial1 is null or parcial2 is null or recuperatorio1 is null or recuperatorio2 is null or estado is null)");
		else
			sql.append("select * from calificaciones where alumnoCode = " + alumnoCode
					+ " and (parcial1 is null or parcial2 is null or recuperatorio1 is null or recuperatorio2 is null or estado is null)");
		
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
	
}
