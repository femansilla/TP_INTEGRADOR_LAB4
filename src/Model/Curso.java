package Model;

public class Curso {
	private int Id;
	private int Semestre;
	private String Year;
	private Materia Materia;
	private Carrera Carrera;
	
	
	public Curso() {
		Id = 0;
		Semestre = 0;
		Year = "";
		Materia = new Materia(0, "");
		Carrera = new Carrera(0, "");
	}

	public Curso(int id, int semestre, String year, Model.Materia materia, Model.Carrera carrera) {
		Id = id;
		Semestre = semestre;
		Year = year;
		Materia = materia;
		Carrera = carrera;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getSemestre() {
		return Semestre;
	}

	public void setSemestre(int semestre) {
		Semestre = semestre;
	}

	public String getYear() {
		return Year;
	}

	public void setYear(String year) {
		Year = year;
	}

	public Materia getMateria() {
		return Materia;
	}

	public void setMateria(Materia materia) {
		Materia = materia;
	}
	
	public void setMateria(int materiaCode) {
		this.Materia = new Materia(materiaCode);
	}

	public Carrera getCarrera() {
		return Carrera;
	}

	public void setCarrera(Carrera carrera) {
		Carrera = carrera;
	}
	
	public void setCarrera(int carreraCode) {
		this.Carrera = new Carrera(carreraCode);
	}
}
