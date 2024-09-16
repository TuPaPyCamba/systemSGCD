<%@ page import="com.sgcd.dao.CitaDAO" %>
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
        <%
            if (!"administradores".equals(session.getAttribute("tipoUsuario"))) {
                response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
            }
        %>
        <title>Gestion de Consultas</title>
        <link rel="stylesheet" href="../css/modulos.css">
        <link rel="stylesheet" href="../css/Dashboards.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>Admin Home Page</title>
    </head>
    <body>
        <%
            String idSesionString = String.valueOf(session.getAttribute("usuarioId"));
            String usuarioSesion = (String) session.getAttribute("usuario");
            Integer idSesion = Integer.parseInt(idSesionString);
        %>
        <div class="dashboard">

        <!-- Menú lateral -->
        <div class="sidebar">
            <h2><a href="../index.jsp">Salud Dental</a></h2>
            <a href="Home.jsp" class="menu-item">
                <i class="fas fa-home"></i><span>Home</span>
            </a>
            <a href="GestionPacientes.jsp" class="menu-item">
                <i class="fas fa-user-injured"></i><span>Pacientes</span>
            </a>
            <a href="GestionMedicos.jsp" class="menu-item">
                <i class="fas fa-user-md"></i><span>Medicos</span>
            </a>
            <a href="GestionCitas.jsp" class="menu-item">
                <i class="fas fa-calendar-check"></i><span>Citas</span>
            </a>
            <a href="Consultas.jsp" class="menu-item">
                <i class="fas fa-file-alt"></i><span>Consultas</span>
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
                    <p>Bienvenido, <%= usuarioSesion%></p>
                    <form action="" method="post">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit">Cerrar Sesion</button>
                    </form>
                </div>
            </div>

            <!-- Contenido del dashboard -->
            <div class="container">
                <div class="g-container">
                    <!-- banner de Citas -->
                    <div class="g-banner-container">
                        <div class="g-banner-labelbutton-container">
                            <h2 class="label-banner">Lista de Citas</h2>
                        </div>
                        <div class="blue-line"></div>
                    </div>
                    <!-- Tabla de registros -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Descripcion</th>
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
                                        for(Cita cita : citas) {
                            %>
                            <tr>
                                <td><%= cita.getId() %></td>
                                <td><%= cita.getFecha()%></td>
                                <td><%= cita.getHora()%></td>
                                <td><%= cita.getDescripcion()%></td>
                                <td>
                                    <form action="GestionCitas.jsp" method="post" style="display: inline">
                                        <input type="hidden" name="id" value="<%= cita.getId() %>">
                                        <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">Eliminar</button>
                                    </form>
                                    <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
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
                                if (idParam != null && !idParam.isEmpty()){
                                    int id = Integer.parseInt(idParam);
                                    try {
                                        int registrosEliminados = citaDAO.delete(id);
                                        response.sendRedirect("GestionCitas.jsp");
                                    } catch (SQLException ex) {
                                        throw new RuntimeException(ex);
                                    }
                                }
                            %>
                            </tbody>
                        </table>
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