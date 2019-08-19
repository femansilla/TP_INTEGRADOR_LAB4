package Model;

public class Materia {
	private int code;
	private String descripcion;
	
	public Materia(int code) {
		this.code = code;
	}
	
	public Materia(int code, String descripcion) {
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
