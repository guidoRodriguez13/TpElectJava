<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Producto"%>
<%@page import="entidades.Persona"%>
<%@page import="entidades.Categoria"%>
<%@page import="logic.ControladorCategoria"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Mostrar productos - E-shop</title>
</head>
<body>
    <div class="main-container">
        <div class="navbar">
        	<div class="nav-logo">
		        <a href="index.jsp" style="font-weight: bold; color: var(--color-acento); font-size: 1.3rem;">FLUX</a>
		    </div>
            <div class="nav-links">
                <a href="index.jsp">Inicio</a>
                <a href="${pageContext.request.contextPath}/BuscarTodosProducto">Productos</a>
                <a href="#">Ofertas</a>
                <a href="#">Contacto</a>
            </div>
            
            <div class="nav-buttons">
                <% if (session.getAttribute("usuario") == null) { %>
                    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/FormularioInicioSesion.jsp'">Iniciar Sesión</button>
                    <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/NuevaCuenta'">Registrarse</button>
                <% } else { 
                    Persona user = (Persona) session.getAttribute("usuario");
                %>
                    <span class="welcome-text">Bienvenido, <%= user.getNombre() %></span>
                    
                    <% if (user.isEsAdmin()) { %>
                        <div class="dropdown">
                            <button class="btn btn-outline">Administrar ▼</button>
                            <div class="dropdown-content">
                                <a href="${pageContext.request.contextPath}/FormularioAltaProductoServlet">Alta Producto</a>
                                <a href="${pageContext.request.contextPath}/BuscarTodosUsuarios">Listar Usuarios</a>
                                <a href="${pageContext.request.contextPath}/FormularioAltaCategoria">Nueva Categoría</a>
                                <a href="${pageContext.request.contextPath}/FormularioAltaMarca">Nueva Marca</a>
                            </div>
                        </div>
                    <% } %>
                    
                    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/CerrarSesion'">Cerrar Sesión</button>
                <% } %>
                <button class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
            </div>
        </div>
        
        <div class="content-wrapper">
            <h1>Productos</h1>
            
            <div class="ordenamiento-botones">
                <form action="${pageContext.request.contextPath}/OrdenarProductoA" method="GET">
                    <button type="submit" class="btn btn-outline">⬆️ Precio ascendente</button>
                </form>
                <form action="${pageContext.request.contextPath}/OrdenarProductoD" method="GET">
                    <button type="submit" class="btn btn-outline">⬇️ Precio descendente</button>
                </form>
            </div>
            
            <div class="ordenamiento-botones" style="gap: 15px;">
                <form action="${pageContext.request.contextPath}/BusquedaAvanzada" method="GET" style="display: flex; gap: 10px; align-items: flex-end; flex-wrap: wrap;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="idCategoria" style="display: block; font-size: 0.8rem; margin-bottom: 5px;">Categoría</label>
                        <select name="idCategoria" id="idCategoria" class="btn btn-outline" style="padding: 0.5rem 1rem;">
                            <option value="0">Todas las categorías</option>
                            <%
                                ControladorCategoria cc = new ControladorCategoria();
                                List<Categoria> categorias = cc.listar();
                                for (Categoria cat : categorias) {
                            %>
                                <option value="<%= cat.getIdCategoria() %>"><%= cat.getNombre() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="precioMin" style="display: block; font-size: 0.8rem; margin-bottom: 5px;">Precio mín.</label>
                        <input type="number" name="precioMin" id="precioMin" placeholder="$0" class="btn btn-outline" style="width: 100px; padding: 0.5rem 1rem;">
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="precioMax" style="display: block; font-size: 0.8rem; margin-bottom: 5px;">Precio máx.</label>
                        <input type="number" name="precioMax" id="precioMax" placeholder="$999999" class="btn btn-outline" style="width: 100px; padding: 0.5rem 1rem;">
                    </div>
                    <button type="submit" class="btn btn-primary">🔍 Filtrar</button>
                    <a href="${pageContext.request.contextPath}/BuscarTodosProducto" class="btn btn-outline">🗑️ Limpiar</a>
                </form>
            </div>
            
            <%
                List<Producto> listaProductos = (List<Producto>) session.getAttribute("prods");
                
                if (listaProductos != null && !listaProductos.isEmpty()) {
                    
                    // Ordenar la lista completa según el valor en sesión
                    String orden = (String) session.getAttribute("ordenPrecio");
                    if ("ascendente".equals(orden)) {
                        listaProductos.sort((p1, p2) -> Double.compare(p1.getPrecio(), p2.getPrecio()));
                    } else if ("descendente".equals(orden)) {
                        listaProductos.sort((p1, p2) -> Double.compare(p2.getPrecio(), p1.getPrecio()));
                    }
                    
                    // Agrupar por categoría
                    Map<String, List<Producto>> productosPorCategoria = new HashMap<>();
                    for (Producto p : listaProductos) {
                        String categoria = p.getCat().getNombre();
                        if (!productosPorCategoria.containsKey(categoria)) {
                            productosPorCategoria.put(categoria, new ArrayList<>());
                        }
                        productosPorCategoria.get(categoria).add(p);
                    }
                    
                    // Mostrar cada categoría
                    for (Map.Entry<String, List<Producto>> entry : productosPorCategoria.entrySet()) {
                        String categoria = entry.getKey();
                        List<Producto> productos = entry.getValue();
            %>
                        <div class="categoria-section">
                            <h2><%= categoria %></h2>
                            <div class="productos-grid">
                            <% for (Producto p : productos) { %>
                                <div class="producto-card">
                                    <h3><%= p.getNombre() %></h3>
                                    <p><%= p.getDescripcion() %></p>
                                    <p class="precio">$<%= p.getPrecio() %></p>
                                    <p>Stock: <%= p.getStock() %></p>
                                    <p>Marca: <%= p.getBrand().getNombre() %></p>
                                    <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/GuardarLineaVenta?idProducto=<%= p.getIdProducto() %>&cantidad=1'">Agregar al carrito</button>
                                </div>
                            <% } %>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                    <p>No hay productos disponibles.</p>
            <% } %>
            
            <a href="index.jsp">← Volver a Inicio</a>
        </div>
        
        <!-- FOOTER -->
        <footer>
            <p>© 2024 E-shop - Todos los derechos reservados</p>
        </footer>
    </div>
</body>
</html>