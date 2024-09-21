<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page buffer="8192kb" autoFlush="false" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 10/09/2024
  Time: 08:53 p. m.
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
        <title>Gestión de Pacientes</title>
        <script>
        function toggleForm(patientId) {
            var form = document.getElementById('sectionEdit' + patientId);
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'table-row';
            } else {
                form.style.display = 'none';
            }
        }

        function toggleNewForm() {
            var form = document.getElementById('new-paciente-form');
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'block';
            } else {
                form.style.display = 'none';
            }
        }

        function confirmarRegistro() {
            return confirm("¿Estás seguro de que quieres registrar este Paciente?");
        }

        function confirmarEditRegistro() {
            return confirm("¿Estás seguro de que quieres editar el registro de este Paciente?");
        }
    </script>
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
        <navbar class="sidebar">
            <h2><a href="../index.jsp">Salud Dental</a></h2>
            <nav>
                <ul>
                    <li><a href="Home.jsp" class="menu-item">&#127968; Home</a></li>
                    <li><a href="Pacientes.jsp" class="menu-item">&#128100; Pacientes</a></li>
                    <li><a href="Medicos.jsp" class="menu-item">&#128104;&#8205;&#9877;&#65039; Medicos</a></li>
                    <li><a href="Citas.jsp" class="menu-item">&#128197; Citas</a></li>
                    <li><a href="Consultas.jsp" class="menu-item">&#128196; Consultas</a></li>
                    <li><a href="Settings.jsp" class="menu-item">&#9881;&#65039; Ajustes</a></li>
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
            <section class="dashboard">
                <div class="banner">
                    <div class="banner__header">
                        <h1 class="banner__title">Gestión de Pacientes</h1>
                        <button class="banner__button" onclick="toggleNewForm()">Añadir Nuevo Paciente</button>
                    </div>
                    <div class="banner__line"></div>
                </div>
                <form id="new-paciente-form" class="form" style="display: none;" action="Pacientes.jsp" method="post" onsubmit="return confirmarRegistro()">
                    <h2>Registrar Nuevo Paciente</h2>
                    <div class="form-group">
                        <label for="usuariocreate">Usuario:</label>
                        <input type="text" name="usuariocreate" id="usuariocreate" required>
                    </div>
                    <div class="form-group">
                        <label for="contrasenacreate">Contraseña:</label>
                        <input type="password" name="contrasenacreate" id="contrasenacreate" required>
                    </div>
                    <div class="form-group">
                        <label for="nombrecreate">Nombre:</label>
                        <input type="text" name="nombrecreate" id="nombrecreate" required>
                    </div>
                    <div class="form-group">
                        <label for="apellidoscreate">Apellidos:</label>
                        <input type="text" name="apellidoscreate" id="apellidoscreate" required>
                    </div>
                    <div class="form-group">
                        <label for="telefonocreate">Teléfono:</label>
                        <input type="tel" name="telefonocreate" id="telefonocreate" required>
                    </div>
                    <div class="form-group">
                        <label for="direccioncreate">Dirección:</label>
                        <input type="text" name="direccioncreate" id="direccioncreate" required>
                    </div>
                    <div class="form-actions">
                        <button class="button-blue" type="submit" >Guardar</button>
                        <button class="button-red" type="button" onclick="toggleNewForm()">Cancelar</button>
                    </div>
                </form>

                <form action="Pacientes.jsp" method="get" class="search-form">
                    <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
                    <button class="button-black" type="submit">Buscar</button>
                </form>

                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Teléfono</th>
                            <th>Dirección</th>
                            <th>Acciones</th>
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
                            <td><%= paciente.getTelefono() %></td>
                            <td><%= paciente.getDireccion() %></td>
                            <td>
                                <button class="button-black" onclick="toggleForm(<%= paciente.getIdPaciente() %>)">Editar</button>
                                <form action="Pacientes.jsp" method="post" style="display: inline">
                                    <input type="hidden" name="id" value="<%= paciente.getIdPaciente() %>">
                                    <button class="button-red" type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar este paciente?');">
                                        Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <tr id='sectionEdit<%= paciente.getIdPaciente() %>' style="display: none;">
                            <td colspan="6">
                                <form action="Pacientes.jsp" class="form" method="post">
                                    <div class="form-group">
                                        <label for="usuarioedit<%= paciente.getIdPaciente() %>">Usuario:</label>
                                        <input type="text" name="usuarioedit" id="usuarioedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getPaciente() %>">
                                    </div>
                                        <div class="form-group">
                                            <label for="contrasenaedit<%= paciente.getIdPaciente() %>">Contraseña:</label>
                                        <input type="password" name="contrasenaedit" id="contrasenaedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getContrasena() %>">
                                    </div>
                                        <div class="form-group">
                                            <label for="nombreedit<%= paciente.getIdPaciente() %>">Nombre:</label>
                                        <input type="text" name="nombreedit" id="nombreedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getNombre() %>">
                                    </div>
                                        <div class="form-group">
                                            <label for="apellidosedit<%= paciente.getIdPaciente() %>">Apellidos:</label>
                                        <input type="text" name="apellidosedit" id="apellidosedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getApellidos() %>">
                                    </div>
                                        <div class="form-group">
                                            <label for="telefonoedit<%= paciente.getIdPaciente() %>">Teléfono:</label>
                                        <input type="tel" name="telefonoedit" id="telefonoedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getTelefono() %>">
                                    </div>
                                        <div class="form-group">
                                            <label for="direccionedit<%= paciente.getIdPaciente() %>">Dirección:</label>
                                            <input type="text" name="direccionedit" id="direccionedit<%= paciente.getIdPaciente() %>" value="<%= paciente.getDireccion() %>">
                                        </div>
                                        <div class="form-actions">
                                            <button type="submit" class="button-blue">Guardar</button>
                                        </div>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
    <!-- Logico de edit -->
