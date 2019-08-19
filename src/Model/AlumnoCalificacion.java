package Model;

public class AlumnoCalificacion {
	private int alumnoCode;
	private String alumnoDescripcion;
	private int cursoCode;
	private int parcial1;
	private int parcial2;
	private int recuperatorio1;
	private int recuperatorio2;
	private EstadoAlumno estado;
	
	public AlumnoCalificacion(int alumnoCode, String alumnodescripcion, int cursoCode, int parcial1, int parcial2, int recuperatorio1,
			int recuperatorio2, EstadoAlumno estado) {
		this.alumnoCode = alumnoCode;
		this.alumnoDescripcion = alumnodescripcion;
		this.cursoCode = cursoCode;
		this.parcial1 = parcial1;
		this.parcial2 = parcial2;
		this.recuperatorio1 = recuperatorio1;
		this.recuperatorio2 = recuperatorio2;
		this.estado = estado;
	}

	public int getAlumnoCode() {
		return alumnoCode;
	}

	public void setAlumnoCode(int alumnoCode) {
		this.alumnoCode = alumnoCode;
	}

	public int getCursoCode() {
		return cursoCode;
	}

	public void setCursoCode(int cursoCode) {
		this.cursoCode = cursoCode;
	}

	public int getParcial1() {
		return parcial1;
	}

	public void setParcial1(int parcial1) {
		this.parcial1 = parcial1;
	}

	public int getParcial2() {
		return parcial2;
	}

	public void setParcial2(int parcial2) {
		this.parcial2 = parcial2;
	}

	public int getRecuperatorio1() {
		return recuperatorio1;
	}

	public void setRecuperatorio1(int recuperatorio1) {
		this.recuperatorio1 = recuperatorio1;
	}

	public int getRecuperatorio2() {
		return recuperatorio2;
	}

	public void setRecuperatorio2(int recuperatorio2) {
		this.recuperatorio2 = recuperatorio2;
	}

	public EstadoAlumno getEstado() {
		return estado;
	}

	public void setEstado(EstadoAlumno estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "{ \"alumnoCode\" :" + alumnoCode + ", \"alumnoDescripcion\" : \"" + alumnoDescripcion + "\", \"cursoCode\" :" + cursoCode + ", \"parcial1\" :" + parcial1
				+ ", \"parcial2\" :" + parcial2 + ", \"recuperatorio1\" :" + recuperatorio1 + ", \"recuperatorio2\" :" + recuperatorio2
				+ ", \"estadoCode\" :" + estado.getCode() + ", \"estadoDescripcion\" : \"" + estado.getDescripcion() + "\" }";
	}

	public String getAlumnoDescripcion() {
		return alumnoDescripcion;
	}

	public void setAlumnoDescripcion(String alumnoDescripcion) {
		this.alumnoDescripcion = alumnoDescripcion;
	}
	
}
