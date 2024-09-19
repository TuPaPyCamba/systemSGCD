<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <%
                    if (!"pacientes".equals(session.getAttribute("tipoUsuario"))) {
                        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
                    }
        %>
        <title>Tabla de Medicos</title>
    <link rel="stylesheet" href="../css/modulos.css">
    <link rel="stylesheet" href="../css/Dashboards.css">
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
        <a href="Medicos.jsp" class="menu-item">
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
                    <h2>Tabla de Medicos</h2>

                    <!-- Formulario de búsqueda -->
                    <form action="Medicos.jsp" method="get" class="search-form">
                        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar por nombre..."
                               value="<%= request.getParameter("busqueda") %>">
                        <button type="submit">Buscar</button>
                    </form>

                    <!-- Tabla de pacientes -->
                    <table class="table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Especialidad</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tbody>
                        <%
                            String busqueda = request.getParameter("busqueda");
                            List<Medico> medicos = null;
                            List<Medico> medicosFiltrados = new ArrayList<>();
                            MedicoDAO medicoDAO = new MedicoDAO();

                            try {
                                medicos = medicoDAO.obtenerMedicos();
                                if (busqueda != null && !busqueda.isEmpty()) {
                                    for (Medico medico : medicos) {
                                        if (medico.getNombre().toLowerCase().contains(busqueda.toLowerCase())) {
                                            medicosFiltrados.add(medico);
                                        }
                                    }
                                } else {
                                    medicosFiltrados = medicos;
                                }
                            } catch (SQLException ex) {
                                throw new RuntimeException(ex);
                            }

                            if (medicosFiltrados != null && !medicosFiltrados.isEmpty()) {
                                for (Medico medico : medicosFiltrados) {
                        %>
                        <tr>
                            <td><%= medico.getId() %>
                            </td>
                            <td><%= medico.getNombre() %>
                            </td>
                            <td><%= medico.getApellidos() %>
                            </td>
                            <td><%= medico.getEspecialidad()%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
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