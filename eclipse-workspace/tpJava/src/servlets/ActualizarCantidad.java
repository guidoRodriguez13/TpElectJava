package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.LineaVenta;
import entidades.Venta;

@WebServlet("/ActualizarCantidad")
public class ActualizarCantidad extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public ActualizarCantidad() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
        
        // Busco la venta de la sesion
        HttpSession session = request.getSession();
        Venta venta = (Venta) session.getAttribute("venta");
        
        if (venta != null) {
            // Busco líneaVenta por la idProducto que obtuve arriba
            for (LineaVenta lv : venta.getLineas()) {
                if (lv.getProd().getIdProducto() == idProducto) {
                    if (nuevaCantidad <= 0) {
                        venta.getLineas().remove(lv);
                    } else {
                        lv.setCant(nuevaCantidad);
                    }
                    break;
                }
            }
            
            // Guardo la LineaVenta
            session.setAttribute("venta", venta);
        }
        
        response.sendRedirect("MostrarCarrito");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

//package servlets;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
///**
// * Servlet implementation class actualizarCantidad
// */
//@WebServlet("/actualizarCantidad")
//public class ActualizarCantidad extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public ActualizarCantidad() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}
