<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
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
        <%
            if (!"administradores".equals(session.getAttribute("tipoUsuario"))) {
                response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
            }
        %>
        <title>Gestión de Medicos</title>
        <link rel="stylesheet" href="../css/modulos.css">
        <link rel="stylesheet" href="../css/Dashboards.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script>
            function toggleForm(button) {
                var fila = button.closest('tr');
                var siguienteFila = fila.nextElementSibling;

                if (siguienteFila.classList.contains('edit-form')) {
                    if (siguienteFila.style.display === "none" || siguienteFila.style.display === "") {
                        siguienteFila.style.display = "table-row";
                        button.textContent = "Cerrar";
                    } else {
                        siguienteFila.style.display = "none";
                        button.textContent = "Editar";
                    }
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
                    <!-- banner y boton para desplegar la creacion de paciente -->
                    <div class="g-banner-container">
                        <div class="g-banner-labelbutton-container">
                            <h2 class="label-banner">Gestion de Medicos</h2>
                            <button class="btn-newuser" onclick="toggleNewForm()" >Añadir Nuevo Medicos</button>
                        </div>
                        <div class="blue-line"></div>
                    </div>
                    <!-- Formulario de nuevo Paciente -->
                    <div id="new-medico-form" class="create-form">
                        <h3>Registrar Nuevo Paciente</h3>
                        <form action="GestionMedicos.jsp" method="post" onsubmit="return confirmarRegistro() ">
                            <label>Usuario: </label><input type="text" name="usuariocreate" id="usuariocreate" required>
                            <label>Contraseña: </label><input type="password" name="contrasenacreate" id="contrasenacreate" required>
                            <label>Nombre: </label><input type="text" name="nombrecreate" id="nombrecreate" required>
                            <label>Apellidos: </label><input type="text" name="apellidoscreate" id="apellidoscreate" required>
                            <label>Especialidad: </label><input type="text" name="especialidadcreate" id="especialidadcreate" required>
                            <button type="submit" class="create-form-save-button">Guardar</button>
                            <button type="button" class="create-form-edit-button" onclick="toggleNewForm()">Cancelar</button>
                        </form>
                    </div>
                    <!-- Formulario de Busqueda para el filtro -->
                    <form action="GestionMedicos.jsp" method="get" class="search-form">
                        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
                        <button type="submit">Buscar</button>
                    </form>
                    <!-- Tabla de registros -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellidos</th>
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
                                        for(Medico medico : medicos) {
                                            if(medico.getNombre().toLowerCase().contains(busqueda.toLowerCase())){
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
        for(Medico medico : medicosFiltrados){
                            %>
                            <tr>
                                <td><%= medico.getId() %></td>
                                <td><%= medico.getNombre()%></td>
                                <td><%= medico.getApellidos()%></td>
                                <td><%= medico.getEspecialidad()%></td>
                                <td>
                                    <form action="GestionMedicos.jsp" method="post" style="display: inline">
                                        <input type="hidden" name="id" value="<%= medico.getId() %>">
                                        <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">Eliminar</button>
                                    </form>
                                    <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
                                </td>
                            </tr>
                            <!-- Formulario de edicion -->
                            <tr class="edit-form">
                                <td colspan="6">
                                    <form action="GestionMedicos.jsp" method="post">
                                        <input type="hidden" name="idedit" value="<%= medico.getId() %>">
                                        <label>Usuario: </label><input type="text" name="usuarioedit" value="<%= medico.getUsuario()%>">
                                        <label>Contraseña: </label><input type="password" name="contrasenaedit" value="<%= medico.getContrasena()%>">
                                        <label>Nombre: </label><input type="text" name="nombreedit" value="<%= medico.getNombre()%>">
                                        <label>Apellidos: </label><input type="text" name="apellidosedit" value="<%= medico.getApellidos()%>">
                                        <label>Teléfono: </label><input type="text" name="especialidadedit" value="<%= medico.getEspecialidad()%>">
                                        <button type="submit" class="edit-form-save-button">Guardar</button>
                                    </form>
                                </td>
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
        <!-- Logico de edit -->
                            <%
                            String idEditStr = request.getParameter("idedit");
                            String usuarioedit = request.getParameter("usuarioedit");
                            String contrasenaedit = request.getParameter("contrasenaedit");
                            String nombreedit = request.getParameter("nombreedit");
                            String apellidosedit = request.getParameter("apellidosedit");
                            String especialidadedit = request.getParameter("especialidadedit");

                if (idEditStr != null && !idEditStr.isEmpty()) {
                    int idEdit = Integer.parseInt(idEditStr);
                    Medico medicoEdit = new Medico(usuarioedit, contrasenaedit, nombreedit, apellidosedit, especialidadedit);
                    medicoEdit.setId(idEdit);
                    try {
                        int registrosEditados = medicoDAO.actualizar(medicoEdit);
                        response.sendRedirect("GestionMedicos.jsp");
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
                            String nombrecreate = request.getParameter("nombrecreate");
                            String apellidoscreate = request.getParameter("apellidoscreate");
                            String especialidadcreate = request.getParameter("especialidadcreate");

                if (usuariocreate != null && contrasenacreate != null && nombrecreate != null && apellidoscreate != null
                        && especialidadcreate != null) {
                    // Solo intentamos crear un nuevo Medico si todos los campos están llenos
                    if (!usuariocreate.isEmpty() && !contrasenacreate.isEmpty() && !nombrecreate.isEmpty() && !apellidoscreate.isEmpty()
                            && !especialidadcreate.isEmpty()) {
                        Medico nuevoMedico = new Medico(usuariocreate, contrasenacreate, nombrecreate, apellidoscreate, especialidadcreate);
                        try {
                            int registros = medicoDAO.create(nuevoMedico);
                            response.sendRedirect("GestionMedicos.jsp");
                        } catch (SQLException ex) {
                            throw new RuntimeException(ex);
                        }
                    }
                }
            %>
        <!-- Logico de eliminacion -->
            <%
                            // Manejo de la eliminación de un Medico
                            String idParam = request.getParameter("id");
                            if (idParam != null && !idParam.isEmpty()) {
                                int id = Integer.parseInt(idParam);
                                try {
                                    int registrosEliminados = medicoDAO.delete(id);
                                    response.sendRedirect("GestionMedicos.jsp");
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
