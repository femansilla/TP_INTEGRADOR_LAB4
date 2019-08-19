package Model;

public class Carrera {
	private int code;
	private String descripcion;
	
	public Carrera(int code) {
		this.code = code;
	}
	
	public Carrera(int code, String descripcion) {
		this.code = code;
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
