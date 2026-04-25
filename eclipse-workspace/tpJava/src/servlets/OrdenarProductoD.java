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

@WebServlet("/OrdenarProductoD")
public class OrdenarProductoD extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<Producto> productos = (List<Producto>) session.getAttribute("prods");
        
        if (productos != null && !productos.isEmpty()) {
            // Ordenar por precio descendente (mayor a menor)
            productos.sort((p1, p2) -> Double.compare(p2.getPrecio(), p1.getPrecio()));
            session.setAttribute("prods", productos);
            session.setAttribute("ordenPrecio", "descendente");
            System.out.println("Productos ordenados DESCENDENTE - Primer precio: " + productos.get(0).getPrecio());
        } else {
            System.out.println("No hay productos en sesión para ordenar");
        }
        
        response.sendRedirect("mostrarProductos.jsp");
    }
}