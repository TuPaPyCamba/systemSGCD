<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sgcd.model.Cita" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="com.sgcd.model.Consulta" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Gestion de Citas</title>
  <link rel="stylesheet" href="../css/modulos.css">
  <link rel="stylesheet" href="../css/Dashboards.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<div class="dashboard">
  <!-- Menú lateral -->
  <div class="sidebar">
    <h2><a href="../index.jsp">Salud Dental</a></h2>
    <a href="Home.jsp" class="menu-item">
      <i class="fas fa-home"></i><span>Home</span>
    </a>
    <a href="Agenda.jsp" class="menu-item">
      <i class="fas fa-calendar-alt"></i><span>Agenda</span>
    </a>
    <a href="Pacientes.jsp" class="menu-item">
      <i class="fas fa-user-injured"></i><span>Pacientes</span>
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
        <p>Bienvenido, Usuario</p>
        <button>Logout</button>
      </div>
    </div>

    <!-- Contenido del dashboard -->
    <div class="content">
      <div class="container">
        <div class="g-container">
          <h1 class="text-2xl font-bold mb-4">Buscar Citas del Médico</h1>

          <!-- Formulario para seleccionar la fecha -->
          <form action="Agenda.jsp" method="get" class="mb-4">
            <div class="mb-4">
              <label for="fecha" class="block text-gray-700">Fecha:</label>
              <input type="date" id="fecha" name="fecha" required class="border px-3 py-2 rounded">
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Buscar</button>
          </form>

          <%
            // Obtener parámetros de la solicitud
            String idMedicoParam = request.getParameter("idmedico");
            String fechaParam = request.getParameter("fecha");

            if (idMedicoParam != null && fechaParam != null) {
              int idMedico = Integer.parseInt(idMedicoParam);
              LocalDate fecha = LocalDate.parse(fechaParam);

              // Crear instancia de CitaDAO
              CitaDAO citaDAO = new CitaDAO();
              List<Cita> citas = citaDAO.obtenerTodasCitas(idMedico, fecha);

              if (citas != null && !citas.isEmpty()) {
          %>
          <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
            <thead>
            <tr class="bg-gray-200">
              <th class="px-4 py-2 border-b">ID</th>
              <th class="px-4 py-2 border-b">Medico ID</th>
              <th class="px-4 py-2 border-b">Paciente ID</th>
              <th class="px-4 py-2 border-b">Fecha</th>
              <th class="px-4 py-2 border-b">Hora</th>
              <th class="px-4 py-2 border-b">Descripción</th>
              <th class="px-4 py-2 border-b">Eliminar</th>
            </tr>
            </thead>
            <tbody>
            <% for (Cita cita : citas) { %>
            <tr>
              <td class="px-4 py-2 border-b"><%= cita.getId() %></td>
              <td class="px-4 py-2 border-b"><%= cita.getIdMedico() %></td>
              <td class="px-4 py-2 border-b"><%= cita.getIdPaciente() %></td>
              <td class="px-4 py-2 border-b"><%= cita.getFecha() %></td>
              <td class="px-4 py-2 border-b"><%= cita.getHora() %></td>
              <td class="px-4 py-2 border-b"><%= cita.getDescripcion() %></td>
              <td class="px-4 py-2 border-b">
                <form action="Agenda.jsp" method="post" style="display:inline;">
                  <input type="hidden" name="id" value="<%= cita.getId() %>">
                  <input type="hidden" name="idmedico" value="<%= cita.getIdMedico() %>">
                  <input type="hidden" name="fecha" value="<%= cita.getFecha() %>">
                  <button type="submit" name="action" value="delete" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Eliminar</button>
                </form>
              </td>
            </tr>
            <% } %>
            </tbody>
          </table>
          <% } else { %>
          <p class="mt-4 text-red-500">No se encontraron citas para el médico y la fecha seleccionados.</p>
          <% } %>
          <% } else { %>
          <p class="mt-4 text-red-500">Por favor, seleccione un médico y una fecha para buscar.</p>
          <% } %>

          <%
            // Lógica para eliminar cita
            String action = request.getParameter("action");
            String idParam = request.getParameter("id");

            if ("delete".equals(action) && idParam != null) {
              int id = Integer.parseInt(idParam);

              try {
                CitaDAO citaDAO = new CitaDAO();
                int registros = citaDAO.delete(id);

                if (registros > 0) {
                  System.out.println("<p class='mt-4 text-green-500'>Cita eliminada con éxito.</p>");
                } else {
                  System.out.println("<p class='mt-4 text-red-500'>Error al eliminar la cita.</p>");
                }
              } catch (SQLException e) {
                System.out.println("<p class='mt-4 text-red-500'>Error en la base de datos: " + e.getMessage() + "</p>");
              }
            }
          %>
          <h1 class="text-2xl font-bold mb-4">Buscar Consultas del Médico</h1>

          <!-- Formulario para seleccionar la fecha -->
          <form action="Agenda.jsp" method="get" class="mb-4">
            <div class="mb-4">
              <label for="fecha" class="block text-gray-700">Fecha:</label>
              <input type="date" id="fechaconsulta" name="fechaconsulta" required class="border px-3 py-2 rounded">
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Buscar</button>
          </form>

          <%
            // Obtener parámetros de la solicitud
            String idMedicoParamt = request.getParameter("idmedico");
            String fechaParamr = request.getParameter("fechaconsulta");

            if (idMedicoParamt != null && fechaParamr != null) {
              int idMedico = Integer.parseInt(idMedicoParamt);
              LocalDate fechaconsulta = LocalDate.parse(fechaParamr);

              // Crear instancia de ConsultaDAO
              ConsultaDAO consultaDAO = new ConsultaDAO();
              List<Consulta> consultas = consultaDAO.obtenerTodasConsultas(idMedico, fechaconsulta);

              if (consultas != null && !consultas.isEmpty()) {
          %>
          <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
            <thead>
            <tr class="bg-gray-200">
              <th class="px-4 py-2 border-b">ID</th>
              <th class="px-4 py-2 border-b">Médico ID</th>
              <th class="px-4 py-2 border-b">Paciente ID</th>
              <th class="px-4 py-2 border-b">Fecha</th>
              <th class="px-4 py-2 border-b">Hora</th>
              <th class="px-4 py-2 border-b">Descripción</th>
              <th class="px-4 py-2 border-b">Eliminar</th>
            </tr>
            </thead>
            <tbody>
            <% for (Consulta consulta : consultas) { %>
            <tr>
              <td class="px-4 py-2 border-b"><%= consulta.getId() %></td>
              <td class="px-4 py-2 border-b"><%= consulta.getIdMedico() %></td>
              <td class="px-4 py-2 border-b"><%= consulta.getIdPaciente() %></td>
              <td class="px-4 py-2 border-b"><%= consulta.getFecha() %></td>
              <td class="px-4 py-2 border-b"><%= consulta.getHora() %></td>
              <td class="px-4 py-2 border-b"><%= consulta.getDescripcion() %></td>
              <td class="px-4 py-2 border-b">
                <form action="Agenda.jsp" method="post" style="display:inline;">
                  <input type="hidden" name="id" value="<%= consulta.getId() %>">
                  <input type="hidden" name="idmedico" value="<%= consulta.getIdMedico() %>">
                  <input type="hidden" name="fecha" value="<%= consulta.getFecha() %>">
                  <button type="submit" name="actioneliminar" value="delete" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Eliminar</button>
                </form>
              </td>
            </tr>
            <% } %>
            </tbody>
          </table>
          <% } else { %>
          <p class="mt-4 text-red-500">No se encontraron consultas para el médico y la fecha seleccionados.</p>
          <% } %>
          <% } else { %>
          <p class="mt-4 text-red-500">Por favor, seleccione un médico y una fecha para buscar.</p>
          <% } %>

          <%
            // Lógica para eliminar consulta
            String actioneliminar = request.getParameter("actioneliminar");
            String idParameliminar = request.getParameter("id");

            if ("delete".equals(actioneliminar) && idParameliminar != null) {
              int id = Integer.parseInt(idParameliminar);

              try {
                ConsultaDAO consultaDAO = new ConsultaDAO();
                int registros = consultaDAO.delete(id);

                if (registros > 0) {
                  System.out.println("<p class='mt-4 text-green-500'>Consulta eliminada con éxito.</p>");
                } else {
                  System.out.println("<p class='mt-4 text-red-500'>Error al eliminar la consulta.</p>");
                }
              } catch (SQLException e) {
                System.out.println("<p class='mt-4 text-red-500'>Error en la base de datos: " + e.getMessage() + "</p>");
              }
            }
          %>
        </div>
      </div>
    </div>
  </div>
</body>
</html>