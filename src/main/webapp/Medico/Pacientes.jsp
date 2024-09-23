<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.util.CerrarSesion" %><%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 13/09/2024
  Time: 12:11 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="../css/general.css">
        <link rel="stylesheet" href="../css/sidebar.css">
        <link rel="stylesheet" href="../css/table.css">
        <link rel="stylesheet" href="../css/search-bar.css">
        <link rel="stylesheet" href="../css/form.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%
    if (!"medicos".equals(session.getAttribute("tipoUsuario"))) {
        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
    }
    %>
    <title>Tabla de Pacientes</title>
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
                <li><a href="Agenda.jsp" class="menu-item">&#128197; Agenda</a></li>
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

        <!-- Contenido del dashboard -->
        <div class="dashboard">
            <!-- banner -->
            <div class="banner">
                <div class="banner-header">
                    <h1>Tabla de Pacientes</h1>
                </div>
                <div class="banner-line"></div>
            </div>

            <!-- Formulario de búsqueda -->
            <form action="Pacientes.jsp" method="get" class="search-form">
                <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
                <button class="button-black" type="submit">Buscar</button>
            </form>

                <!-- Tabla de pacientes -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Telefono</th>
                            <th>Direccion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String busqueda = request.getParameter("busqueda");
                        List<Paciente> pacientes = null;
                        List<Paciente> pacientesFiltrados = new ArrayList<>();
                        PacienteDAO pacienteDAO = new PacienteDAO();

                        try {
                            pacientes = pacienteDAO.obtenerPacientes();
                            if (busqueda != null && !busqueda.isEmpty()) {
                                for (Paciente paciente : pacientes) {
                                    if (paciente.getNombre().toLowerCase().contains(busqueda.toLowerCase())) {
                                        pacientesFiltrados.add(paciente);
                                    }
                                }
                            } else {
                                pacientesFiltrados = pacientes;
                            }
                        } catch (SQLException ex) {
                            throw new RuntimeException(ex);
                        }

    if (pacientesFiltrados != null && !pacientesFiltrados.isEmpty()) {
        for (Paciente paciente : pacientesFiltrados) {
                    %>
                    <tr>
                        <td><%= paciente.getIdPaciente() %></td>
                        <td><%= paciente.getNombre() %></td>
                        <td><%= paciente.getApellidos() %></td>
                        <td><%= paciente.getTelefono()%></td>
                        <td><%= paciente.getDireccion()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
            </div>
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
</html>