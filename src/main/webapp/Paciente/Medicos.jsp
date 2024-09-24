<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
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
                    if (!"pacientes".equals(session.getAttribute("tipoUsuario"))) {
                        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
                    }
        %>
        <title>Tabla de Medicos</title>
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
                <li><a href="Medicos.jsp" class="menu-item">&#128104;&#8205;&#9877;&#65039; Medicos</a></li>
                <li><a href="Citas.jsp" class="menu-item">&#128197; Citas</a></li>
                <li><a href="Agenda.jsp" class="menu-item">&#128197; Agenda</a></li>
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
        <div class="dashboard">
            <h2>Tabla de Medicos</h2>

                    <!-- Formulario de búsqueda -->
                    <form action="Medicos.jsp" method="get" class="search-form">
                        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar por nombre..." value="<%= request.getParameter("busqueda") %>">
                        <button class="button-black" type="submit">Buscar</button>
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