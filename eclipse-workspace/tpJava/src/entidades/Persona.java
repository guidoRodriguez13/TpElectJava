package entidades;

import java.util.ArrayList;
import java.util.HashMap;

public class Persona {

	private int idPersona;
	private String nombre;
	private String apellido;
	private int dni;
	private long telefono;
	private String direccion;
	private String email;
	private boolean esAdmin;
	private String password;
	ArrayList<Venta> ventas = new ArrayList();
	
	public ArrayList<Venta> getVentas() {
		return ventas;
	}
	public void setVentas(ArrayList<Venta> ventas) {
		this.ventas = ventas;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getIdPersona() {
		return idPersona;
	}
	public void setIdPersona(int idPersona) {
		this.idPersona = idPersona;
	}
	public boolean isEsAdmin() {
		return esAdmin;
	}
	public void setEsAdmin(boolean esAdmin) {
		this.esAdmin = esAdmin;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public int getDni() {
		return dni;
	}
	public void setDni(int dni) {
		this.dni = dni;
	}
	public long getTelefono() {
		return telefono;
	}
	public void setTelefono(long l) {
		this.telefono = l;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() { // NO SE USA, SOLO PARA PROBAR POR CONSOLA
		return "idPersona=" + idPersona + ", nombre=" + nombre + ", apellido=" + apellido +
				", dni=" + dni + ", direccion=" + direccion + ", email=" + email
				+ ", esAdmin=" + esAdmin +"\n";
	}
}
