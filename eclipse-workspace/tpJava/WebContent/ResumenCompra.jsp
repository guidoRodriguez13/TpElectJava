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
    <title>Resumen de Compra - E-shop</title>
    <style>
        .container-form {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .productos-table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        .productos-table th, .productos-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .total {
            font-size: 1.2rem;
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div style="padding: 0 2rem;">
        <h1>Resumen de Compra</h1>
        
        <%
            Venta venta = (Venta) session.getAttribute("venta");
            if (venta != null && venta.getLineas() != null && !venta.getLineas().isEmpty()) {
                List<LineaVenta> lineas = venta.getLineas();
                double subtotal = 0;
                for (LineaVenta lv : lineas) {
                    subtotal += lv.getPrecioUnit() * lv.getCant();
                }
        %>
        
        <div class="container-form">
            <h2>Productos</h2>
            <table class="productos-table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio Unit.</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (LineaVenta lv : lineas) { %>
                    <tr>
                        <td><%= lv.getProd().getNombre() %></td>
                        <td><%= lv.getCant() %></td>
                        <td>$<%= lv.getPrecioUnit() %></td>
                        <td>$<%= lv.getPrecioUnit() * lv.getCant() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
            <div class="total">
                <p>Subtotal: $<%= subtotal %></p>
            </div>
            
            <form action="FinalizarCompra" method="POST">
                <h2>Forma de Envío</h2>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaEnvio" value="retiro" required>
                        Retiro en local (Gratis)
                    </label>
                </div>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaEnvio" value="domicilio">
                        Envío a domicilio ($1500)
                    </label>
                </div>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaEnvio" value="express">
                        Envío express ($3000)
                    </label>
                </div>
                
                <h2>Forma de Pago</h2>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaPago" value="efectivo" required>
                        Efectivo
                    </label>
                </div>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaPago" value="tarjeta">
                        Tarjeta de crédito/débito
                    </label>
                </div>
                <div class="form-group">
                    <label>
                        <input type="radio" name="formaPago" value="transferencia">
                        Transferencia bancaria
                    </label>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">Confirmar Compra</button>
                    <button type="button" class="btn btn-outline" onclick="location.href='Carrito.jsp'">Volver al carrito</button>
                </div>
            </form>
        </div>
        
        <%
            } else {
        %>
            <div style="text-align: center; padding: 50px;">
                <h2>No hay productos en el carrito</h2>
                <button class="btn btn-primary" onclick="location.href='index.jsp'">Ir a comprar</button>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>