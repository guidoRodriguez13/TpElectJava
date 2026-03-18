<%@page import="entidades.Persona" %>
<%@page import="entidades.Cliente" %>
<%@page import="entidades.Administrador" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
		<meta charset="UTF-8">
		<title> E-shop </title>
	<style>
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
		<h1> Bienvenidos E-Shop </h1>
		<%	if (request.getSession().getAttribute("usuario") == null){ %>
		
		<h1> Log In </h1>
		<form action="${pageContext.request.contextPath}/InicioSesionServlet" method="post">
<!-- 		 <form action="InicioSesionServlet" method="get"> CODIGO ANTERIOR -->
		<button type="submit" > Ingresar </button>
		</form>
		
		<form action="NuevaCuenta" method="get">
		<button type="submit" > Registrar </button>
		</form>
		<% } else { Cliente cli = new Cliente();
					if (request.getSession().getAttribute("usuario").getClass() == cli.getClass()){
					Cliente user = (Cliente) request.getSession().getAttribute("usuario");
					%>
					<h1>Bienvenido <%=user.getNombre() + " " %><%=user.getApellido()%></h1>
					
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
					
					<h1> COMPRA </h1>
					<form action="NuevaCompra" method="GET">
					<button type="submit" > Comprar productos</button>
					</form>
		
					<h1> PRODUCTOS </h1>
					<h1> </h1>
					<form action="BuscarTodosProducto" method="GET">
					<button type="submit" > Mostrar productos</button>
					</form>
				<% } else{
					Administrador user = (Administrador) request.getSession().getAttribute("usuario");
					%>
					<h1>Bienvenido Admin <%=user.getNombre() + " " %><%=user.getApellido()%></h1>
					
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
					
					<h1> COMPRA </h1>
		<form action="NuevaCompra" method="GET">
		<button type="submit" > Comprar productos</button>
		</form>
		
		<h1> PRODUCTOS </h1>
		<h1> </h1>
		<form action="BuscarTodosProducto" method="GET">
		<button type="submit" > Mostrar productos</button>
		</form>

		<form action="FormularioBusquedaPorIdServlet" method="POST">
		<button type="submit" > Buscar producto por ID</button>
		</form>
		
		<form action="FormularioAltaProductoServlet" method="POST">
		<button type="submit" > Alta producto</button>
		</form>
		
		<h1> USUARIOS </h1>
		<h1> </h1>
		
		<form action="BuscarTodosUsuarios" method="POST">
		<button type="submit" >Listar usuarios</button>
		</form>
		
		<form action="FormularioBusquedaUserPorIdServlet" method="POST">
		<button type="submit" > Buscar Usuario por ID</button>
		</form>

		<form action="FormularioBusquedaPorDniServlet" method="POST">
		<button type="submit" > Buscar usuario por DNI</button>
		</form>
		
		<h1> MARCAS </h1>
		
		<div class="form-container">
			<form action="BuscarMarcas" method="GET">
			<button type="submit" > Mostrar Marcas </button>
			</form>
			<form action="FormularioAltaMarca" method="POST">
			<button type="submit" > Nueva Marca </button>
			</form>
		</div>
		
		<h1> CATEGORIAS </h1>
		
		<div class="form-container">
			<form action="BuscarCategorias" method="GET">
			<button type="submit" > Mostrar Categorias </button>
			</form>
			<form action="FormularioAltaCategoria" method="POST">
			<button type="submit" > Nueva Categoria </button>
			</form>
		</div>
		
		<% } %>
				
		<h1> CARRITO </h1>
		<form action="MostrarCarrito" method="POST">
		<button type="submit" > CARRITO </button>
		</form>
		<% }%>
		
	</body>
</html>