<%
    String idEditStr = request.getParameter("idedit");
    String usuarioedit = request.getParameter("usuarioedit");
    String contrasenaedit = request.getParameter("contrasenaedit");
    String nombreedit = request.getParameter("nombreedit");
    String apellidosedit = request.getParameter("apellidosedit");
    String telefonoedit = request.getParameter("telefonoedit");
    String direccionedit = request.getParameter("direccionedit");

    if (idEditStr != null && !idEditStr.isEmpty()) {
        int idEdit = Integer.parseInt(idEditStr);
        Paciente pacienteEdit = new Paciente(usuarioedit, contrasenaedit, nombreedit, apellidosedit, telefonoedit, direccionedit);
        pacienteEdit.setIdPaciente(idEdit);
        try {
            int registrosEditados = pacienteDAO.actualizar(pacienteEdit);
            response.sendRedirect("Pacientes.jsp");
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
%>
<!-- Logico de registro -->
<%
    // Manejo de la creación de un nuevo paciente
    String usuariocreate = request.getParameter("usuariocreate");
    String contrasenacreate = request.getParameter("contrasenacreate");
    String nombrecreate = request.getParameter("nombrecreate");
    String apellidoscreate = request.getParameter("apellidoscreate");
    String telefonocreate = request.getParameter("telefonocreate");
    String direccioncreate = request.getParameter("direccioncreate");

    if (usuariocreate != null && contrasenacreate != null && nombrecreate != null && apellidoscreate != null
            && telefonocreate != null && direccioncreate != null) {
        // Solo intentamos crear un nuevo paciente si todos los campos están llenos
        if (!usuariocreate.isEmpty() && !contrasenacreate.isEmpty() && !nombrecreate.isEmpty() && !apellidoscreate.isEmpty()
                && !telefonocreate.isEmpty() && !direccioncreate.isEmpty()) {
            Paciente nuevoPaciente = new Paciente(usuariocreate, contrasenacreate, nombrecreate, apellidoscreate, telefonocreate, direccioncreate);
            try {
                int registros = pacienteDAO.create(nuevoPaciente);
                response.sendRedirect("Pacientes.jsp");
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }
    }
%>
<!-- Logico de eliminacion -->
<%
    // Manejo de la eliminación de un paciente
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
        try {
            int registrosEliminados = pacienteDAO.delete(id);
            response.sendRedirect("Pacientes.jsp");
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

%>
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
