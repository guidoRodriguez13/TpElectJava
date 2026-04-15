package servlets;

import java.io.IOException;

import entidades.LineaVenta;
import entidades.Producto;
import entidades.Venta;
import logic.ControladorProducto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GuardarLineaVenta")
public class GuardarLineaVenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GuardarLineaVenta() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LineaVenta lineaVenta = new LineaVenta();
		Producto p = new Producto();
		ControladorProducto cp = new ControladorProducto();
		p.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
		
		lineaVenta.setCant(Integer.parseInt(request.getParameter("cantidad")));
		lineaVenta.setProd(cp.buscar(p));
		lineaVenta.setPrecioUnit(lineaVenta.getProd().getPrecio()); //Precio duplicado
		
		HttpSession misession = request.getSession();
		
		Venta venta = (Venta) misession.getAttribute("venta");
	    
	    // Si no existe venta, crear una nueva
	    if (venta == null) {
	        venta = new Venta();
	    }
//		Venta venta = (Venta) misession.getAttribute("venta"); 
		venta.addLinea(lineaVenta);
		
		//Guardo la venta en la session
	    misession.setAttribute("venta", venta);
		
		response.sendRedirect("Carrito.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
