<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 13/09/2024
  Time: 12:11 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
<html lang="en">
<head>
    <title>Admin Home</title>
    <%
        if (!"administradores".equals(session.getAttribute("tipoUsuario"))) {
            response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
        }
    %>
    <link rel="stylesheet" href="../css/general.css">
</head>
<body>
<%
    String idSesionString = null;
    String usuarioSesion = null;
    Object tipoUsuario = session.getAttribute("tipoUsuario");
    Integer idSesion = null;

    if(tipoUsuario != null){
        idSesionString = String.valueOf(session.getAttribute("usuarioId"));
        usuarioSesion = (String) session.getAttribute("usuario");
        idSesion = Integer.parseInt(idSesionString);
    }
%>
<div class="container">
    <div class="sidebar">
        <h2><a href="./index.jsp">Salud Dental</a></h2>
        <ul class="nav-links">
            <li><a href="Pacientes.jsp">Inicio</a></li>
            <li><a href="Pacientes.jsp">Pacientes</a></li>
            <li><a href="Medicos.jsp">Medicos</a></li>
            <li><a href="Citas.jsp">Citas</a></li>
            <li><a href="Consultas.jsp">Consultas</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <p class="welcome-message">Bienvenido, <%= usuarioSesion%></p>
            <form action="" method="post" class="logout-form">
                <input type="hidden" name="action" value="logout">
                <button type="submit">Cerrar Sesion</button>
            </form>
        </div>
        <div class="welcome-container">
            <h2>¡Bienvenido Administrador <%= usuarioSesion%>!</h2>
            <p>Este es tu panel de control donde puedes gestionar el Sistema.</p>
        </div>
    </div>
</div>
<%
    if ("POST".equalsIgnoreCase(request.getMethod()) && "logout".equals(request.getParameter("action"))) {
        CerrarSesion cerrarSesion = new CerrarSesion();
        cerrarSesion.invalidarSesion(session);
        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
        return;
    }
%>
</body>