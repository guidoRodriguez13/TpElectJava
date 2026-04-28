<%@page import="entidades.Persona" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta charset="UTF-8">
    <title>Iniciar Sesión - E-shop</title>
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
                <button class="btn" style="background-color: #28a745;" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
            </div>
        </div>
        
        <!-- CONTENIDO PRINCIPAL - FORMULARIO CENTRADO -->
        <div style="display: flex; justify-content: center; align-items: center; min-height: 70vh;">
            <div class="form-container" style="width: 100%; max-width: 450px;">
                <h1 style="text-align: center;">Iniciar Sesión</h1>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="error-message" style="text-align: center;">
                        Email o contraseña incorrectos
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/InicioSesionServlet" method="post">
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required autofocus>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Contraseña:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Ingresar</button>
                </form>
                
                <div style="text-align: center; margin-top: 15px;">
                    <a href="index.jsp">← Volver al inicio</a>
                </div>
                
                <div style="text-align: center; margin-top: 10px;">
                    ¿No tenés cuenta? <a href="${pageContext.request.contextPath}/NuevaCuenta">Registrate acá</a>
                </div>
            </div>
        </div>
        
        <!-- FOOTER -->
        <footer>
            <p>© 2024 E-shop - Todos los derechos reservados</p>
        </footer>
    </div>
</body>
</html>