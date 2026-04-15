<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidades.Producto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
		<meta charset="UTF-8">
    	<title>Mostrar productos</title>
    	<style>
	        .form-container {
	            display: inline-block;
	        }
	        
	        form {
	            display: inline-block;
	            margin-right: 10px;
	        }
	        
	        /* Navbar */
	        .navbar {
	            display: flex;
	            justify-content: space-between;
	            align-items: center;
	            padding: 1rem 2rem;
	            background-color: #f8f9fa;
	            border-bottom: 1px solid #ddd;
	            margin-bottom: 2rem;
	        }
	        
	        .nav-links {
	            display: flex;
	            gap: 2rem;
	        }
	        
	        .nav-links a {
	            text-decoration: none;
	            color: #333;
	            font-weight: 500;
	        }
	        
	        .nav-links a:hover {
	            color: #007bff;
	        }
	        
	        .nav-buttons {
	            display: flex;
	            gap: 1rem;
	            align-items: center;
	        }
	        
	        .btn {
	            padding: 0.5rem 1rem;
	            border-radius: 4px;
	            text-decoration: none;
	            font-weight: 500;
	            cursor: pointer;
	            border: none;
	        }
	        
	        .btn-outline {
	            background-color: transparent;
	            border: 1px solid #007bff;
	            color: #007bff;
	        }
	        
	        .btn-outline:hover {
	            background-color: #007bff;
	            color: white;
	        }
	        
	        .btn-primary {
	            background-color: #007bff;
	            color: white;
	        }
	        
	        .btn-primary:hover {
	            background-color: #0056b3;
	        }
	        
	        /* Productos grid */
	        .productos-grid {
	            display: grid;
	            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	            gap: 20px;
	            margin: 20px 0;
	        }
	        
	        .producto-card {
	            border: 1px solid #ddd;
	            padding: 10px;
	            border-radius: 5px;
	            text-align: center;
	        }
	        
	        .precio {
	            font-weight: bold;
	            color: #007bff;
	            font-size: 1.2rem;
	        }
	        
	        .categoria-section {
	            margin-bottom: 30px;
	            border-bottom: 2px solid #ddd;
	            padding-bottom: 10px;
	        }
    	</style>
	</head>
	<body>
		<div style="padding: 0 2rem;">
			<!-- NAVBAR -->
			<div class="navbar">
			    <div class="nav-links">
			        <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
			        <a href="${pageContext.request.contextPath}/BuscarTodosProducto">Productos</a>
			        <a href="#">Ofertas</a>
			        <a href="#">Contacto</a>
			    </div>
			    
			    <div class="nav-buttons">
			        <% if (session.getAttribute("usuario") == null) { %>
			            <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/formularioInicioSesion.jsp'">Iniciar Sesión</button>
			            <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/NuevaCuenta'">Registrarse</button>
			        <% } else { %>
			            <span>Bienvenido, ${usuario.nombre}</span>
			            <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/CerrarSesion'">Cerrar Sesión</button>
			        <% } %>
			        <button class="btn" style="background-color: #28a745;" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
			    </div>
			</div>
			
			<h1>Lista de productos</h1>
			
			<div class="form-container">
				<form action="OrdenarProductoA" method="GET">
					<button type="submit">Orden precio ascendente</button>
				</form>
				<form action="OrdenarProductoD" method="GET">
					<button type="submit">Orden precio descendente</button>
				</form>
			</div>
			
			<%
				List<Producto> listaProductos = (List<Producto>) session.getAttribute("prods");
				if (listaProductos != null && !listaProductos.isEmpty()) {
					
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
									<p><strong><%= p.getNombre() %></strong></p>
									<p>Precio: $<%= p.getPrecio() %></p>
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
			
			<p>---------------------------------</p>
			<a href="index.jsp">Volver a Inicio</a>
		</div>
	</body>
</html>

<%-- <%@page import="java.util.List"%> --%>
<%-- <%@page import="entidades.Producto"%> --%>

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%>  --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- 	<head> -->
<!-- 		<meta charset="UTF-8"> -->
<!--     <title>Mostrar productos</title> -->
<!--     <style> -->
/*         .form-container { */
/*             display: inline-block; */
/*         } */
        
/*         form { */
/*             display: inline-block; */
/*             margin-right: 10px; */
/*         } */
<!--     </style> -->
<!-- 	</head> -->
<!-- 	<body> -->
<!-- 		<h1>Lista de productos</h1> -->
		
<!-- 		<div class="form-container"> -->
<!-- 			<form action="OrdenarProductoA" method="GET"> -->
<!-- 			<button type="submit" > Orden precio ascendente </button> -->
<!-- 			</form> -->
<!-- 			<form action="OrdenarProductoD" method="GET"> -->
<!-- 			<button type="submit" > Comprar precio descendente </button> -->
<!-- 			</form> -->
<!-- 		</div> -->
<%-- 		<% --%>
// 			List<Producto> listaProductos = (List<Producto>) session.getAttribute("prods");
// 			if (listaProductos != null && !listaProductos.isEmpty()) {
// 	        	for (Producto p : listaProductos) {
<%-- 		%> --%>
<!-- 				<p> -->
<%--             	<strong>ID:</strong> <%=p.getIdProducto() %> | --%>
<%--             	<strong>Descripción:</strong> <%=p.getDescripcion() %> | --%>
<%--             	<strong>Nombre:</strong> <%=p.getNombre() %> | --%>
<%--             	<strong>Precio:</strong> <%=p.getPrecio() %> | --%>
<%--             	<strong>Stock:</strong> <%=p.getStock() %> | --%>
<%--             	<strong>Categoría:</strong> <%=p.getCat().getNombre() %> | --%>
<%--             	<strong>Marca:</strong> <%=p.getBrand().getNombre() %> --%>
<!--         		</p> -->
<%-- 		<%  --%>
// 			}
// 	       } else {
<%-- 	    %> --%>
<!-- 	    	<p>No hay productos disponibles.</p> -->
<%-- 		<% } %> --%>
<!-- 		<p>---------------------------------</p> -->
<!-- 		<a href="index.jsp">Volver a Inicio</a> -->
<!-- 	</body> -->
<!-- </html> -->