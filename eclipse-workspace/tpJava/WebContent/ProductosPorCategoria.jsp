<%@page import="java.util.List"%>
<%@page import="entidades.Producto"%>
<%@page import="entidades.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Productos por categoría - E-shop</title>
</head>
<body>
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
		            <span>Bienvenido, <%= user.getNombre() %></span>
		            
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
		        <button class="btn" style="background-color: #28a745;" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
		    </div>
		</div>
        
        <div style="display: flex; justify-content: center; margin: 20px 0;">
		    <div class="form-container">
		        <div style="background-color: #f8f9fa; border: 1px solid #ddd; border-radius: 8px; padding: 12px 24px;">
		            <h2 style="margin: 0; color: #333;"> <%= session.getAttribute("nombreCategoria") %></h2>
		        </div>
		    </div>
		</div>
        
        <div class="productos-grid">
        <%
            List<Producto> listaProductos = (List<Producto>) session.getAttribute("prods");
            if (listaProductos != null && !listaProductos.isEmpty()) {
                for (Producto p : listaProductos) {
                    if (p.getStock() != 0) {
        %>
            <div class="producto-card">
                <h3><%= p.getNombre() %></h3>
                <p><%= p.getDescripcion() %></p>
                <p class="precio">$<%= p.getPrecio() %></p>
                <p>Stock: <%= p.getStock() %></p>
                <p>Marca: <%= p.getBrand().getNombre() %></p>
                <form action="NuevaLineaVenta" method="POST">
                    <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
                    <label>Cantidad:</label>
                    <input type="number" name="cantidad" value="1" min="1" max="<%= p.getStock() %>" class="cantidad-input">
                    <br>
                    <button type="submit" class="btn btn-primary">Agregar al carrito</button>
                </form>
            </div>
        <%
                    }
                }
            } else {
        %>
            <p>No hay productos disponibles en esta categoría.</p>
        <%
            }
        %>
        </div>
        
        <a href="index.jsp">Volver a Inicio</a>
    </div>
</body>
</html>

<%-- <%@page import="java.util.List"%> --%>
<%-- <%@page import="entidades.Producto"%> --%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- 	<head> -->
<!-- 		<meta charset="UTF-8"> -->
<!-- 		<title>Producto por categoria</title> -->
<!-- 	</head> -->
<!-- 	<body> -->
<!-- 		<h1>Lista de productos de la Categoria</h1> -->
<%-- 		<% --%>
<!-- // 			List<Producto> listaProductos = (List<Producto>) request.getSession().getAttribute("prods"); -->
<!-- // 			for(Producto p : listaProductos){ -->
<!-- // 				if (p.getStock() != 0){ -->
<%-- 		%> --%>
<!-- 				<p> -->
<%--             	<strong>ID:</strong> <%=p.getIdProducto() %> | --%>
<%--             	<strong>Descripción:</strong> <%=p.getDescripcion() %> | --%>
<%--             	<strong>Nombre:</strong> <%=p.getNombre() %> | --%>
<%--             	<strong>Precio:</strong> <%=p.getPrecio() %> | --%>
<%--             	<strong>Stock:</strong> <%=p.getStock() %> | --%>
<%--             	<strong>Categoría:</strong> <%=p.getCat().getNombre() %> | --%>
<%--             	<strong>Marca:</strong> <%=p.getBrand().getNombre() %> --%>
<!--             	<form action="NuevaLineaVenta" method="POST"> -->
<%--             	<input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>"> --%>
<!-- 				<p><label> Cantidad: </label> <input type="text" name="cantidad" value="1"></p> -->
<!-- 				<button type="submit" > Cargar al carrito</button> -->
<!-- 				</form> -->
        						
		
<!-- 				<p>---------------------------------</p> -->
<%-- 				<% } %> --%>
<%-- 		<% } %> --%>
<!-- 		<a href="index.jsp">Volver a Inicio</a> -->
<!-- 	</body> -->
<!-- </html> -->