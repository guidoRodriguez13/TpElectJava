<%-- <%@page import="entidades.Persona" %> --%>
<%-- <%@page import="entidades.Cliente" %> --%>
<%-- <%@page import="entidades.Administrador" %> --%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- 	<head> -->
<!-- 	<link rel="stylesheet" -->
<!--       href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css"> -->
<!-- 		<meta charset="UTF-8"> -->
<!-- 		<title> E-shop </title> -->
<!-- 	<style> -->
<!-- /*         .form-container { */ -->
<!-- /*             display: inline-block; */ -->
<!-- /*         } */ -->
        
<!-- /*         form { */ -->
<!-- /*             display: inline-block; */ -->
<!-- /*             margin-right: 10px; */ -->
<!-- /*         } */ -->
<!--     </style> -->
<!-- 	</head> -->
<!-- 	<body> -->
<!-- 		<h1> Bienvenidos E-Shop </h1> -->
<%-- 		<%	if (request.getSession().getAttribute("usuario") == null){ %> --%>
		
<!-- 		<h1> Log In </h1> -->
<%-- 		<form action="${pageContext.request.contextPath}/InicioSesionServlet" method="post"> --%>
<!-- 		 <form action="InicioSesionServlet" method="get"> CODIGO ANTERIOR -->
<!-- 		<button type="submit" > Ingresar </button> -->
<!-- 		</form> -->
		
<!-- 		<form action="NuevaCuenta" method="get"> -->
<!-- 		<button type="submit" > Registrar </button> -->
<!-- 		</form> -->
<%-- 		<% } else { Cliente cli = new Cliente(); --%>
<!-- // 					if (request.getSession().getAttribute("usuario").getClass() == cli.getClass()){ -->
<!-- // 					Cliente user = (Cliente) request.getSession().getAttribute("usuario"); -->
<%-- 					%> --%>
<%-- 					<h1>Bienvenido <%=user.getNombre() + " " %><%=user.getApellido()%></h1> --%>
					
<!-- 					<div class="form-container"> -->
<!-- 						<form action="Perfil" method="GET"> -->
<%-- 						<input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>"> --%>
<!-- 						<button type="submit" > Perfil </button> -->
<!-- 						</form> -->
<!-- 						<form action="Historial" method="POST"> -->
<%-- 						<input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>"> --%>
<!-- 						<button type="submit" > Historial </button> -->
<!-- 						</form> -->
<!-- 					</div> -->
					
<!-- 					<h1> COMPRA </h1> -->
<!-- 					<form action="NuevaCompra" method="GET"> -->
<!-- 					<button type="submit" > Comprar productos</button> -->
<!-- 					</form> -->
		
<!-- 					<h1> PRODUCTOS </h1> -->
<!-- 					<h1> </h1> -->
<!-- 					<form action="BuscarTodosProducto" method="GET"> -->
<!-- 					<button type="submit" > Mostrar productos</button> -->
<!-- 					</form> -->
<%-- 				<% } else{ --%>
<!-- // 					Administrador user = (Administrador) request.getSession().getAttribute("usuario"); -->
<%-- 					%> --%>
<%-- 					<h1>Bienvenido Admin <%=user.getNombre() + " " %><%=user.getApellido()%></h1> --%>
					
<!-- 					<div class="form-container"> -->
<!-- 						<form action="Perfil" method="GET"> -->
<%-- 						<input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>"> --%>
<!-- 						<button type="submit" > Perfil </button> -->
<!-- 						</form> -->
<!-- 						<form action="Historial" method="POST"> -->
<%-- 						<input type="hidden" name="idPersona" value="<%=user.getIdPersona()%>"> --%>
<!-- 						<button type="submit" > Historial </button> -->
<!-- 						</form> -->
<!-- 					</div> -->
					
<!-- 					<h1> COMPRA </h1> -->
<!-- 		<form action="NuevaCompra" method="GET"> -->
<!-- 		<button type="submit" > Comprar productos</button> -->
<!-- 		</form> -->
		
<!-- 		<h1> PRODUCTOS </h1> -->
<!-- 		<h1> </h1> -->
<!-- 		<form action="BuscarTodosProducto" method="GET"> -->
<!-- 		<button type="submit" > Mostrar productos</button> -->
<!-- 		</form> -->

<!-- 		<form action="FormularioBusquedaPorIdServlet" method="POST"> -->
<!-- 		<button type="submit" > Buscar producto por ID</button> -->
<!-- 		</form> -->
		
<!-- 		<form action="FormularioAltaProductoServlet" method="POST"> -->
<!-- 		<button type="submit" > Alta producto</button> -->
<!-- 		</form> -->
		
<!-- 		<h1> USUARIOS </h1> -->
<!-- 		<h1> </h1> -->
		
<!-- 		<form action="BuscarTodosUsuarios" method="POST"> -->
<!-- 		<button type="submit" >Listar usuarios</button> -->
<!-- 		</form> -->
		
<!-- 		<form action="FormularioBusquedaUserPorIdServlet" method="POST"> -->
<!-- 		<button type="submit" > Buscar Usuario por ID</button> -->
<!-- 		</form> -->

<!-- 		<form action="FormularioBusquedaPorDniServlet" method="POST"> -->
<!-- 		<button type="submit" > Buscar usuario por DNI</button> -->
<!-- 		</form> -->
		
<!-- 		<h1> MARCAS </h1> -->
		
<!-- 		<div class="form-container"> -->
<!-- 			<form action="BuscarMarcas" method="GET"> -->
<!-- 			<button type="submit" > Mostrar Marcas </button> -->
<!-- 			</form> -->
<!-- 			<form action="FormularioAltaMarca" method="POST"> -->
<!-- 			<button type="submit" > Nueva Marca </button> -->
<!-- 			</form> -->
<!-- 		</div> -->
		
<!-- 		<h1> CATEGORIAS </h1> -->
		
<!-- 		<div class="form-container"> -->
<!-- 			<form action="BuscarCategorias" method="GET"> -->
<!-- 			<button type="submit" > Mostrar Categorias </button> -->
<!-- 			</form> -->
<!-- 			<form action="FormularioAltaCategoria" method="POST"> -->
<!-- 			<button type="submit" > Nueva Categoria </button> -->
<!-- 			</form> -->
<!-- 		</div> -->
		
<%-- 		<% } %> --%>
				
