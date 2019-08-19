package Model;

import java.util.Date;

public class Alumno {
	private int code;
	private String nombre;
	private String Apellido;
	private String DNI;
	private Date fechaNac;
	private String sexo;
	private Localidad localidad;
	private String direccion;
	
	public Alumno() {
		this.code = 0;
		this.nombre = "";
		this.Apellido = "";
		this.DNI = "";
		this.fechaNac = new Date();
		this.sexo = "";
		this.direccion = "";
		this.localidad = new Localidad(0, "");
	}

	public Alumno(int code, String nombre, String apellido, String dNI, Date fechaNac, String sexo, int localidadCode, String direccion) {
		this.code = code;
		this.nombre = nombre;
		this.Apellido = apellido;
		this.DNI = dNI;
		this.fechaNac = fechaNac;
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
	public Date getFechaNac() {
		return fechaNac;
	}
	public void setFechaNac(Date fechaNac) {
		this.fechaNac = fechaNac;
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
