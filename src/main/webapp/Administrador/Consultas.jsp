<%@ page import="com.sgcd.model.Consulta" %>
<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
<%@ page import="com.sgcd.dao.SucursalDao" %>
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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <main class="main-content">
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
        <section class="dashboard">
            <!-- banner -->
            <div class="banner">
                <div class="banner-header">
                    <h1>Lista de Consultas</h1>
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
                        List<Consulta> consultas = null;
                        ConsultaDAO consultaDAO = new ConsultaDAO();

                        try {
                            consultas = consultaDAO.findAllConsultas();
                        } catch (SQLException ex) {
                            throw new RuntimeException(ex);
                        }

                        if (consultas != null && !consultas.isEmpty()) {
                            for (Consulta consulta : consultas) {
                    %>
                    <tr>
                        <td><%= consulta.getId() %></td>
                        <td><%= consulta.getFecha()%></td>
                        <td><%= consulta.getHora()%></td>
                        <td><%= consulta.getDescripcion()%></td>
                        <td><%= sucursalDAO.obtenerSucursalPorId(consulta.getIdsucursal()).getNombre() %></td>
                        <td>
                            <form action="Consultas.jsp" method="post" style="display: inline">
                                <input type="hidden" name="id" value="<%= consulta.getId() %>">
                                <button type="submit" class="button-red" onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">
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
                        <td colspan="5">No se encontraron consultas.</td>
                    </tr>
                    <%
                        }
                    %>
                    <!-- Logico de eliminacion -->
                    <%
                        // Manejo de la eliminación de una consulta
                        String idParam = request.getParameter("id");
                        if (idParam != null && !idParam.isEmpty()) {
                            int id = Integer.parseInt(idParam);
                            try {
                                int registrosEliminados = consultaDAO.delete(id);
                                response.sendRedirect("Consultas.jsp");
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