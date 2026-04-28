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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Mi Carrito - E-shop</title>
</head>
<body>
    <div class="main-container">
        <!-- NAVBAR -->
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
                <button class="btn btn-carrito" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">Carrito</button>
            </div>
        </div>
        
        <!-- CONTENIDO PRINCIPAL -->
        <div class="content-wrapper">
            <h1>🛒 Mi Carrito</h1>
            
            <%
                Venta v = (Venta) session.getAttribute("venta");
                if (v != null && v.getLineas() != null && !v.getLineas().isEmpty()) {
                    List<LineaVenta> lineaVenta = v.getLineas();
                    int subtotal = 0;
            %>
                <table class="data-table">
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
                    <form action="ResumenCompra.jsp" method="GET">
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
        
        <!-- FOOTER -->
        <footer>
            <p>© 2024 E-shop - Todos los derechos reservados</p>
        </footer>
    </div>
</body>
</html>