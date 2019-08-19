package Model;

public class CursoPorAlumno {
	private int CursoCode;
	private int CarreraCode;
	private String CarreraDescripcion;
	private int MateriaCode;
	private String MateriaDescripcion;
	private int Semestre;
	private String year;
	private int AlumnoCode;
	private String status;
	
	public CursoPorAlumno(int cursoCode, int carreraCode, String carreraDescripcion, int materiaCode,
			String materiaDescripcion, int semestre, String year, int alumnoCode, String status) {
		CursoCode = cursoCode;
		CarreraCode = carreraCode;
		CarreraDescripcion = carreraDescripcion;
		MateriaCode = materiaCode;
		MateriaDescripcion = materiaDescripcion;
		Semestre = semestre;
		this.year = year;
		AlumnoCode = alumnoCode;
		this.status = status;
	}
	public int getCursoCode() {
		return CursoCode;
	}
	public void setCursoCode(int cursoCode) {
		CursoCode = cursoCode;
	}
	public int getCarreraCode() {
		return CarreraCode;
	}
	public void setCarreraCode(int carreraCode) {
		CarreraCode = carreraCode;
	}
	public String getCarreraDescripcion() {
		return CarreraDescripcion;
	}
	public void setCarreraDescripcion(String carreraDescripcion) {
		CarreraDescripcion = carreraDescripcion;
	}
	public int getMateriaCode() {
		return MateriaCode;
	}
	public void setMateriaCode(int materiaCode) {
		MateriaCode = materiaCode;
	}
	public String getMateriaDescripcion() {
		return MateriaDescripcion;
	}
	public void setMateriaDescripcion(String materiaDescripcion) {
		MateriaDescripcion = materiaDescripcion;
	}
	public int getSemestre() {
		return Semestre;
	}
	public void setSemestre(int semestre) {
		Semestre = semestre;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getAlumnoCode() {
		return AlumnoCode;
	}
	public void setAlumnoCode(int alumnoCode) {
		AlumnoCode = alumnoCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "{ \"CursoCode\" :" + CursoCode + ", \"CarreraCode\" :" + CarreraCode + ", \"CarreraDescripcion\" : \""
				+ CarreraDescripcion + "\" , \"MateriaCode\" :" + MateriaCode + ", \"MateriaDescripcion\" : \"" + MateriaDescripcion
				+ "\", \"Semestre\" : " + Semestre + ", \"year\" : \"" + year + "\" , \"AlumnoCode\" : " + AlumnoCode + " , \"status\" : \"" + status + "\" }";
	}
}
