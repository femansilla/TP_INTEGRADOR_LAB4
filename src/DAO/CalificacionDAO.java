package DAO;

import java.text.SimpleDateFormat;

import Factory.ConnectionDB;
import Factory.FactoryConnectionDB;

public class CalificacionDAO {
	ConnectionDB _dbContext;

	public CalificacionDAO() {

	}

	public boolean save(int alumnocode, int cursocode, String key, String value) {
		this._dbContext = FactoryConnectionDB.open(FactoryConnectionDB.MYSQL);
		StringBuilder sql = new StringBuilder();
		sql.append("update calificaciones set "+key+" = "+value+" where alumnocode = "+ alumnocode + " and cursocode = " + cursocode);
		
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

}
