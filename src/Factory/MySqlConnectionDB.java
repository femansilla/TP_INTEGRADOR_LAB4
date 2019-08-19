package Factory;

import java.sql.Connection;
import java.sql.DriverManager;

public final class MySqlConnectionDB extends ConnectionDB{

	public MySqlConnectionDB(String[] params) {
		this.params = params;
		this.open();
	}
	
	@Override
	Connection open() {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.jdbc.Driver");
			this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+this.params[0], this.params[1], this.params[2]);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return this.connection;
	}

	
}
