package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections.*;

import Model.Docente;
import Model.Localidad;
import Model.UserType;
import Model.Usuario;
import Factory.ConnectionDB;
import Factory.FactoryConnectionDB;

public class UsuarioDAO {
	
	ConnectionDB _dbContext;
	
	public UsuarioDAO()
	{
		//this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
	}
	
	public boolean saveRelationDocenteCurso(int docenteCode, int cursoCode, boolean nnew) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		if(!nnew)
			sql.append("update relationcursodocente set Status = 'A' where docentecode = "	+ docenteCode + " and cursocode = " + cursoCode);
		else
			sql.append("insert into relationcursodocente (docenteCode, cursoCode) values ("	+ docenteCode + ", " + cursoCode + ")");				
		try {			
			if(this._dbContext.execute(sql.toString()))
				return true;
			
		} catch (Exception e){
			int a = 4 + 8;
			throw e;
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean deleteRelationDocenteCurso(int docenteCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update relationcursodocente set Status = 'I' where docentecode = "	+ docenteCode + " and cursocode = " + cursoCode);				
		try {			
			if(this._dbContext.execute(sql.toString()))
				return true;
			
		} catch (Exception e){
		
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean existRelationDocenteCurso(int docenteCode, int cursoCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from relationcursodocente where docenteCode = " + docenteCode + " and cursocode = " + cursoCode + " and (status = 'I' or status = 'A')");
		
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
	
	public List<Docente> getCursosByDoc(int code){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("Select * from v_cursosPorDocente");
		
		List<Docente> list = new ArrayList<Docente>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Docente doc = new Docente();
				doc.setCode(rs.getInt("docenteCode"));
				doc.setNombre(rs.getString("Nombre"));
				doc.setApellido(rs.getString("Apellido"));
				list.add(doc);
			}
					
		} catch (Exception e){
			list = null;
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}

	public List<Docente> list(){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("Select * from v_docentes");
		
		List<Docente> list = new ArrayList<Docente>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Docente doc = new Docente();
				doc.setCode(rs.getInt("docenteCode"));
				doc.setNombre(rs.getString("Nombre"));
				doc.setApellido(rs.getString("Apellido"));
				doc.setDNI(rs.getString("dni"));
				doc.setSexo(rs.getString("sexo"));
				doc.setLocalidad(new Localidad(rs.getInt("localidadCode"), rs.getString("localidadDescripcion")));
				doc.setDireccion(rs.getString("direccion"));
				doc.setId(rs.getInt("userCode"));
				doc.setUsername(rs.getString("username"));
				doc.setUsertype(new UserType(rs.getInt("usertypecode"), rs.getString("usertypedescripcion")));
				//doc.setPassword("");
				list.add(doc);
			}
					
		} catch (Exception e){
			list = null;
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public Docente edit(int id) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM v_docentes where docenteCode = " + id );
		Docente doc = new Docente();
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			rs.next();
			
			doc.setCode(rs.getInt("docenteCode"));
			doc.setNombre(rs.getString("Nombre"));
			doc.setApellido(rs.getString("Apellido"));
			doc.setDNI(rs.getString("dni"));
			doc.setSexo(rs.getString("sexo"));
			doc.setLocalidad(new Localidad(rs.getInt("localidadCode"), rs.getString("localidadDescripcion")));
			doc.setDireccion(rs.getString("direccion"));
			doc.setId(rs.getInt("userCode"));
			doc.setUsername(rs.getString("username"));
			doc.setUsertype(new UserType(rs.getInt("usertypecode"), rs.getString("usertypedescripcion")));
		
		} catch (Exception e){
			doc = null;
		} finally {
			this._dbContext.close();
		}
		
		return doc;
	}
	
	public boolean save(Docente doc) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		if(doc.getCode() == 0) {
			sql.append("insert into docentes (Nombre, Apellido, DNI, Sexo, LocalidadCode, Direccion) values ('"
					+ doc.getNombre() +"', '" + doc.getApellido() + "', '" + doc.getDNI() + "', '" + doc.getSexo() + "', " + doc.getLocalidad().getCode() + ", '" + doc.getDireccion() +"')");			
		}
		else {
			sql.append("update docentes set Nombre = '"+ doc.getNombre() + "', Apellido = '" + doc.getApellido() + "', DNI = '" + doc.getDNI() + "', Sexo = '" + doc.getSexo() + "', LocalidadCode = " 
					+ doc.getLocalidad().getCode() + ", Direccion = '" + doc.getDireccion() +"' where Id = " + doc.getCode());
		}
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean saveType(String userName, int userTypeCode, boolean nnew) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from usuarios where username = '"+ userName +"'");
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			sql = new StringBuilder();
			rs.next();
			if(!nnew) 
				sql.append("update _userType set userTypeCode = " + userTypeCode + " where userCode = " + rs.getInt("Id"));
			else 
				sql.append("insert into _userType (userCode, userTypeCode) values ((select id from usuarios where username = '"
						+ userName +"')" + ", " + userTypeCode + ")");				
			
			if(this._dbContext.execute(sql.toString()))
				return true;
			
		} catch (Exception e){
			int aa = 45 + 40 +20;
			e.getStackTrace();
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean deleteDocente(int id) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update docentes set status = 'I' where id = " + id);
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean deleteUser(int id) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update usuarios set status = 'I' where id =" + id);
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean ValidateUser(String user, String pass) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("Select id from usuarios where UCASE(UserName) = UCASE('" + user + "') and Password = '" + pass + "' and Status = 'A'");
		
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

	public Usuario getUsuario(String username) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM v_usuarios where username = '" + username + "'");
		Usuario user = new Usuario();
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			rs.next();
			user.setId(rs.getInt("userCode"));
			user.setUsertype(new UserType(rs.getInt("UserTypeCode")));
			user.setUsername(rs.getString("UserName"));
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		
		return user;
	}
	
	public static void main(String[] args) {
		UsuarioDAO ud = new UsuarioDAO();
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
		boolean bol= ud.ValidateDNIExist(40425828);
		System.out.println(bol);
		
		
	}
	
	public boolean validateNoTeachCurso(int docCode) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from v_cuursosforDocente where status = 'A' and docenteCode = " + docCode );
		
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

	public boolean ValidateDNIExist(int DNI) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from v_docentes where dni ='" + DNI + "'");
		
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
