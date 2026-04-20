<%@page import="java.util.List"%>
<%@page import="entidades.Producto"%>
<%@page import="entidades.Persona"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <meta charset="UTF-8">
    <title>Productos por categoría - E-shop</title>
    <style>
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
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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
        
        .cantidad-input {
            width: 60px;
            padding: 5px;
            text-align: center;
            margin: 5px 0;
        }
        .dropdown {
		    position: relative;
		    display: inline-block;
		}
		
		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f9f9f9;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}
		
		.dropdown-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		    text-align: left;
		}
		
		.dropdown-content a:hover {
		    background-color: #f1f1f1;
		}
		
		.dropdown:hover .dropdown-content {
		    display: block;
		}
    </style>
</head>
<body>
    <div style="padding: 0 2rem;">

        <!-- NAVBAR -->
		<div class="navbar">
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
		            <span style="font-weight: bold; color: #28a745;">Bienvenido, <%= user.getNombre() %></span>
		            
		            <% if (user.isEsAdmin()) { %>
		                <div class="dropdown">
		                    <button class="btn btn-outline">Administrar ▼</button>
		                    <div class="dropdown-content">
		                        <a href="${pageContext.request.contextPath}/FormularioAltaProductoServlet">➕ Alta Producto</a>
		                        <a href="${pageContext.request.contextPath}/BuscarTodosUsuarios">👥 Listar Usuarios</a>
		                        <a href="${pageContext.request.contextPath}/FormularioAltaCategoria">🏷️ Nueva Categoría</a>
		                        <a href="${pageContext.request.contextPath}/FormularioAltaMarca">⭐ Nueva Marca</a>
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