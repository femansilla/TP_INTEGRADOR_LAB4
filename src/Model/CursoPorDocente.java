package Model;

public class CursoPorDocente {
	
	private int CursoCode;
	private int CarreraCode;
	private String CarreraDescripcion;
	private int MateriaCode;
	private String MateriaDescripcion;
	private int Semestre;
	private String year;
	private int DocenteCode;
	private String status;
	
	public CursoPorDocente(int cursoCode, int carreraCode, String carreraDescripcion, int materiaCode,
			String materiaDescripcion, int semestre, String year, int docenteCode, String status) {
		
		CursoCode = cursoCode;
		CarreraCode = carreraCode;
		CarreraDescripcion = carreraDescripcion;
		MateriaCode = materiaCode;
		MateriaDescripcion = materiaDescripcion;
		Semestre = semestre;
		this.year = year;
		DocenteCode = docenteCode;
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
	public int getDocenteCode() {
		return DocenteCode;
	}
	public void setDocenteCode(int docenteCode) {
		DocenteCode = docenteCode;
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
				+ "\", \"Semestre\" : " + Semestre + ", \"year\" : \"" + year + "\" , \"DocenteCode\" : " + DocenteCode + " , \"status\" : \"" + status + "\" }";
	}
	
	
	
}
