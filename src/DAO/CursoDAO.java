package DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Factory.ConnectionDB;
import Factory.FactoryConnectionDB;
import Model.Curso;
import Model.Carrera;
import Model.Materia;

public class CursoDAO {
	ConnectionDB _dbContext;

	public CursoDAO() {

	}
	
	public List<Curso> list(int code, int usertype){
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		
		if(usertype != 1 )
			sql.append("select * from v_cuursosfordocente where status = 'A' and docentecode = " + code);
		else
			sql.append("Select * from v_cursos");
		
		List<Curso> list = new ArrayList<Curso>();
		
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			
			while(rs.next()) {
				Curso doc = new Curso();
				doc.setId(rs.getInt("CursoCode"));
				doc.setSemestre(rs.getInt("semestre"));
				doc.setYear(rs.getString("year"));
				doc.setCarrera(new Carrera(rs.getInt("CarreraCode"), rs.getString("CarreraDescripcion")));
				doc.setMateria(new Materia(rs.getInt("MateriaCode"), rs.getString("MateriaDescripcion")));
				
				list.add(doc);
			}
					
		} catch (Exception e){
			list = null;
		} finally {
			this._dbContext.close();
		}
		
		return list;
	}
	
	public boolean save(Curso doc) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		if(doc.getId() == 0) {
			sql.append("insert into cursos (carreraCode, MateriaCode, Semestre, Year) values (" + doc.getCarrera().getCode() +", " 
					+ doc.getMateria().getCode() + ", " + doc.getSemestre() + ", '" + doc.getYear() + "')");			
		}
		else {
			sql.append("update cursos set carreraCode = "+ doc.getCarrera().getCode() + ", MateriaCode = " + doc.getMateria().getCode() + ", semestre = " 
					+ doc.getSemestre() + ", year = '" + doc.getYear() + "' where Id = " + doc.getId());
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
	
	public Curso edit(int id) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM v_cursos where cursoCode = " + id );
		Curso doc = new Curso();
		try {
			ResultSet rs = this._dbContext.query(sql.toString());
			rs.next();
			doc.setId(rs.getInt("CursoCode"));
			doc.setSemestre(rs.getInt("semestre"));
			doc.setYear(rs.getString("year"));
			doc.setCarrera(new Carrera(rs.getInt("CarreraCode"), rs.getString("CarreraDescripcion")));
			doc.setMateria(new Materia(rs.getInt("MateriaCode"), rs.getString("MateriaDescripcion")));
			
		} catch (Exception e){
			doc = null;
		} finally {
			this._dbContext.close();
		}
		
		return doc;
	}
	
	public boolean delete(int id) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update cursos set status = 'I' where id =" + id);
		try {
			if(this._dbContext.execute(sql.toString()))
				return true;
					
		} catch (Exception e){
			
		} finally {
			this._dbContext.close();
		}
		return false;
	}
	
	public boolean validateNoTeachCurso(int Code) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from v_cuursosfordocente where status = 'A' and"
				+ " cursoCode = " + Code );		
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
	
	public boolean validateCursoExist(int carrera, int materia, int semestre, String year) {
		
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("select * from v_cursos where CarreraCode = " + carrera + " and MateriaCode = " + materia + " and semestre = " +
		semestre + " and year = '" + year + "'");
		
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
