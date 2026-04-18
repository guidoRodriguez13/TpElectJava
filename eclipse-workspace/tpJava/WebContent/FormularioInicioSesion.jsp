<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">
    <meta charset="UTF-8">
    <title>Iniciar Sesión - E-shop</title>
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
        
        /* Login container */
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        
        .login-container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            text-align: center;
        }
        
        .back-link {
            text-align: center;
            margin-top: 15px;
        }
        
        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        
        .back-link a:hover {
            text-decoration: underline;
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
                <button class="btn" style="background-color: #28a745;" onclick="location.href='${pageContext.request.contextPath}/MostrarCarrito'">🛒 Carrito</button>
            </div>
        </div>
        
        <!-- LOGIN FORM -->
        <div class="login-container">
            <h1>Iniciar Sesión</h1>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    Email o contraseña incorrectos
                </div>
            <% } %>
            
            <% if (request.getParameter("vacio") != null) { %>
                <div class="error-message">
                    Complete todos los campos
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
            
            <div class="back-link">
                <a href="index.jsp">← Volver al inicio</a>
            </div>
            
            <div class="back-link">
                ¿No tenés cuenta? <a href="${pageContext.request.contextPath}/NuevaCuenta">Registrate acá</a>
            </div>
        </div>
    </div>
</body>
</html>