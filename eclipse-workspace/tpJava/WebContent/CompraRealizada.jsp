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
    <title>Compra Realizada - E-shop</title>
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
        
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
        }
        
        .success {
            color: #28a745;
            font-size: 3rem;
        }
        
        .details {
            text-align: left;
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
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
        <div class="container">
            <div class="success">✅</div>
            <h1>¡Compra Realizada con Éxito!</h1>
            
            <%
                Venta venta = (Venta) session.getAttribute("venta");
                if (venta != null) {
                    double subtotal = 0;
                    for (LineaVenta lv : venta.getLineas()) {
                        subtotal += lv.getPrecioUnit() * lv.getCant();
                    }
                    double totalFinal = subtotal + venta.getCostoEnvio();
            %>
            
            <div class="details">
                <h3>Detalle de la compra</h3>
                <p><strong>Número de venta:</strong> <%= venta.getIdVenta() %></p>
                <p><strong>Fecha:</strong> <%= venta.getFechaVenta() %></p>
                <hr>
                <p><strong>Subtotal:</strong> $<%= subtotal %></p>
                <p><strong>Forma de envío:</strong> 
                    <% if ("retiro".equals(venta.getFormaEnvio())) { %>
                        Retiro en local
                    <% } else if ("domicilio".equals(venta.getFormaEnvio())) { %>
                        Envío a domicilio
                    <% } else if ("express".equals(venta.getFormaEnvio())) { %>
                        Envío express
                    <% } %>
                </p>
                <p><strong>Costo de envío:</strong> $<%= venta.getCostoEnvio() %></p>
                <p><strong>Forma de pago:</strong> 
                    <% if ("efectivo".equals(venta.getFormaPago())) { %>
                        Efectivo
                    <% } else if ("tarjeta".equals(venta.getFormaPago())) { %>
                        Tarjeta de crédito/débito
                    <% } else if ("transferencia".equals(venta.getFormaPago())) { %>
                        Transferencia bancaria
                    <% } %>
                </p>
                <hr>
                <h3>Total final: $<%= totalFinal %></h3>
            </div>
            
            <%
                } else {
            %>
                <p>No se encontró información de la compra.</p>
            <%
                }
                // Limpiar el carrito de la sesión
                session.removeAttribute("venta");
            %>
            
            <div>
                <button class="btn btn-primary" onclick="location.href='index.jsp'">Volver al inicio</button>
                <button class="btn btn-outline" onclick="location.href='BuscarTodosProducto'">Seguir comprando</button>
            </div>
        </div>
    </div>
</body>
</html>