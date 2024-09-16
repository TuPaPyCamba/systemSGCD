Created by IntelliJ IDEA.
User: maxim
Date: 13/09/2024
Time: 12:11 p. m.
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Gestion de Medico</title>
    <%
        if (!"pacientes".equals(session.getAttribute("tipoUsuario"))) {
            response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
        }
    %>
    <link rel="stylesheet" href="../css/modulos.css">
    <link rel="stylesheet" href="../css/Dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Admin Home Page</title>
</head>
<body>
    <%
    String idSesionString = null;
    String usuarioSesion = null;
    Object tipoUsuario = session.getAttribute("tipoUsuario");

    if(tipoUsuario != null){
        idSesionString = String.valueOf(session.getAttribute("usuarioId"));
        usuarioSesion = (String) session.getAttribute("usuario");
        Integer idSesion = Integer.parseInt(idSesionString);
    }
    %>
    <div class="dashboard">

    <!-- Menú lateral -->
    <div class="sidebar">
        <h2><a href="../index.jsp">Salud Dental</a></h2>
        <a href="Home.jsp" class="menu-item">
            <i class="fas fa-home"></i><span>Home</span>
        </a>
        <a href="Agenda.jsp" class="menu-item">
            <i class="fas fa-calendar-alt"></i><span>Agenda</span>
        </a>
        <a href="GestionMedicos.jsp" class="menu-item">
            <i class="fas fa-user-md"></i><span>Medicos</span>
        </a>
        <a href="Citas.jsp" class="menu-item">
            <i class="fas fa-calendar-check"></i><span>Citas</span>
        </a>
        <a href="Settings.jsp" class="menu-item">
            <i class="fas fa-cogs"></i><span>Ajustes</span>
        </a>
    </div>

    <!-- Contenedor principal -->
    <div class="main-content">
        <!-- Barra de navegación superior -->
        <div class="navbar">
            <div class="" style="display: hidden;"></div>
            <div class="user-info">
                <p>Bienvenido, Usuario</p>
                <button>Logout</button>
            </div>
        </div>

        <!-- Contenido del dashboard -->
        <div class="content">
            <div class="container">

            </div>
        </div>
    </div>
</body>
</html>