<!-- 		<h1> CARRITO </h1> -->
<!-- 		<form action="MostrarCarrito" method="POST"> -->
<!-- 		<button type="submit" > CARRITO </button> -->
<!-- 		</form> -->
<%-- 		<% }%> --%>
		
<!-- 	</body> -->
<!-- </html> -->

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
    <meta charset="UTF-8">
    <title> E-shop </title>
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
        
        /* Mantener estilos originales */
        .form-container {
            display: inline-block;
        }
        
        form {
            display: inline-block;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <div class="navbar">
        <div class="nav-links">
            <a href="index.jsp">Inicio</a>
			<a href="${pageContext.request.contextPath}/BuscarTodosProducto">Productos</a>
			<a href="#">Ofertas</a>
            <a href="#">Contacto</a>
        </div>
        
        <div class="nav-buttons">
            <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/FormularioInicioSesion.jsp'">Iniciar Sesión</button>
            <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/NuevaCuenta'">Registrarse</button>
            <button class="btn" style="background-color: #28a745;" onclick="location.href='MostrarCarrito'">🛒 Carrito</button>
        </div>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <div style="padding: 0 2rem;">
        <h1> Bienvenidos a NarguEZ </h1>
        
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
            <button class="btn btn-outline">Memorias</button>
            <button class="btn btn-outline">Almacenamiento</button>
            <button class="btn btn-outline">Tarjetas graficas</button>
            <button class="btn btn-outline">Fuentes</button>
        </div>
    </div>
</body>
</html>