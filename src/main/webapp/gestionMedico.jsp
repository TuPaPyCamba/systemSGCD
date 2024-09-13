<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>Gestion de Medico</title>
    <link rel="stylesheet" href="css/Style.css">
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
<div class="g-container">
    <!-- banner y boton para desplegar la creacion de medico -->
    <div class="g-banner-container">
        <div class="g-banner-labelbutton-container">
            <h2 class="label-banner">Gestion de Médicos</h2>
            <button class="btn-newuser" onclick="toggleNewForm()" >Añadir Nuevo Médico</button>
        </div>
        <div class="blue-line"></div>
    </div>
    <!-- Formulario de nuevo Medico -->
    <div id="new-medico-form" class="create-form">
        <h3>Registrar Nuevo Medico</h3>
        <form action="gestionMedico.jsp" method="post" onsubmit="return confirmarRegistro() ">
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
    <form action="gestionMedico.jsp" method="get" class="search-form">
        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
        <button type="submit">Buscar</button>
    </form>
    <!-- Tabla de registros -->
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Usuario</th>
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
            <td><%= medico.getId()%></td>
            <td><%= medico.getUsuario()%></td>
            <td><%= medico.getNombre()%></td>
            <td><%= medico.getApellidos()%></td>
            <td><%= medico.getEspecialidad()%></td>
            <td>
                <form action="gestionMedico.jsp" method="post" style="display: inline">
                    <input type="hidden" name="id" value="<%= medico.getId() %>">
                    <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar este Medico?');">Eliminar</button>
                </form>
                <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
            </td>
        </tr>
        <!-- Formulario de edicion -->
        <tr class="edit-form">
            <td colspan="6">
                <form action="gestionMedico.jsp" method="post">
                    <input type="hidden" name="idedit" value="<%= medico.getId() %>">
                    <label>Usuario: </label><input type="text" name="usuarioedit" value="<%= medico.getUsuario()%>">
                    <label>Contraseña: </label><input type="password" name="contrasenaedit" value="<%= medico.getContrasena()%>">
                    <label>Nombre: </label><input type="text" name="nombreedit" value="<%= medico.getNombre()%>">
                    <label>Apellidos: </label><input type="text" name="apellidosedit" value="<%= medico.getApellidos()%>">
                    <label>Dirección: </label><input type="text" name="especialidadedit" value="<%= medico.getEspecialidad()%>">
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
                response.sendRedirect("gestionMedico.jsp");
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
        String especialidadcreate = request.getParameter("especialidadcreate");

        if (usuariocreate != null && contrasenacreate != null && nombrecreate != null && apellidoscreate != null
                && especialidadcreate != null) {
            // Solo intentamos crear un nuevo paciente si todos los campos están llenos
            if (!usuariocreate.isEmpty() && !contrasenacreate.isEmpty() && !nombrecreate.isEmpty() && !apellidoscreate.isEmpty()
                    && !especialidadcreate.isEmpty()) {
                Medico nuevoMedico = new Medico(usuariocreate, contrasenacreate, nombrecreate, apellidoscreate, especialidadcreate);
                try {
                    int registros = medicoDAO.create(nuevoMedico);
                    response.sendRedirect("gestionMedico.jsp");
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
                int registrosEliminados = medicoDAO.delete(id);
                response.sendRedirect("gestionMedico.jsp");
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        }

    %>
</div>
</body>
</html>
