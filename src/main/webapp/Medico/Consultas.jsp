<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %><%--
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
        String idSesionString = null;
        String usuarioSesion = null;
        Object tipoUsuario = session.getAttribute("tipoUsuario");

    if(tipoUsuario != null){
        idSesionString = String.valueOf(session.getAttribute("usuarioId"));
        usuarioSesion = (String) session.getAttribute("usuario");
        Integer idSesion = Integer.parseInt(idSesionString);
    }
    %>
    <%
  // Instancias de los DAOs
  ConsultaDAO consultaDAO = new ConsultaDAO();
  PacienteDAO pacienteDAO = new PacienteDAO();

  // Obtener las listas de pacientes
  List<Paciente> listaPacientes = pacienteDAO.obtenerPacientes();

  // Variables para manejar la selección y la fecha
  String idpacientestr = request.getParameter("idpaciente");
  String fechastr = request.getParameter("fecha");

  List<String> horasDisponibles = new ArrayList<>();
  boolean mostrarFormulario = true;

  if (idSesion != null && idpacientestr != null && fechastr != null) {

    int idpaciente = Integer.parseInt(idpacientestr);
    LocalDate fecha = LocalDate.parse(fechastr);

    // Obtener las horas disponibles para el paciente y el día seleccionado
    horasDisponibles = consultaDAO.obtenerHorasDisponiblesParaConsultaPorPaciente(idSesion, fecha);

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
          <p>Bienvenido, <%= usuarioSesion%></p>
          <button>Logout</button>
      </div>
    </div>

    <!-- Contenido del dashboard -->
    <div class="container">
        <div class="g-container">
            <div class="g-banner-container">
                <div class="g-banner-labelbutton-container">
                    <h2 class="label-banner">Crear Consultas</h2>
                </div>
            </div>
            <form action="Consultas.jsp" class="search-form" method="POST">
                <!-- Selección de Paciente -->
                <div class="consultaSection">
                    <div class="buscarCita">
                        <label for="idpaciente">Seleccione Paciente:</label>
                        <select id="idpaciente" name="idpaciente" required>
                            <%
                              for (Paciente paciente : listaPacientes) {
                            %>
                            <option value="<%= paciente.getIdPaciente() %>"><%= paciente.getNombre() %></option>
                            <%
                              }
                            %>
                        </select>
                        <!-- Selección de Fecha -->
                        <label for="fecha">Seleccione Fecha de la Cita:</label>
                        <input type="date" id="fecha" name="fecha" required>
                    </div>
                    <button type="submit">Buscar Horas Disponibles</button>
                </div>
            </form>

          <%
            System.out.println(fechastr);
            if (!mostrarFormulario) {
          %>

          <form action="Consultas.jsp" method="POST" class="search-form">
              <!-- Hora de la Cita -->
              <div>
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
                  <input type="hidden" name="idpaciente" value="<%= idpacientestr %>">
                  <input type="hidden" name="fecha" value="<%= fechastr %>">

                  <button type="submit" >Guardar Cita</button>
              </div>
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

    String idpacientestrcrea = request.getParameter("idpaciente");
    String fechast = request.getParameter("fecha");
    String hora = request.getParameter("hora");
    String descripcion = request.getParameter("descripcion");

    try {
        // Verificar que los parámetros no estén vacíos
        if (!idpacientestrcrea.isEmpty() && !idSesionString.isEmpty() && !fechast.isEmpty() && !hora.isEmpty() && !descripcion.isEmpty()) {
            int idpaciente = Integer.parseInt(idpacientestrcrea);
            LocalDate fecha = LocalDate.parse(fechast);

            // Crear la consulta
            boolean citaCreada = consultaDAO.crearConsulta(idpaciente, idSesion, fecha, hora, descripcion);

            if (citaCreada) {
                System.out.println("Consulta creada exitosamente.");
                response.sendRedirect("Pruebas.jsp");
            } else {
                System.out.println("Error al crear la conculta.");
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