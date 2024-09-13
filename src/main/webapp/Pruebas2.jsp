<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 12/09/2024
  Time: 05:01 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Cita</title>
</head>
<body>
<h2>Crear nueva cita</h2>

<%

    CitaDAO citaDAO = new CitaDAO();
    MedicoDAO medicoDAO = new MedicoDAO();
    PacienteDAO pacienteDAO = new PacienteDAO();

    // Obtener las listas de médicos y pacientes
    List<Medico> listaMedicos = medicoDAO.obtenerMedicos();
    List<Paciente> listaPacientes = pacienteDAO.obtenerPacientes();
    // Procesar la primera parte del formulario, obtener las horas disponibles
    String idmedicostr = request.getParameter("idmedico");
    String idpacientestr = request.getParameter("idpaciente");
    String fechastr = request.getParameter("fecha");

    List<String> horasDisponibles = new ArrayList<>();
    boolean mostrarFormulario = true;

    if (idmedicostr != null && idpacientestr != null && fechastr != null) {
        try {
            int idmedico = Integer.parseInt(idmedicostr);
            int idpaciente = Integer.parseInt(idpacientestr);
            LocalDate fecha = LocalDate.parse(fechastr);

            // Obtener las horas disponibles para el médico y el día seleccionado
            horasDisponibles = citaDAO.obtenerHorasDisponiblesParaCitas(idmedico, fecha);

            mostrarFormulario = false;
        } catch (Exception e) {
            System.out.println("Error al procesar los parámetros: " + e.getMessage());
        }
    }
%>

<!-- Primer formulario para seleccionar médico, paciente y fecha -->
<form action="Pruebas2.jsp" method="POST">
    <label for="idpaciente">Seleccione Paciente:</label>
    <select id="idpaciente" name="idpaciente" required>
        <% for (Paciente paciente : listaPacientes) { %>
        <option value="<%= paciente.getIdPaciente() %>"><%= paciente.getNombre() %></option>
        <% } %>
    </select><br><br>

    <label for="idmedico">Seleccione Médico:</label>
    <select id="idmedico" name="idmedico" required>
        <% for (Medico medico : listaMedicos) { %>
        <option value="<%= medico.getId() %>"><%= medico.getNombre() %> - <%= medico.getEspecialidad() %></option>
        <% } %>
    </select><br><br>

    <label for="fecha">Fecha de la Cita:</label>
    <input type="date" id="fecha" name="fecha" required><br><br>

    <input type="submit" value="Buscar Horas Disponibles">
</form>

<%
    // Si ya se han seleccionado médico, paciente y fecha, mostrar el segundo formulario
    if (!mostrarFormulario) {
%>
<form action="Pruebas2.jsp" method="POST">
    <label for="hora">Seleccione Hora:</label>
    <select id="hora" name="hora" required>
        <% for (String hora : horasDisponibles) { %>
        <option value="<%= hora %>"><%= hora %></option>
        <% } %>
    </select><br><br>

    <!-- Pasar los valores de idPaciente, idMedico y fecha -->
    <input type="hidden" name="idpaciente" value="<%= idpacientestr %>">
    <input type="hidden" name="idmedico" value="<%= idmedicostr %>">
    <input type="hidden" name="fecha" value="<%= fechastr %>">

    <input type="submit" value="Guardar Cita">
</form>
<%
    }
%>

<%
    // Procesar el formulario para guardar la cita
    String idpacientestrcrea = request.getParameter("idpaciente");
    String idmedicostrcrea = request.getParameter("idmedico");
    String fechast = request.getParameter("fecha");
    String hora = request.getParameter("hora");

    try {
        if (idpacientestrcrea != null && idmedicostrcrea != null && fechast != null && hora != null) {
            int idpaciente = Integer.parseInt(idpacientestrcrea);
            int idmedico = Integer.parseInt(idmedicostrcrea);
            LocalDate fecha = LocalDate.parse(fechast);

            boolean citaCreada = citaDAO.crearCita(idpaciente, idmedico, fecha, hora, "Descripción de la cita");

            if (citaCreada) {
                System.out.println("Cita creada exitosamente.");
            } else {
                System.out.println("Error al crear la cita.");
            }
        } else {
            System.out.println("Uno o más campos están vacíos.");
        }
    } catch (NumberFormatException e) {
        System.out.println("Error en el formato de los números: " + e.getMessage());
    } catch (Exception e) {
        System.out.println("Error al procesar la solicitud: " + e.getMessage());
    }
%>

</body>
</html>