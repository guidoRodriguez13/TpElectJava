package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entidades.LineaVenta;
import entidades.Persona;
import entidades.Venta;
import logic.ControladorCliente;
import logic.ControladorLineaVenta;
import logic.ControladorProducto;
import logic.ControladorVenta;

@WebServlet("/FinalizarCompra")
public class FinalizarCompra extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FinalizarCompra() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession misession = request.getSession();
        Persona p = (Persona) misession.getAttribute("usuario");
        
        //Obtengo formaEnvío desde el request
        String formaEnvio = request.getParameter("formaEnvio");
        //Obtengo formaPago
        String formaPago = request.getParameter("formaPago");
        
        // Calculo costoEnvío
        double costoEnvio = 0;
        if ("domicilio".equals(formaEnvio)) {
            costoEnvio = 1500;
        } else if ("express".equals(formaEnvio)) {
            costoEnvio = 3000;
        }
        // "retiro" = 0

        ControladorVenta cv = new ControladorVenta();
        ControladorCliente cc = new ControladorCliente();
        ControladorLineaVenta cl = new ControladorLineaVenta();
        ControladorProducto cp = new ControladorProducto();
        
        Venta venta = (Venta) misession.getAttribute("venta");
        venta.setPer(p);
        venta.setFechaVentaActual();
        
        //Guardo tipoEnvío y costoVenta
        venta.setFormaEnvio(formaEnvio);
        venta.setCostoEnvio(costoEnvio);
        venta.setFormaPago(formaPago);
        
        venta = cv.alta(venta); //Guardo venta BD
        
        // Creo las lineaVenta en la BD
        ArrayList<LineaVenta> lineaventa = (ArrayList<LineaVenta>) venta.getLineas();
        for (LineaVenta lv : lineaventa) {
            cl.alta(lv);
            cp.updatePorCompra(lv.getCant(), lv.getProd().getIdProducto()); // UPDATE STOCKS
        }
        
        misession.setAttribute("venta", venta);
        
        response.sendRedirect("CompraRealizada.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

//package servlets;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import entidades.LineaVenta;
//import entidades.Persona;
//import entidades.Venta;
//import logic.ControladorCliente;
//import logic.ControladorLineaVenta;
//import logic.ControladorProducto;
//import logic.ControladorVenta;
//
//@WebServlet("/FinalizarCompra")
//public class FinalizarCompra extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//
//    public FinalizarCompra() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		HttpSession misession = request.getSession();
//		Persona p = (Persona) misession.getAttribute("usuario");
//
//		ControladorVenta cv = new ControladorVenta();
//		ControladorCliente cc = new ControladorCliente();
//		ControladorLineaVenta cl = new ControladorLineaVenta();
//		ControladorProducto cp = new ControladorProducto();
//		
//		Venta venta = (Venta) misession.getAttribute("venta");
//		venta.setPer(p);
//		venta.setFechaVentaActual();
//		
//		venta = cv.alta(venta);//GUARDO LA VENTA EN LA BASE DE DATOS
//		//Creo las lineaVenta en la BD
//		ArrayList<LineaVenta> lineaventa = (ArrayList<LineaVenta>) venta.getLineas();
//		for ( LineaVenta lv : lineaventa) {
//			cl.alta(lv); //DA ERROR SI ES ADMIN
//			cp.updatePorCompra(lv.getCant(), lv.getProd().getIdProducto()); //UPDATE STOCKS
//		}
//		
//		misession.setAttribute("venta", venta);
//		
//		response.sendRedirect("CompraRealizada.jsp");
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}
