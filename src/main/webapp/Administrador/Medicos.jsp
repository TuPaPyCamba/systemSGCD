<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page buffer="8192kb" autoFlush="false" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
<%@ page import="com.sgcd.dao.SucursalDao"%>

<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 10/09/2024
  Time: 08:53 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
        <title>Gestión de Medicos</title>
        <script>
            function toggleForm(medicoId) {
            var form = document.getElementById('sectionEdit' + medicoId);
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'table-row';
            } else {
                form.style.display = 'none';
            }
        }

            function toggleNewForm() {
                var form = document.getElementById('new-medico-form');
                if (form.style.display === 'none' || form.style.display === '') {
                    form.style.display = 'block';
                } else {
                    form.style.display = 'none';
                }
            }

            function confirmarRegistro() {
                return confirm("¿Estás seguro de que quieres registrar este Medico?");
            }

            function confirmarEditRegistro() {
                return confirm("¿Estás seguro de que quieres editar el registro de este Medico?");
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
                                <h1>Gestión de Medicos</h1>
                                <button class="button-blue" onclick="toggleNewForm()">Añadir Nuevo Medico</button>
                            </div>
                            <div class="banner-line"></div>
                        </div>
                        <div class="g-container">
                            <form id="new-medico-form" class="form" style="display: none;" action="Medicos.jsp" method="post" onsubmit="return confirmarRegistro()">
                                <h2>Registrar Nuevo Medico</h2>
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
                                    <label for="especialidadcreate">Especialidad:</label>
                                    <input type="text" name="especialidadcreate" id="especialidadcreate" required>
                                </div>
                                <div class="form-group">
                                    <label for="idsucursalcreate">Sucursal</label>
                                    <input type="text" name="idsucursalcreate" id="idsucursalcreate" required>
                                </div>
                                <div class="form-actions">
                                    <button class="button-blue" type="submit" >Guardar</button>
                                    <button class="button-red" type="button" onclick="toggleNewForm()">Cancelar</button>
                                </div>
                            </form>

                    <form action="Medicos.jsp" method="get" class="search-form">
                        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
                        <button class="button-black" type="submit">Buscar</button>
                    </form>

                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellidos</th>
                                    <th>Sucursal</th>
                                    <th>Especialidad</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
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
                            <td><%= medico.getId() %></td>
                            <td><%= medico.getNombre()%></td>
                            <td><%= medico.getApellidos()%></td>
                            <td><%= sucursalDAO.obtenerSucursalPorId(medico.getIdsucursal()).getNombre()%></td>
                            <td><%= medico.getEspecialidad()%></td>
                            <td>
                                <button class="button-black" onclick="toggleForm(<%= medico.getId() %>)">Editar</button>
                                <form action="Medicos.jsp" method="post" style="display: inline">
                                    <input type="hidden" name="id" value="<%= medico.getId() %>">
                                    <button class="button-red" type="submit" onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">
                                        Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <tr id='sectionEdit<%= medico.getId() %>' style="display: none;">
                            <td colspan="6">
                                <form action="Medicos.jsp" class="form" method="post">
                                    <input type="hidden" name="idedit" value="<%= medico.getId() %>">
                                    <input type="hidden" name="idsucursaledit" value="<%= medico.getIdsucursal() %>">
                                    <div class="form-group">
                                        <label for="usuarioedit<%= medico.getId() %>">Usuario:</label>
                                        <input type="text" name="usuarioedit" id="usuarioedit<%= medico.getId() %>" value="<%= medico.getUsuario() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="contrasenaedit<%= medico.getId() %>">Contraseña:</label>
                                        <input type="password" name="contrasenaedit" id="contrasenaedit<%= medico.getId() %>" value="<%= medico.getContrasena() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="nombreedit<%= medico.getId() %>">Nombre:</label>
                                        <input type="text" name="nombreedit" id="nombreedit<%= medico.getId() %>" value="<%= medico.getNombre() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="apellidosedit<%= medico.getId() %>">Apellidos:</label>
                                        <input type="text" name="apellidosedit" id="apellidosedit<%= medico.getId() %>" value="<%= medico.getApellidos() %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="especialidadedit<%= medico.getId() %>">Especialidad:</label>
                                        <input type="text" name="especialidadedit" id="especialidadedit<%= medico.getId() %>" value="<%= medico.getEspecialidad() %>">
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
        String idsucursaledit = request.getParameter("idsucursaledit");
        String usuarioedit = request.getParameter("usuarioedit");
        String contrasenaedit = request.getParameter("contrasenaedit");
        String nombreedit = request.getParameter("nombreedit");
        String apellidosedit = request.getParameter("apellidosedit");
        String especialidadedit = request.getParameter("especialidadedit");

    if (idEditStr != null && !idEditStr.isEmpty()) {
        int idEdit = Integer.parseInt(idEditStr);
        int idsucursaltoeditint = Integer.parseInt(idsucursaledit);
        Medico medicoEdit = new Medico(usuarioedit, contrasenaedit, nombreedit, apellidosedit, idsucursaltoeditint, especialidadedit);
        medicoEdit.setId(idEdit);
        try {
            int registrosEditados = medicoDAO.actualizar(medicoEdit);
            response.sendRedirect("Medicos.jsp");
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
    %>
    <!-- Logico de registro -->
    <%
        // Manejo de la creación de un nuevo Medico
        String usuariocreate = request.getParameter("usuariocreate");
        String contrasenacreate = request.getParameter("contrasenacreate");
        String idsucursalcreatestr = request.getParameter("idsucursalcreate");
        String nombrecreate = request.getParameter("nombrecreate");
        String apellidoscreate = request.getParameter("apellidoscreate");
        String especialidadcreate = request.getParameter("especialidadcreate");

        Integer idsucursalcreate = null;
    if (idsucursalcreatestr != null && !idsucursalcreatestr.isEmpty()) {
        try {
            idsucursalcreate = Integer.parseInt(idsucursalcreatestr);
        } catch (NumberFormatException e) {
            // Log the error
            System.err.println("Error parsing idSucursalCreate: " + e.getMessage());
        }
    }
    
    if (usuariocreate != null && contrasenacreate != null && nombrecreate != null && apellidoscreate != null && especialidadcreate != null) {
            Medico nuevoMedico = new Medico(usuariocreate, contrasenacreate, nombrecreate, apellidoscreate, idsucursalcreate, especialidadcreate);
            try {
                int registros = medicoDAO.create(nuevoMedico);
                System.out.println("Creando medico");
                response.sendRedirect("Medicos.jsp");
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
}
//logger
System.out.println(usuariocreate);
    System.out.println(contrasenacreate);
    System.out.println(idsucursalcreate);
    System.out.println(nombrecreate);
    System.out.println(apellidoscreate);
    System.out.println(especialidadcreate);
    %>
    <!-- Logico de eliminacion -->
    <%
        // Manejo de la eliminación de un Medico
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            try {
                int registrosEliminados = medicoDAO.delete(id);
                response.sendRedirect("Medicos.jsp");
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
