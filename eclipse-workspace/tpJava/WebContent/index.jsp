<%@page import="entidades.Persona" %>
<%@page import="entidades.Cliente" %>
<%@page import="entidades.Administrador" %>
<%@page import="java.util.List, entidades.Producto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>E-shop - Inicio</title>
<!--     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css"> -->
<!--     <meta charset="UTF-8"> -->
<!--     <title> E-shop </title> -->
<!--     <style> -->
<!-- /*         /* Navbar */ */ -->
<!-- /*         .navbar { */ -->
<!-- /*             display: flex; */ -->
<!-- /*             justify-content: space-between; */ -->
<!-- /*             align-items: center; */ -->
<!-- /*             padding: 1rem 2rem; */ -->
<!-- /*             background-color: #f8f9fa; */ -->
<!-- /*             border-bottom: 1px solid #ddd; */ -->
<!-- /*             margin-bottom: 2rem; */ -->
<!-- /*         } */ -->
        
<!-- /*         .nav-links { */ -->
<!-- /*             display: flex; */ -->
<!-- /*             gap: 2rem; */ -->
<!-- /*         } */ -->
        
<!-- /*         .nav-links a { */ -->
<!-- /*             text-decoration: none; */ -->
<!-- /*             color: #333; */ -->
<!-- /*             font-weight: 500; */ -->
<!-- /*         } */ -->
        
<!-- /*         .nav-links a:hover { */ -->
<!-- /*             color: #007bff; */ -->
<!-- /*         } */ -->
        
<!-- /*         .nav-buttons { */ -->
<!-- /*             display: flex; */ -->
<!-- /*             gap: 1rem; */ -->
<!-- /*         } */ -->
        
<!-- /*         .btn { */ -->
<!-- /*             padding: 0.5rem 1rem; */ -->
<!-- /*             border-radius: 4px; */ -->
<!-- /*             text-decoration: none; */ -->
<!-- /*             font-weight: 500; */ -->
<!-- /*             cursor: pointer; */ -->
<!-- /*             border: none; */ -->
<!-- /*         } */ -->
        
<!-- /*         .btn-outline { */ -->
<!-- /*             background-color: transparent; */ -->
<!-- /*             border: 1px solid #007bff; */ -->
<!-- /*             color: #007bff; */ -->
<!-- /*         } */ -->
        
<!-- /*         .btn-outline:hover { */ -->
<!-- /*             background-color: #007bff; */ -->
<!-- /*             color: white; */ -->
<!-- /*         } */ -->
        
<!-- /*         .btn-primary { */ -->
<!-- /*             background-color: #007bff; */ -->
<!-- /*             color: white; */ -->
<!-- /*         } */ -->
        
<!-- /*         .btn-primary:hover { */ -->
<!-- /*             background-color: #0056b3; */ -->
<!-- /*         } */ -->
        
<!-- /*         /* Mantener estilos originales */ */ -->
<!-- /*         .form-container { */ -->
<!-- /*             display: inline-block; */ -->
<!-- /*         } */ -->
        
<!-- /*         form { */ -->
<!-- /*             display: inline-block; */ -->
<!-- /*             margin-right: 10px; */ -->
<!-- /*         } */ -->
<!-- /*         .dropdown { */ -->
<!-- /* 		    position: relative; */ -->
<!-- /* 		    display: inline-block; */ -->
<!-- /* 		} */ -->
		
<!-- /* 		.dropdown-content { */ -->
<!-- /* 		    display: none; */ -->
<!-- /* 		    position: absolute; */ -->
<!-- /* 		    background-color: #f9f9f9; */ -->
<!-- /* 		    min-width: 160px; */ -->
<!-- /* 		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); */ -->
<!-- /* 		    z-index: 1; */ -->
<!-- /* 		} */ -->
		
<!-- /* 		.dropdown-content a { */ -->
<!-- /* 		    color: black; */ -->
<!-- /* 		    padding: 12px 16px; */ -->
<!-- /* 		    text-decoration: none; */ -->
<!-- /* 		    display: block; */ -->
<!-- /* 		    text-align: left; */ -->
<!-- /* 		} */ -->
		
<!-- /* 		.dropdown-content a:hover { */ -->
<!-- /* 		    background-color: #f1f1f1; */ -->
<!-- /* 		} */ -->
		
<!-- /* 		.dropdown:hover .dropdown-content { */ -->
<!-- /* 		    display: block; */ -->
<!-- /* 		} */ -->
<!--     </style> -->
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

    <!-- CONTENIDO PRINCIPAL -->
    <div style="padding: 0 2rem;">
        <h1> Bienvenidos a FLUX </h1>
        
        <!-- SECCIÓN USUARIO LOGUEADO (comentada por ahora) -->
        <%-- 
        <% if (request.getSession().getAttribute("usuario") != null) { 
            Cliente cli = new Cliente();
            if (request.getSession().getAttribute("usuario").getClass() == cli.getClass()){
                Cliente user = (Cliente) request.getSession().getAttribute("usuario");
        %>
            <h2>Bienvenido <%=user.getNombre() + " " %><%=user.getApellido()%></h2>
            
            <div class="form-container">
                <form action="Perfil" method="GET">
                    <input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>">
                    <button type="submit" > Perfil </button>
                </form>
                <form action="Historial" method="POST">
                    <input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>">
                    <button type="submit" > Historial </button>
                </form>
            </div>
        <% 
            } else { 
                Administrador user = (Administrador) request.getSession().getAttribute("usuario");
        %>
            <h2>Bienvenido Admin <%=user.getNombre() + " " %><%=user.getApellido()%></h2>
            
            <div class="form-container">
                <form action="Perfil" method="GET">
                    <input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>">
                    <button type="submit" > Perfil </button>
                </form>
                <form action="Historial" method="POST">
                    <input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>">
                    <button type="submit" > Historial </button>
                </form>
            </div>
            
            <!-- Acciones de admin -->
            <h3>Panel de Administración</h3>
            <!-- ... resto del contenido admin ... -->
        <% 
            } 
        } 
        %>
        --%>

        <!-- PRODUCTOS DESTACADOS DESDE BD -->
		<h2>Productos Destacados</h2>
		<%
		    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
		    if (productos != null && !productos.isEmpty()) {
		%>
		    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; margin: 20px 0;">
		        <% for (Producto prod : productos) { %>
		            <div style="border: 1px solid #ddd; padding: 10px; border-radius: 5px;">
		                <h3><%= prod.getNombre() %></h3>
		                <p><%= prod.getDescripcion() %></p>
		                <p class="precio">$<%= prod.getPrecio() %></p>
		                <button class="btn btn-primary" onclick="agregarAlCarrito(<%= prod.getIdProducto() %>)">Agregar</button>
		            </div>
		        <% } %>
		    </div>
		<%
		    } else {
		%>
		    <p>No hay productos destacados disponibles.</p>
		<%    }%>
        
        <!-- CATEGORÍAS -->
        <h2>Categorías</h2>
        <div style="display: flex; gap: 10px; margin: 20px 0;">
		    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/BuscarTodosPorCategoria?idCategoria=3'">Memorias</button>
		    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/BuscarTodosPorCategoria?idCategoria=4'">Almacenamiento</button>
		    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/BuscarTodosPorCategoria?idCategoria=2'">Tarjetas gráficas</button>
		    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/BuscarTodosPorCategoria?idCategoria=5'">Fuentes</button>
		    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/BuscarTodosPorCategoria?idCategoria=1'">Procesadores</button>
		</div>
    </div>
 </div>
</body>
</html>