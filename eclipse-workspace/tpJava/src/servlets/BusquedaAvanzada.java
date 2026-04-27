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
import logic.ControladorProducto;

@WebServlet("/BusquedaAvanzada")
public class BusquedaAvanzada extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BusquedaAvanzada() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Parámetros del formulario
        String idCategoriaParam = request.getParameter("idCategoria");
        String precioMinParam = request.getParameter("precioMin");
        String precioMaxParam = request.getParameter("precioMax");
        
        // Valores por defecto
        int idCategoria = 0;
        double precioMin = 0;
        double precioMax = 999999;
        
        // Convierto los parámetros
        try {
            if (idCategoriaParam != null && !idCategoriaParam.isEmpty()) {
                idCategoria = Integer.parseInt(idCategoriaParam);
            }
            if (precioMinParam != null && !precioMinParam.isEmpty()) {
                precioMin = Double.parseDouble(precioMinParam);
            }
            if (precioMaxParam != null && !precioMaxParam.isEmpty()) {
                precioMax = Double.parseDouble(precioMaxParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        // Busco productos con filtros
        ControladorProducto cp = new ControladorProducto();
        List<Producto> productos = cp.buscarAvanzado(idCategoria, precioMin, precioMax);
        
        // Guardo en la sesión
        HttpSession session = request.getSession();
        session.setAttribute("prods", productos);
        
        // Redirijo a mostrarProductos
        response.sendRedirect("mostrarProductos.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}