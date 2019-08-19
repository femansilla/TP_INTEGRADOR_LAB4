package Factory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public abstract class ConnectionDB {

	protected String[] params;
	protected Connection connection;
	
	abstract Connection open();
	
	public ResultSet query(String query) {
		Statement st;
		ResultSet rs = null;
		
		try {
			st = connection.createStatement();			
			rs = st.executeQuery(query);
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return rs;
	}
	
	public boolean execute(String query) {
		Statement st;
		boolean save = true;
		
		try {
			st = connection.createStatement();
			st.executeUpdate(query);
		}catch(SQLException e){
			save = false;
			e.printStackTrace();
		}
		
		return save;
	}
	
	public boolean executeSP(String spName, String[] params) {
		java.sql.CallableStatement cst = null;
		boolean save = true;
		
		try {
			cst = (java.sql.CallableStatement) connection.prepareCall("CALL " + spName);
			int i = 1;
			for(String value : params) {
				cst.setString(i, value);
				i++;
			}
			cst.execute();
			
		}catch(SQLException e){
			save = false;
			e.printStackTrace();
		}
		
		return save;
	}
	
	public boolean close() {
		boolean ok = true;
		
		try {
			if(connection != null) connection.close();
			
		}catch(Exception e) {
			ok = false;
			e.printStackTrace();
		}
		return ok;
	}
	
}
