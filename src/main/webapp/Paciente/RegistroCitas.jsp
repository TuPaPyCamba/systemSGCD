<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 13/09/2024
  Time: 02:56 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!--google fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

  <!-- queries css -->
  <link rel="stylesheet" href="../css/Dashboards.css">
  <title>Document</title>
</head>
<body>

<!-- Side Menu -->

<div class="side-menu">
  <div class="brand-name">
    <h1>Salud Dental</h1>
  </div>

  <ul>
    <li><i class="fa-solid fa-house-chimney-user"></i>&nbsp; <a href="index.html">Home</a></li>
    <li><i class="fa-solid fa-table-columns"></i>&nbsp; <a href="#">Dashboard</a></li>
    <li><i class="fa-solid fa-user-tie"></i>&nbsp; <a href="#">Administrador</a></li>
    <li><i class="fa-solid fa-hospital-user"></i>&nbsp; <a href="#">Paciente</a></li>
    <li><i class="fa-solid fa-user-doctor"></i>&nbsp; <a href="#">Médicos</a></li>
    <li><i class="fa-regular fa-calendar-check"></i>&nbsp; <a href="#">Citas</a></li>
    <li><i class="fa-solid fa-hand-holding-hand"></i>&nbsp; <a href="#">Ayuda</a></li>
    <li><i class="fa-solid fa-gears"></i>&nbsp; <a href="#">Ajustes</a></li>
    <li><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp; <a href="#">Salir</a></li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <div class="nav">
      <div class="search">
        <input type="text" placeholder="Buscar">
        <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
      </div>
      <div class="user">
        <a href="#" class="btn">Añadir</a>
        <p>Fernando Camba</p>
        <div class="img-case">
          <img src="/imgs/user.png" alt="">
        </div>
      </div>
    </div>
  </div>
  <div class="function-container">
    <h2>Crear Nueva Cita</h2>

    <%
      // Instancias de los DAOs
      CitaDAO citaDAO = new CitaDAO();
      MedicoDAO medicoDAO = new MedicoDAO();
      PacienteDAO pacienteDAO = new PacienteDAO();

      // Obtener las listas de médicos y pacientes
      List<Medico> listaMedicos = medicoDAO.obtenerMedicos();
      List<Paciente> listaPacientes = pacienteDAO.obtenerPacientes();

      // Variables para manejar la selección y la fecha
      String idmedicostr = request.getParameter("idmedico");
      String idpacientestr = request.getParameter("idpaciente");
      String fechastr = request.getParameter("fecha");

      List<String> horasDisponibles = new ArrayList<>();
      boolean mostrarFormulario = true;

      if (idmedicostr != null && idpacientestr != null && fechastr != null) {

        int idmedico = Integer.parseInt(idmedicostr);
        int idpaciente = Integer.parseInt(idpacientestr);
        LocalDate fecha = LocalDate.parse(fechastr);

        // Obtener las horas disponibles para el médico y el día seleccionado
        horasDisponibles = citaDAO.obtenerHorasDisponiblesParaCitas(idmedico, fecha);

        mostrarFormulario = false;

      }
    %>

    <form action="RegistroCitas.jsp" method="POST">
      <!-- Selección de Paciente -->
      <label for="idpaciente">Seleccione Paciente:</label>
      <select id="idpaciente" name="idpaciente" required>
        <%
          for (Paciente paciente : listaPacientes) {
        %>
        <option value="<%= paciente.getIdPaciente() %>"><%= paciente.getNombre() %></option>
        <%
          }
        %>
      </select><br><br>

      <!-- Selección de Médico -->
      <label for="idmedico">Seleccione Médico:</label>
      <select id="idmedico" name="idmedico" required>
        <%
          for (Medico medico : listaMedicos) {
        %>
        <option value="<%= medico.getId() %>">Nombre del médico: <%= medico.getNombre() %>, Especialidad: <%= medico.getEspecialidad() %></option>
        <%
          }
        %>
      </select><br><br>

      <!-- Selección de Fecha -->
      <label for="fecha">Fecha de la Cita:</label>
      <input type="date" id="fecha" name="fecha" required><br><br>

      <input type="submit" value="Buscar Horas Disponibles">
    </form>

    <%
      System.out.println(fechastr);
      if (!mostrarFormulario) {
    %>
    <form action="RegistroCitas.jsp" method="POST">
      <!-- Hora de la Cita -->
      <label for="hora">Seleccione Hora:</label>
      <select id="hora" name="hora" required>
        <%
          for (String hora : horasDisponibles) {
        %>
        <option value="<%= hora %>"><%= hora %></option>
        <%
          }
        %>
      </select><br><br>

      <!-- Pasar los valores de idPaciente, idMedico y fecha al siguiente formulario -->
      <input type="hidden" name="idpaciente" value="<%= idpacientestr %>">
      <input type="hidden" name="idmedico" value="<%= idmedicostr %>">
      <input type="hidden" name="fecha" value="<%= fechastr %>">

      <input type="submit" value="Guardar Cita">
    </form>
    <%
      }
    %>
    <%
      // Instancia del DAO

      String idpacientestrcrea = request.getParameter("idpaciente");
      String idmedicostrcrea = request.getParameter("idmedico");
      String fechast = request.getParameter("fecha");
      String hora = request.getParameter("hora");

      try {
        // Verificar que los parámetros no estén vacíos
        if (!idpacientestrcrea.isEmpty() && !idmedicostrcrea.isEmpty() && !fechast.isEmpty() && !hora.isEmpty()) {
          int idpaciente = Integer.parseInt(idpacientestrcrea);
          int idmedico = Integer.parseInt(idmedicostrcrea);
          LocalDate fecha = LocalDate.parse(fechast);

          // Crear la cita
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
  </div>
</div>

</body>
</html>