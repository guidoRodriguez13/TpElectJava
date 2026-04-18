<%@page import="entidades.Persona"%>
<%@page import="entidades.Venta"%>
<%@page import="entidades.LineaVenta"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <meta charset="UTF-8">
    <title>Mi Carrito - E-shop</title>
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
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        /* Tabla del carrito */
        .carrito-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        
        .carrito-table th, .carrito-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        
        .carrito-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        
        .total-container {
            text-align: right;
            margin: 20px 0;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        
        .total {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
        }
        
        .acciones {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
        }
        
        .vacio {
            text-align: center;
            padding: 50px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        
        .cantidad-input {
            width: 60px;
            padding: 5px;
            text-align: center;
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
                    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/FormularioInicioSesion.jsp'">Iniciar Sesión</button>
                    <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/NuevaCuenta'">Registrarse</button>
                <% } else { %>
                    <span>Bienvenido, ${usuario.nombre}</span>
                    <button class="btn btn-outline" onclick="location.href='${pageContext.request.contextPath}/CerrarSesion'">Cerrar Sesión</button>
                <% } %>
                <button class="btn" style="background-color: #28a745;" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
            </div>
        </div>
        
        <h1>🛒 Mi Carrito</h1>
        
        <%
            Venta v = (Venta) session.getAttribute("venta");
            if (v != null && v.getLineas() != null && !v.getLineas().isEmpty()) {
                List<LineaVenta> lineaVenta = v.getLineas();
                int subtotal = 0;
        %>
            <table class="carrito-table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Descripción</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                        <th>Subtotal</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (LineaVenta lv : lineaVenta) {
                        subtotal += (lv.getPrecioUnit() * lv.getCant());
                %>
                    <tr>
                        <td><strong><%= lv.getProd().getNombre() %></strong></td>
                        <td><%= lv.getProd().getDescripcion() %></td>
                        <td>
                            <form action="ActualizarCantidad" method="GET" style="display: flex; gap: 5px; margin: 0;">
                                <input type="hidden" name="idProducto" value="<%= lv.getProd().getIdProducto() %>">
                                <input type="number" name="cantidad" value="<%= lv.getCant() %>" min="1" class="cantidad-input">
                                <button type="submit" class="btn btn-outline" style="padding: 5px 10px;">Actualizar</button>
                            </form>
                        </td>
                        <td>$<%= lv.getPrecioUnit() %></td>
                        <td>$<%= lv.getPrecioUnit() * lv.getCant() %></td>
                        <td>
                            <form action="EliminarLineaVenta" method="GET" style="margin: 0;">
                                <input type="hidden" name="idProducto" value="<%= lv.getProd().getIdProducto() %>">
                                <button type="submit" class="btn btn-danger">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
            
            <div class="total-container">
                <h3>Resumen de compra</h3>
                <p>Subtotal: $<%= subtotal %></p>
                <p>Envío: $0</p>
                <p class="total">Total: $<%= subtotal %></p>
            </div>
            
            <div class="acciones">
                <form action="BuscarTodosProducto" method="GET">
                    <button type="submit" class="btn btn-outline">🛍️ Seguir Comprando</button>
                </form>
                <form action="FinalizarCompra" method="POST">
                    <button type="submit" class="btn btn-success">✅ Confirmar Compra</button>
                </form>
            </div>
            
        <%
            } else {
        %>
            <div class="vacio">
                <h2>🛒 Tu carrito está vacío</h2>
                <p>¡Explora nuestros productos y agregá tus favoritos!</p>
                <form action="BuscarTodosProducto" method="GET">
                    <button type="submit" class="btn btn-primary">Ver Productos</button>
                </form>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>

<%-- <%@page import="entidades.Venta"%> --%>
<%-- <%@page import="entidades.LineaVenta"%> --%>
<%-- <%@page import="java.util.List"%> --%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%--     pageEncoding="UTF-8"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- 	<head> -->
<!-- 		<meta charset="UTF-8"> -->
<!-- 		<title>Mi Carrito</title> -->
<!-- 	</head> -->
<!-- 	<body> -->
<!-- 		<h1>Productos en el carrito: </h1> -->
<%-- 		<% Venta v = (Venta) request.getSession().getAttribute("venta"); %> --%>
<%-- 		<% if (v != null){ %> --%>
<%-- 		<% List<LineaVenta> lineaVenta = v.getLineas(); --%>
<!-- // 		   	int subtotal = 0; -->
<!-- // 			for(LineaVenta lv : lineaVenta){ -->
<!-- // 				subtotal += (lv.getPrecioUnit()*lv.getCant()); -->
<%-- 		%> --%>
<!-- 			<p> -->
<%-- 			<strong>Nombre:</strong> <%=lv.getProd().getNombre() %> | --%>
<%-- 			<strong>Descripcion:</strong> <%=lv.getProd().getDescripcion() %> | --%>
<%-- 			<strong>Cantidad:</strong> <%=lv.getCant() %> --%>
<%-- 			<strong>Precio:</strong> <%=lv.getPrecioUnit() %> | --%>
<%-- 			<strong>SubTotal:</strong> <%=(lv.getPrecioUnit()*lv.getCant())  %> --%>
			
<!-- 			<form action="EliminarLineaVenta" method="GET"> -->
<%-- 				<input type="hidden" name="idProducto" value="<%= lv.getProd().getIdProducto() %>">	 --%>
<!--             	<button type="submit" > Eliminar </button> -->
<!--             </form> -->
<!-- 			</p> -->

<%--          <% } %> --%>
<%-- 			<% if (subtotal != 0) { %> --%>
<!-- 			<form> -->
<%--          	<p><strong>Total de carrito: </strong></p><%=subtotal %> --%>
<!--          	</form> -->
<!--         		<form action="NuevaCompra" method="GET">  -->
<!--             		<button type="submit" > Seguir Comprando </button> -->
<!--             	</form> -->

<!--         		<form action="FinalizarCompra" method="POST">  -->
<!--             		<button type="submit" > Confirmar </button> -->
<!--             	</form> -->
<%--             <% } else { %> --%>
<!--             <p> CARRITO VACIO </p> -->
<%--             <% } %> --%>
<%--             <% } else { %> --%>
<!--             	<p> CARRITO VACIO </p> -->
<%--             <% } %> --%>
            
<!--             <a href="index.jsp">Volver a Inicio</a> -->
<!-- 	</body> -->
<!-- </html> -->