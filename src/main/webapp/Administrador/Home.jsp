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
        <link rel="stylesheet" href="../css/general.css">
        <link rel="stylesheet" href="../css/sidebar.css">
        <link rel="stylesheet" href="../css/table.css">
        <link rel="stylesheet" href="../css/search-bar.css">
        <link rel="stylesheet" href="../css/form.css">
        <title>Admin Home</title>
        <%
            if (!"administradores".equals(session.getAttribute("tipoUsuario"))) {
                response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
            }
        %>
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
        <!-- Menú lateral -->
        <navbar class="sidebar">
            <h2><a href="../index.jsp">Salud Dental</a></h2>
            <nav>
                <ul>
                    <li><a href="Home.jsp" class="menu-item">&#127968; Home</a></li>
                    <li><a href="Pacientes.jsp" class="menu-item">&#128100; Pacientes</a></li>
                    <li><a href="Medicos.jsp" class="menu-item">&#128104;&#8205;&#9877;&#65039; Medicos</a></li>
                    <li><a href="Citas.jsp" class="menu-item">&#128197; Citas</a></li>
                    <li><a href="Consultas.jsp" class="menu-item">&#128196; Consultas</a></li>
                </ul>
            </nav>
        </navbar>

        <!-- Contenedor principal -->
        <div class="main-content">
            <!-- Barra de navegación superior -->
            <header class="navbar">
                <div class="user-info">
                    <p>Bienvenido, <span id="username"><%= usuarioSesion%></span></p>
                    <form action="" method="post">
                        <input type="hidden" name="action" value="logout">
                        <button class="button-red" type="submit">Cerrar Sesión</button>
                    </form>
                </div>
            </header>
                    <section class="dashboard">
                        <div class="banner">
                            <div class="banner-header">
                                <h1>Panel Administrador</h1>
                            </div>
                            <div class="banner-line"></div>
                        </div>
                        <p>Este es tu panel de control donde puedes gestionar el Sistema.</p>
                    </section>
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