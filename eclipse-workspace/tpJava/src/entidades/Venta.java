package entidades;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Venta {

	private int idVenta;
	private Date fechaVenta;
	private String formaEnvio;
	private double costoEnvio;
	private String formaPago;
	
	//private Cliente cli;
	private Persona per;
	List<LineaVenta> lineas = new ArrayList<>();
	
	public int getIdVenta() {
		return idVenta;
	}
	public void setLineas(List<LineaVenta> lineas) {
		this.lineas = lineas;
	}
	
	public List<LineaVenta> getLineas(){
		return this.lineas;
	}
	
	public void setIdVenta(int idVenta) {
		this.idVenta = idVenta;
	}
	public Date getFechaVenta() {
		return fechaVenta;
	}
	public void setFechaVenta(Date fechaVenta) {
		this.fechaVenta = fechaVenta;
	}
	
	public void setFechaVentaActual() {
        fechaVenta = new java.sql.Date(System.currentTimeMillis());
    }
	
	public Persona getPer() {
		return per;
	}
	public void setPer(Persona per) {
		this.per = per;
	}
	
	public void addLinea(LineaVenta linea) {
		this.lineas.add(linea);
	}

	public String getFormaEnvio() {
		return formaEnvio;
	}
	
	public void setFormaEnvio(String formaEnvio) {
		this.formaEnvio = formaEnvio;
	}
	
	public double getCostoEnvio() {
		return costoEnvio;
	}
	
	public void setCostoEnvio(double costoEnvio) {
		this.costoEnvio = costoEnvio;
	}
	
	public String getFormaPago() {
		return formaPago;
	}
	
	public void setFormaPago(String formaPago) {
		this.formaPago = formaPago;
	}
}
