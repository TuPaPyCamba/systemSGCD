<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 09/09/2024
  Time: 07:46 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestion de Pacientes</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <div class="g-container">
        <!-- banner y boton para desplegar la creacion de paciente -->
        <div class="g-banner-container">
            <div class="g-banner-labelbutton-container">
                <h2 class="label-banner">Gestion de Pacientes</h2>
                <button class="btn-newuser" onclick="toggleNewForm()" >Añadir Nuevo Paciente</button>
            </div>
            <div class="blue-line"></div>
        </div>
        <!-- Formulario de nuevo Paciente -->
        <div id="new-paciente-form" class="create-form">
            <h3>Registrar Nuevo Paciente</h3>
            <form action="gestionPaciente.jsp" method="post" onsubmit="return confirmarRegistro() ">
                <label>Usuario: </label><input type="text" name="usuariocreate" id="usuariocreate" required>
                <label>Contraseña: </label><input type="password" name="contrasenacreate" id="contrasenacreate" required>
                <label>Nombre: </label><input type="text" name="nombrecreate" id="nombrecreate" required>
                <label>Apellidos: </label><input type="text" name="apellidoscreate" id="apellidoscreate" required>
                <label>Teléfono: </label><input type="text" name="telefonocreate" id="telefonocreate" required>
                <label>Dirección: </label><input type="text" name="direccioncreate" id="direccioncreate" required>
                <button type="submit" class="create-form-save-button">Guardar</button>
                <button type="button" class="create-form-edit-button" onclick="toggleNewForm()">Cancelar</button>
            </form>
        </div>
        <!-- Formulario de Busqueda para el filtro -->
        <form action="gestionPaciente.jsp" method="get" class="search-form">
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
                    <th>Telefono</th>
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
                    for(Paciente paciente : pacientes) {
                        if(paciente.getNombre().toLowerCase().contains(busqueda.toLowerCase())){
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
                for(Paciente paciente : pacientesFiltrados){
        %>
                            <tr>
                                <td><%= paciente.getIdPaciente() %></td>
                                <td><%= paciente.getNombre()%></td>
                                <td><%= paciente.getApellidos()%></td>
                                <td><%= paciente.getTelefono()%></td>
                                <td><%= paciente.getDireccion()%></td>
                                <td>
                                    <form action="gestionPaciente.jsp" method="post" style="display: inline">
                                        <input type="hidden" name="id" value="<%= paciente.getIdPaciente() %>">
                                        <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar este paciente?');">Eliminar</button>
                                    </form>
                                    <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
                                </td>
                            </tr>
                            <!-- Formulario de edicion -->
                            <tr class="edit-form">
                                <td colspan="6">
                                    <form action="gestionPaciente.jsp" method="post">
                                        <input type="hidden" name="idedit" value="<%= paciente.getIdPaciente() %>">
                                        <label>Usuario: </label><input type="text" name="usuarioedit" value="<%= paciente.getPaciente() %>">
                                        <label>Contraseña: </label><input type="password" name="contrasenaedit" value="<%= paciente.getContrasena() %>">
                                        <label>Nombre: </label><input type="text" name="nombreedit" value="<%= paciente.getNombre() %>">
                                        <label>Apellidos: </label><input type="text" name="apellidosedit" value="<%= paciente.getApellidos() %>">
                                        <label>Teléfono: </label><input type="text" name="telefonoedit" value="<%= paciente.getTelefono() %>">
                                        <label>Dirección: </label><input type="text" name="direccionedit" value="<%= paciente.getDireccion() %>">
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
        <!-- Logica para crear nuevo Paciente -->
        <%
        //manejo edicion ----------------
        String idtoedit = request.getParameter("id");
        String usuarioedit = request.getParameter("usuarioedit");
        String contrasenaedit = request.getParameter("contrasenaedit");
        String nombreedit = request.getParameter("nombreedit");
        String apellidosedit = request.getParameter("apellidosedit");
        String telefonoedit = request.getParameter("telefonoedit");
        String direccionedit = request.getParameter("direccionedit");

        int idedit = Integer.parseInt(idtoedit);

        Paciente pacienteEdit = new Paciente(idedit,usuarioedit, contrasenaedit, nombreedit, apellidosedit, telefonoedit, direccionedit);

        PacienteDAO pacienteDAOEdit = new PacienteDAO();

            try{
                int registrosEditados = pacienteDAOEdit.actualizar(pacienteEdit);
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }

        //manejo de la eliminacion ------------------
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            String mensaje = "";

            try {
                int registrosEliminados = pacienteDAO.delete(id);
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