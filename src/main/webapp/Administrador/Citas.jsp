<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="com.sgcd.dao.SucursalDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.model.Cita" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
<%--
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
        <%
        if (!"administradores".equals(session.getAttribute("tipoUsuario"))) {
            response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
        }
        %>
        <title>Gestion de Consultas</title>
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

    SucursalDao sucursalDAO = new SucursalDao();
%>
<div class="container">
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

    <main class="main-content">
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
        <section class="dashboard">
            <div class="banner">
                <div class="banner-header">
                    <h1>Lista de Citas</h1>
                </div>
                <div class="banner-line"></div>
            </div>
            <!-- Tabla de registros -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Descripcion</th>
                            <th>Sucursal</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Cita> citas = null;
                        CitaDAO citaDAO = new CitaDAO();

                        try {
                            citas = citaDAO.findAllCitas();
                        } catch (SQLException ex) {
                            throw new RuntimeException(ex);
                        }

                        if (citas != null && !citas.isEmpty()) {
                            for (Cita cita : citas) {
                    %>
                    <tr>
                        <td><%= cita.getId() %></td>
                        <td><%= cita.getFecha()%></td>
                        <td><%= cita.getHora()%></td>
                        <td><%= cita.getDescripcion()%></td>
                        <td><%= sucursalDAO.obtenerSucursalPorId(cita.getIdsucursal()).getNombre() %></td>
                        <td>
                            <form action="Citas.jsp" method="post" style="display: inline">
                                <input type="hidden" name="id" value="<%= cita.getId() %>">
                                <button type="submit" class="button-red" onclick="return confirm('¿Estás seguro de que quieres eliminar a esta cita?');">
                                    Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5">No se encontraron citas.</td>
                    </tr>
                    <%
                        }
                    %>
                    <!-- Logico de eliminacion -->
                    <%
                        // Manejo de la eliminación de una cita
                        String idParam = request.getParameter("id");
                        if (idParam != null && !idParam.isEmpty()) {
                            int id = Integer.parseInt(idParam);
                            try {
                                int registrosEliminados = citaDAO.delete(id);
                                response.sendRedirect("Citas.jsp");
                            } catch (SQLException ex) {
                                throw new RuntimeException(ex);
                            }
                        }
                    %>
                    </tbody>
                </table>
        </section>
    </main>
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