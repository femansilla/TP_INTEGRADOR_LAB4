package Model;

public class UserType {

	private int code;
	private String descripcion;
	
	public UserType(int usertypecode) {
		this.code = usertypecode;
	}
	
	public UserType(int usertypecode, String descripcion) {
		this.code = usertypecode;
		this.descripcion = descripcion;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	
}
