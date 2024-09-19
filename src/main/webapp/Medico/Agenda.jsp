<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.model.Cita" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="com.sgcd.model.Consulta" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <%
            if (!"medicos".equals(session.getAttribute("tipoUsuario"))) {
                response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
            }
        %>
        <meta charset="UTF-8">
    <title>Agenda de Citas y Consultas</title>
    <link rel="stylesheet" href="../css/modulos.css">
    <link rel="stylesheet" href="../css/Dashboards.css">
    <link rel="stylesheet" href="../css/Agenda.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                <p>Bienvenido, <%= usuarioSesion%>
                </p>
                <form action="" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit">Cerrar Sesion</button>
                </form>
            </div>
        </div>

        <!-- Contenido del dashboard -->
        <div class="container">
            <div class="g-container">
                <div class="g-banner-container">
                    <div class="g-banner-labelbutton-container">
                        <h2 class="label-banner">Buscar Citas del Médico</h2>
                    </div>
                </div>
                <!-- Formulario para seleccionar la fecha -->

                <form action="Agenda.jsp" method="get" class="search-form">
                    <div class="buscarCita">
                        <label for="fecha">Fecha:</label>
                        <input type="date" id="fecha" name="fecha" required>
                    </div>
                    <button type="submit">Buscar</button>
                </form>

                <%
                    // Obtener parámetros de la solicitud
                    String fechaParam = request.getParameter("fecha");

                    if (fechaParam != null) {
                        LocalDate fecha = LocalDate.parse(fechaParam);
                        // Crear instancia de CitaDAO
                        CitaDAO citaDAO = new CitaDAO();
                        List<Cita> citas = citaDAO.obtenerTodasCitas(idSesion, fecha);

                        if (citas != null && !citas.isEmpty()) {
                %>
                <table class="table">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2 border-b">ID</th>
                        <th class="px-4 py-2 border-b">Medico ID</th>
                        <th class="px-4 py-2 border-b">Paciente ID</th>
                        <th class="px-4 py-2 border-b">Fecha</th>
                        <th class="px-4 py-2 border-b">Hora</th>
                        <th class="px-4 py-2 border-b">Descripción</th>
                        <th class="px-4 py-2 border-b">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Cita cita : citas) { %>
                    <tr>
                        <td class="px-4 py-2 border-b"><%= cita.getId() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= cita.getIdMedico() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= cita.getIdPaciente() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= cita.getFecha() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= cita.getHora() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= cita.getDescripcion() %>
                        </td>
                        <td class="px-4 py-2 border-b">
                            <form action="Agenda.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="idcitadelete" value="<%= cita.getId() %>">
                                <button
                                        type="submit"
                                        class="btn-delete"
                                        onclick="return confirm('¿Estás seguro de que quieres eliminar a esta cita?');">
                                    Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="mt-4 text-red-500">No se encontraron citas para el médico y la fecha seleccionados.</p>
                <% } %>
                <% } else { %>
                <p class="mt-4 text-red-500">Por favor, seleccione un médico y una fecha para buscar.</p>
                <% } %>

                <%
                    // Lógica para eliminar cita
                    String idParam = request.getParameter("idcitadelete");

                    if (idParam != null) {
                        int id = Integer.parseInt(idParam);

                        try {
                            CitaDAO citaDAO = new CitaDAO();
                            int registros = citaDAO.delete(id);

                            if (registros > 0) { %>
                <p class='mt-4 text-green-500'>Cita eliminada con éxito.</p>
                <%} else { %>
                <p class='mt-4 text-red-500'>Error al eliminar la cita.</p>
                <%
                    }
                } catch (SQLException e) {
                %>
                <p class='mt-4 text-red-500'>Error en la base de datos</p>
                <%
                        }
                    }
                %>
                <div class="g-banner-container">
                    <div class="g-banner-labelbutton-container">
                        <h2 class="label-banner">Buscar Consultas del Médico</h2>
                    </div>
                </div>
                <!-- Formulario para seleccionar la fecha -->

                <form action="Agenda.jsp" method="get" class="search-form">
                    <div class="buscarCita">
                        <label for="fecha">Fecha:</label>
                        <input type="date" id="fechaconsulta" name="fechaconsulta" required>
                    </div>
                    <button type="submit">Buscar</button>
                </form>

                <%
                    // Obtener parámetros de la solicitud
                    String fechaParamr = request.getParameter("fechaconsulta");

                    if (fechaParamr != null) {
                        LocalDate fechaconsulta = LocalDate.parse(fechaParamr);

                        // Crear instancia de ConsultaDAO
                        ConsultaDAO consultaDAO = new ConsultaDAO();
                        List<Consulta> consultas = consultaDAO.obtenerTodasConsultas(idSesion, fechaconsulta);

                        if (consultas != null && !consultas.isEmpty()) {
                %>
                <table class="table">
                    <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2 border-b">ID</th>
                        <th class="px-4 py-2 border-b">Médico ID</th>
                        <th class="px-4 py-2 border-b">Paciente ID</th>
                        <th class="px-4 py-2 border-b">Fecha</th>
                        <th class="px-4 py-2 border-b">Hora</th>
                        <th class="px-4 py-2 border-b">Descripción</th>
                        <th class="px-4 py-2 border-b">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Consulta consulta : consultas) { %>
                    <tr>
                        <td class="px-4 py-2 border-b"><%= consulta.getId() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= consulta.getIdMedico() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= consulta.getIdPaciente() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= consulta.getFecha() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= consulta.getHora() %>
                        </td>
                        <td class="px-4 py-2 border-b"><%= consulta.getDescripcion() %>
                        </td>
                        <td class="px-4 py-2 border-b">
                            <form action="Agenda.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="idconsultadelete" value="<%= consulta.getId() %>">
                                <button
                                        type="submit"
                                        class="btn-delete"
                                        onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">
                                    Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="mt-4 text-red-500">No se encontraron consultas para el médico y la fecha seleccionados.</p>
                <% } %>
                <% } else { %>
                <p class="mt-4 text-red-500">Por favor, seleccione un médico y una fecha para buscar.</p>
                <% } %>

                <%
                    // Lógica para eliminar consulta
                    String idParameliminar = request.getParameter("idconsultadelete");

                    if (idParameliminar != null) {
                        int id = Integer.parseInt(idParameliminar);

                        try {
                            ConsultaDAO consultaDAO = new ConsultaDAO();
                            int registros = consultaDAO.delete(id);

                            if (registros > 0) { %>
                <p>Consulta eliminada con éxito.</p>
                <%
                } else { %>
                <p>Error al eliminar la consulta.</p>
                <% }
                } catch (SQLException e) { %>
                <p>Error en la base de datos</p>
                <%
                        }
                    }
                %>
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