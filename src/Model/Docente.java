package Model;

public class Docente extends Usuario {
	private int code;
	private String nombre;
	private String Apellido;
	private String DNI;
	private String sexo;
	private Localidad localidad;
	private String direccion;
	
	public Docente() {
		this.code = 0;
		this.nombre = "";
		this.Apellido = "";
		this.DNI = "";
		this.sexo = "";
		this.direccion = "";
		this.localidad = new Localidad(0, "");
	}

	public Docente(int code, String nombre, String apellido, String dNI, String sexo, int localidadCode, String direccion) {
		this.code = code;
		this.nombre = nombre;
		this.Apellido = apellido;
		this.DNI = dNI;
		this.sexo = sexo;
		this.direccion = direccion;
		this.localidad = new Localidad(localidadCode);
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return Apellido;
	}

	public void setApellido(String apellido) {
		Apellido = apellido;
	}

	public String getDNI() {
		return DNI;
	}

	public void setDNI(String dNI) {
		DNI = dNI;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public Localidad getLocalidad() {
		return localidad;
	}

	public void setLocalidad(Localidad localidad) {
		this.localidad = localidad;
	}
	
	public void setLocalidad(int localidadCode) {
		this.localidad = new Localidad(localidadCode);
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	
	
}
