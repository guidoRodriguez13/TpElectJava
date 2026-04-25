//package servlets;
//
//import java.io.IOException;
//import java.util.LinkedList;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import entidades.Producto;
//import logic.ControladorProducto;
//
//@WebServlet("/OrdenarProductoA")
//public class OrdenarProductoA extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    public OrdenarProductoA() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		LinkedList<Producto> prods = new LinkedList<>();
//		ControladorProducto cp = new ControladorProducto();
//		
//		prods = cp.listadoPorPrecioA();
//
//		HttpSession misession = request.getSession();
//		misession.setAttribute("prods", prods);
//		
//		response.sendRedirect("mostrarProductos.jsp");
//	}
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}
//
//}
package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Producto;

@WebServlet("/OrdenarProductoA")
public class OrdenarProductoA extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<Producto> productos = (List<Producto>) session.getAttribute("prods");
        
        if (productos != null && !productos.isEmpty()) {
            // Ordenar por precio ascendente (menor a mayor)
            productos.sort((p1, p2) -> Double.compare(p1.getPrecio(), p2.getPrecio()));
            session.setAttribute("prods", productos);
            System.out.println("Productos ordenados ascendente - Primer precio: " + productos.get(0).getPrecio());
            session.setAttribute("ordenPrecio", "ascendente");
        } else {
            System.out.println("No hay productos en sesión para ordenar");
        }
        
        response.sendRedirect("mostrarProductos.jsp");
    }
}