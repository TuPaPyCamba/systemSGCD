<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="com.sgcd.util.CerrarSesion" language="java" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 13/09/2024
  Time: 12:11 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>Gestion de Medico</title>
  <link rel="stylesheet" href="../css/modulos.css">
  <link rel="stylesheet" href="../css/Dashboards.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <title>Admin Home Page</title>
</head>
<body>
    <%
        String idSesionString = String.valueOf(session.getAttribute("usuarioId"));
        String usuarioSesion = (String) session.getAttribute("usuario");
        Integer idSesion = Integer.parseInt(idSesionString);
    %>
    <%
    // Instancias de los DAOs
    CitaDAO citaDAO = new CitaDAO();
    MedicoDAO medicoDAO = new MedicoDAO();

    // Obtener las listas de médicos y pacientes
    List<Medico> listaMedicos = medicoDAO.obtenerMedicos();

    // Variables para manejar la selección y la fecha
    String idmedicostr = request.getParameter("idmedico");
    String fechastr = request.getParameter("fecha");

    List<String> horasDisponibles = new ArrayList<>();
    boolean mostrarFormulario = true;

    if (idmedicostr != null && idSesionString != null && fechastr != null) {

      int idmedico = Integer.parseInt(idmedicostr);
      LocalDate fecha = LocalDate.parse(fechastr);

      // Obtener las horas disponibles para el médico y el día seleccionado
      horasDisponibles = citaDAO.obtenerHorasDisponiblesParaCitas(idmedico, fecha);

      mostrarFormulario = false;

}
    %>
<div class="dashboard">

  <!-- Menú lateral -->
  <div class="sidebar">
    <h2><a href="../index.jsp">Salud Dental</a></h2>
    <a href="Home.jsp" class="menu-item">
      <i class="fas fa-home"></i><span>Home</span>
    </a>
    <a href="Citas.jsp" class="menu-item">
        <i class="fas fa-calendar-check"></i><span>Citas</span>
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
            <form action="Citas.jsp" method="POST">
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

          <form action="Citas.jsp" method="POST">
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

            <!--- Descripcion de la Cita ---->
            <label for="descripcion">Descripcion de la cita</label>
            <textarea id="descripcion" name="descripcion" rows="4" cols="50" required></textarea><br><br>


            <!-- Pasar los valores de idPaciente, idMedico y fecha al siguiente formulario -->
            <input type="hidden" name="idmedico" value="<%= idmedicostr %>">
            <input type="hidden" name="fecha" value="<%= fechastr %>">

            <input type="submit" value="Guardar Cita">
          </form>
          <%
            }
          %>
        </div>
      </div>
    </div>
  </div>
    <%
    // Instancia del DAO

    String idmedicostrcrea = request.getParameter("idmedico");
    String fechast = request.getParameter("fecha");
    String hora = request.getParameter("hora");
    String descripcion = request.getParameter("descripcion");

    try {
        // Verificar que los parámetros no estén vacíos
        if (!idSesionString.isEmpty() && !idmedicostrcrea.isEmpty() && !fechast.isEmpty() && !hora.isEmpty() && !descripcion.isEmpty()) {
            int idmedico = Integer.parseInt(idmedicostrcrea);
            LocalDate fecha = LocalDate.parse(fechast);

            // Crear la cita
            boolean citaCreada = citaDAO.crearCita(idSesion, idmedico, fecha, hora, descripcion);

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