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
</head>
<body>
<div class="main-container">
	<div class="navbar">
		<div class="nav-logo">
    		<a href="index.jsp">
        		<img src="${pageContext.request.contextPath}/images/flux.png" alt="FLUX" style="height: 100px;">
    		</a>
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

	<!-- BANNER -->
<div style="width: 100%; margin-bottom: 0;">
    <img src="${pageContext.request.contextPath}/images/fluxbanner.png" alt="FLUX Banner" style="width: 100%; height: 350px; display: block; object-fit: cover;">
</div>

	<div class="content-wrapper"></div>
    <div style="padding: 0 2rem;">
        
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

<!--         PRODUCTOS DESTACADOS DESDE BD -->
<!-- 		<h2>Productos Destacados</h2> -->
<%-- 		<% --%>
<!-- // 		    List<Producto> productos = (List<Producto>) request.getAttribute("productos"); -->
<!-- // 		    if (productos != null && !productos.isEmpty()) { -->
<%-- 		%> --%>
<!-- 		    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; margin: 20px 0;"> -->
<%-- 		        <% for (Producto prod : productos) { %> --%>
<!-- 		            <div style="border: 1px solid #ddd; padding: 10px; border-radius: 5px;"> -->
<%-- 		                <h3><%= prod.getNombre() %></h3> --%>
<%-- 		                <p><%= prod.getDescripcion() %></p> --%>
<%-- 		                <p class="precio">$<%= prod.getPrecio() %></p> --%>
<%-- 		                <button class="btn btn-primary" onclick="agregarAlCarrito(<%= prod.getIdProducto() %>)">Agregar</button> --%>
<!-- 		            </div> -->
<%-- 		        <% } %> --%>
<!-- 		    </div> -->
<%-- 		<% --%>
<!-- // 		    } else { -->
<%-- 		%> --%>
<!-- 		    <p>No hay productos destacados disponibles.</p> -->
<%-- 		<%    }%> --%>
        
        <div style="display: flex; justify-content: center; gap: 10px; margin: 20px 0;">
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