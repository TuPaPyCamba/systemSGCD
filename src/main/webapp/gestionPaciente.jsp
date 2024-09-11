<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestión de Pacientes</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
<div class="g-container">
    <!-- banner y botón para desplegar la creación de paciente -->
    <div class="g-banner-container">
        <div class="g-banner-labelbutton-container">
            <h2 class="label-banner">Gestión de Pacientes</h2>
            <button class="btn-newuser" onclick="toggleNewForm()">Añadir Nuevo Paciente</button>
        </div>
        <div class="blue-line"></div>
    </div>
    <!-- Formulario de nuevo Paciente -->
    <div id="new-paciente-form" class="create-form" style="display: none;">
        <h3>Registrar Nuevo Paciente</h3>
        <form action="gestionPaciente.jsp" method="post" onsubmit="return confirmarRegistro()">
            <label>Usuario: </label><input type="text" name="usuariocreate" required>
            <label>Contraseña: </label><input type="password" name="contrasenacreate" required>
            <label>Nombre: </label><input type="text" name="nombrecreate" required>
            <label>Apellidos: </label><input type="text" name="apellidoscreate" required>
            <label>Teléfono: </label><input type="text" name="telefonocreate" required>
            <label>Dirección: </label><input type="text" name="direccioncreate" required>
            <button type="submit" class="create-form-save-button">Guardar</button>
            <button type="button" class="create-form-edit-button" onclick="toggleNewForm()">Cancelar</button>
        </form>
    </div>
    <!-- Formulario de búsqueda para el filtro -->
    <form action="gestionPaciente.jsp" method="get" class="search-form">
        <input type="text" name="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
        <button type="submit">Buscar</button>
    </form>
    <!-- Tabla de registros -->
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
            List<Paciente> pacientes = new ArrayList<>();
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

            for (Paciente paciente : pacientesFiltrados) {
        %>
        <tr>
            <td><%= paciente.getIdPaciente() %></td>
            <td><%= paciente.getNombre() %></td>
            <td><%= paciente.getApellidos() %></td>
            <td><%= paciente.getTelefono() %></td>
            <td><%= paciente.getDireccion() %></td>
            <td>
                <form action="gestionPaciente.jsp" method="post" style="display: inline;">
                    <input type="hidden" name="id" value="<%= paciente.getIdPaciente() %>">
                    <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar este paciente?');">Eliminar</button>
                </form>
                <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
            </td>
        </tr>
        <!-- Formulario de edición -->
        <tr class="edit-form" style="display: none;">
            <td colspan="6">
                <form action="gestionPaciente.jsp" method="post">
                    <input type="hidden" name="idedit" value="<%= paciente.getIdPaciente() %>">
                    <label>Usuario: </label><input type="text" name="usuarioedit" value="<%= paciente.getPaciente() %>" required>
                    <label>Contraseña: </label><input type="password" name="contrasenaedit" value="<%= paciente.getContrasena() %>" required>
                    <label>Nombre: </label><input type="text" name="nombreedit" value="<%= paciente.getNombre() %>" required>
                    <label>Apellidos: </label><input type="text" name="apellidosedit" value="<%= paciente.getApellidos() %>" required>
                    <label>Teléfono: </label><input type="text" name="telefonoedit" value="<%= paciente.getTelefono() %>" required>
                    <label>Dirección: </label><input type="text" name="direccionedit" value="<%= paciente.getDireccion() %>" required>
                    <button type="submit" class="edit-form-save-button" onclick="return confirmarEditRegistro()">Guardar</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <!-- Lógica para crear nuevo Paciente -->
    <%
        String usuarioCreate = request.getParameter("usuariocreate");
        String contrasenaCreate = request.getParameter("contrasenacreate");
        String nombreCreate = request.getParameter("nombrecreate");
        String apellidosCreate = request.getParameter("apellidoscreate");
        String telefonoCreate = request.getParameter("telefonocreate");
        String direccionCreate = request.getParameter("direccioncreate");

        if (usuarioCreate != null && !usuarioCreate.isEmpty()) {
            Paciente nuevoPaciente = new Paciente(usuarioCreate, contrasenaCreate, nombreCreate, apellidosCreate, telefonoCreate, direccionCreate);
            PacienteDAO pacienteDAOCreate = new PacienteDAO();
            try {
                pacienteDAOCreate.create(nuevoPaciente);
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }

        // Manejo de la edición
        String idToEdit = request.getParameter("idedit");
        String usuarioEdit = request.getParameter("usuarioedit");
        String contrasenaEdit = request.getParameter("contrasenaedit");
        String nombreEdit = request.getParameter("nombreedit");
        String apellidosEdit = request.getParameter("apellidosedit");
        String telefonoEdit = request.getParameter("telefonoedit");
        String direccionEdit = request.getParameter("direccionedit");

        if (idToEdit != null && !idToEdit.isEmpty()) {
            int idEdit = Integer.parseInt(idToEdit);
            Paciente pacienteEdit = new Paciente(idEdit, usuarioEdit, contrasenaEdit, nombreEdit, apellidosEdit, telefonoEdit, direccionEdit);
            PacienteDAO pacienteDAOEdit = new PacienteDAO();
            try {
                pacienteDAOEdit.actualizar(pacienteEdit);
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }

        // Manejo de la eliminación
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            PacienteDAO pacienteDAODelete = new PacienteDAO();
            try {
                pacienteDAODelete.delete(id);
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }
    %>
</div>
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
        var form = document.getElementById('new-paciente-form');
        if (form.style.display === 'none' || form.style.display === '') {
            form.style.display = 'block';
        } else {
            form.style.display = 'none';
        }
    }

    function confirmarRegistro() {
        return confirm("¿Estás seguro de que quieres registrar este paciente?");
    }

    function confirmarEditRegistro() {
        return confirm("¿Estás seguro de que quieres editar el registro de este paciente?");
    }
</script>
</body>
</html>