package logic;

import java.util.LinkedList;

import java.util.List;

import datos.DatosProductos;
import entidades.Categoria;
import entidades.Producto;

public class ControladorProducto {

	DatosProductos datos = new DatosProductos();
	
	public LinkedList<Producto> listar(){
		datos = new DatosProductos();
		return datos.listar();
	}
	
	public Producto buscar(Producto p) {
		datos = new DatosProductos();
		return datos.buscar(p);
	}
	
	public LinkedList<Producto> getByCategoria(Categoria c) {
		datos = new DatosProductos();
		return datos.getByCategoria(c);
	}
	
	public void alta(Producto p){
		datos.alta(p);
	}
	
	public void baja(Producto p) {
		datos.baja(p);
	}

	public void update(Producto p) {
		datos.update(p);
	}
	
	public LinkedList<Producto> listadoPorPrecioA() {
		datos = new DatosProductos();
		return datos.listadoPorPrecioA();
	}
	
	public LinkedList<Producto> listadoPorPrecioD() {
		datos = new DatosProductos();
		return datos.listadoPorPrecioD();
	}

	public void updatePorCompra(int cant, int idProducto) {
		datos.updatePorCompra(cant, idProducto);
	}
	// NUEVA FUNCION PARA TRAER PRODUCTOS DE LA BD Y MOSTRAR EN INDEX.JSP
	public List<Producto> getProductosDestacados() {
	    DatosProductos dao = new DatosProductos();
	    return dao.getProductosDestacados();
	}
	
	public List<Producto> buscarAvanzado(int idCategoria, double precioMin, double precioMax) {
	    DatosProductos dp = new DatosProductos();
	    return dp.buscarAvanzado(idCategoria, precioMin, precioMax);
	}
}
