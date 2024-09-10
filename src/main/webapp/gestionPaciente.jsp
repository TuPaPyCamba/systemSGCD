<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.sql.SQLException" %>
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
    <title>Title</title>
</head>
<body>
    <h2>Buscar Paciente</h2>
    <form action="gestionPaciente.jsp" method="get">
        <input type="text" name="busqueda" id="busqueda" placeholder="Buscar..." value="<%= request.getParameter("busqueda") %>">
        <button type="submit">Buscar</button>
    </form>

    <table>
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
            PacienteDAO pacienteDAO = new PacienteDAO();
            List<Paciente> pacientes = null;

            try {
                if (busqueda != null && !busqueda.isEmpty()) {
                    String nombre = busqueda;
                    pacientes = pacienteDAO.findByName(nombre);
                } else {
                    pacientes = pacienteDAO.obtenerPacientes();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (pacientes != null && !pacientes.isEmpty()) {
                for (Paciente paciente : pacientes) {
        %>
                            <tr>
                                <td><%= paciente.getIdPaciente() %></td>
                                <td><%= paciente.getNombre()%></td>
                                <td><%= paciente.getApellidos()%></td>
                                <td><%= paciente.getTelefono()%></td>
                                <td><%= paciente.getDireccion()%></td>
                                <td>
                                    <a href="">Editar</a>
                                    <form action="gestionPaciente.jsp" method="post" style="display: inline">
                                        <input type="hidden" name="id" value="<%= paciente.getIdPaciente() %>">
                                        <button type="submit" onclick="return confirm('¿Estás seguro de que quieres eliminar este paciente?');">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        <%
                    }
                }
            %>
                    <tr>
                        <td colspan="8"> Error al cargar los datos</td>
                    </tr>
        </tbody>
    </table>
    <%
        //manejo de la eliminacion
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            String mensaje = "";

            try {
                int registrosEliminados = pacienteDAO.delete(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    %>
</body>
</html>
