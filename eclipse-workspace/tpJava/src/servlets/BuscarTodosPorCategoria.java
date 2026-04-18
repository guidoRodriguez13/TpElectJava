package servlets;

import java.io.IOException;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Categoria;
import entidades.Producto;
import entidades.Venta;
import logic.ControladorCategoria;
import logic.ControladorProducto;

@WebServlet("/BuscarTodosPorCategoria")
public class BuscarTodosPorCategoria extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BuscarTodosPorCategoria() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Producto p = new Producto();
		Categoria c = new Categoria();
		LinkedList<Producto> prods = new LinkedList<Producto>();
		
		c.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));		
		
		ControladorCategoria cc = new ControladorCategoria();
		c = cc.getById(c);
		p.setCat(c);
		int cat = p.getCat().getIdCategoria();
		
		ControladorProducto cp = new ControladorProducto();
		prods = cp.getByCategoria(c);
		
		HttpSession misession = request.getSession();
		misession.setAttribute("prods", prods);
		misession.setAttribute("categoria", cat);
		misession.setAttribute("nombreCategoria", c.getNombre()); //guardo el nombre para usarlo en el jsp
		
		request.getRequestDispatcher("ProductosPorCategoria.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String descripcion = request.getParameter("descripcion");
		String nombre = request.getParameter("nombre");
		String precio = request.getParameter("precio");
		String stock = request.getParameter("stock");
		String categoria = request.getParameter("categoria");
		String marca = request.getParameter("marca");
		
		doGet(request, response);
	}

}
