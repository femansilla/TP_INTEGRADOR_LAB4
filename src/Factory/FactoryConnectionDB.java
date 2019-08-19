package Factory;

public class FactoryConnectionDB {

	public static final int MYSQL = 1;
	public static String[] configMYSQL = {"integradorlab4", "root", ""};
	
	public static ConnectionDB open(int typeDB) {
		switch(typeDB) {
		case 1:
			return new MySqlConnectionDB(configMYSQL);
		default:
			return null;
		}
	}
	
}
