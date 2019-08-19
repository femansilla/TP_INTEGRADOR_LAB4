package Model;

public class Usuario {
	
	protected int id;
	protected String username;
	protected String password;
	protected UserType userType;
	
	public Usuario() {
		this.id = 0;
	}
	
	public Usuario(int id, String username, String password, int usertype) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.userType = new UserType(usertype);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public UserType getUsertype() {
		return userType;
	}

	public void setUsertype(UserType usertype) {
		this.userType = usertype;
	}
	
}
