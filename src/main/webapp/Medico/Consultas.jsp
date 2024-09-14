<%@ page import="com.sgcd.dao.ConsultaDAO" %><%--
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
  // Instancias de los DAOs
  ConsultaDAO citaDAO = new ConsultaDAO();
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

      </div>
    </div>
  </div>
    <%
    // Instancia del DAO

    String idpacientestrcrea = request.getParameter("idpaciente");
    String idmedicostrcrea = request.getParameter("idmedico");
    String fechast = request.getParameter("fecha");
    String hora = request.getParameter("hora");
    String descripcion = request.getParameter("descripcion");

    try {
        // Verificar que los parámetros no estén vacíos
        if (!idpacientestrcrea.isEmpty() && !idmedicostrcrea.isEmpty() && !fechast.isEmpty() && !hora.isEmpty() && !descripcion.isEmpty()) {
            int idpaciente = Integer.parseInt(idpacientestrcrea);
            int idmedico = Integer.parseInt(idmedicostrcrea);
            LocalDate fecha = LocalDate.parse(fechast);

            // Crear la cita
            boolean citaCreada = citaDAO.crearCita(idpaciente, idmedico, fecha, hora, descripcion);

            if (citaCreada) {
                System.out.println("Cita creada exitosamente.");
                response.sendRedirect("Pruebas.jsp");
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