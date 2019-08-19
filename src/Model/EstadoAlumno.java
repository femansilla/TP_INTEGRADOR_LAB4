package Model;

public class EstadoAlumno {
	
	private int code;
	private String descripcion;
	
	public EstadoAlumno(int estadoAlumnocode) {
		this.code = estadoAlumnocode;
	}

	public EstadoAlumno(int estadoAlumnocode, String descripcion) {
		this.code = estadoAlumnocode;
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

	@Override
	public String toString() {
		return "{ \"code\" :" + code + ", \"descripcion\" : \"" + descripcion + "\" }";
	}
	
}
