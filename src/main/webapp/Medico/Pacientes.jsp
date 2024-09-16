<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
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
    <link rel="stylesheet" href="../css/modulos.css">
    <link rel="stylesheet" href="../css/Dashboards.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Pacientes</title>
    <script>
        function confirmarRegistro() {
            return confirm("¿Estás seguro de que quieres registrar este Paciente?");
        }

        function confirmarEliminacion() {
            return confirm("¿Estás seguro de que quieres eliminar este Paciente?");
        }
    </script>
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
        <a href="Pacientes.jsp" class="menu-item">
            <i class="fas fa-user-injured"></i><span>Pacientes</span>
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
                <p>Bienvenido, Usuario</p>
                <button>Logout</button>
            </div>
        </div>

        <!-- Contenido del dashboard -->
        <div class="content">
            <div class="container">
                <div class="g-container">
                    <h2>Gestión de Pacientes</h2>

                    <!-- Formulario de búsqueda -->
                    <form action="GestionPacientes.jsp" method="get" class="search-form">
                        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar por nombre..." value="<%= request.getParameter("busqueda") %>">
                        <button type="submit">Buscar</button>
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
        </div>
    </div>
</body>
</html>