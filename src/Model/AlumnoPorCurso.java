package Model;

public class AlumnoPorCurso {
	private String dni;
	private int alumnoCode;
	private String alumnoDescripcion;
	private int cursoCode;
	private String status;
	
	public AlumnoPorCurso(String dni, int alumnoCode, String alumnoDescripcion, int cursoCode, String status) {
		this.dni = dni;
		this.alumnoCode = alumnoCode;
		this.alumnoDescripcion = alumnoDescripcion;
		this.cursoCode = cursoCode;
		this.status = status;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public int getAlumnoCode() {
		return alumnoCode;
	}

	public void setAlumnoCode(int alumnoCode) {
		this.alumnoCode = alumnoCode;
	}

	public String getAlumnoDescripcion() {
		return alumnoDescripcion;
	}

	public void setAlumnoDescripcion(String alumnoDescripcion) {
		this.alumnoDescripcion = alumnoDescripcion;
	}

	public int getCursoCode() {
		return cursoCode;
	}

	public void setCursoCode(int cursoCode) {
		this.cursoCode = cursoCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "{\"dni\":\"" + dni + "\", \"alumnoCode\":" + alumnoCode + ", \"alumnoDescripcion\":\"" + alumnoDescripcion
				+ "\", \"cursoCode\":" + cursoCode + ", \"status\":\"" + status + "\"}";
	}
	
	
}
