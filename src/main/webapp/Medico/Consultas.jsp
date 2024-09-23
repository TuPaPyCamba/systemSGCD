<%@page import="com.sgcd.dao.MedicoDAO"%>
<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <link rel="stylesheet" href="../css/general.css">
        <link rel="stylesheet" href="../css/sidebar.css">
        <link rel="stylesheet" href="../css/table.css">
        <link rel="stylesheet" href="../css/search-bar.css">
        <link rel="stylesheet" href="../css/form.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%
                if (!"medicos".equals(session.getAttribute("tipoUsuario"))) {
                    response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
                }
        %>
        <title>Agendar Nuevas Consultas</title>
    </head>
    <body>
<%
    String idSesionString = null;
    String usuarioSesion = null;
    Object tipoUsuario = session.getAttribute("tipoUsuario");
    Integer idSesion = null;

    if(tipoUsuario != null){
        idSesionString = String.valueOf(session.getAttribute("usuarioId"));
        usuarioSesion = (String) session.getAttribute("usuario");
        idSesion = Integer.parseInt(idSesionString);
    }
%>
<%
    // Instancias de los DAOs
    ConsultaDAO consultaDAO = new ConsultaDAO();
    PacienteDAO pacienteDAO = new PacienteDAO();

    // Obtener las listas de pacientes
    List<Paciente> listaPacientes = pacienteDAO.obtenerPacientes();

    // Variables para manejar la selección y la fecha
    String idmedicostr = idSesionString;
    String idpacientestr = request.getParameter("idpaciente");
    String fechastr = request.getParameter("fecha");

    List<String> horasDisponibles = new ArrayList<>();
    boolean mostrarFormulario = true;

    if (idpacientestr != null && fechastr != null) {

        int idmedico = Integer.parseInt(idmedicostr);
        int idpaciente = Integer.parseInt(idpacientestr);
        LocalDate fecha = LocalDate.parse(fechastr);

        // Obtener las horas disponibles para el paciente y el día seleccionado
        horasDisponibles = consultaDAO.obtenerHorasDisponiblesParaConsultaPorPaciente(idpaciente, fecha);

        mostrarFormulario = false;

    }
%>
<div class="container">
    <!-- Menú lateral -->
    <navbar class="sidebar">
        <h2><a href="../index.jsp">Salud Dental</a></h2>
        <nav>
            <ul>
                <li><a href="Home.jsp" class="menu-item">&#127968; Home</a></li>
                <li><a href="Pacientes.jsp" class="menu-item">&#128100; Pacientes</a></li>
                <li><a href="Agenda.jsp" class="menu-item">&#128197; Agenda</a></li>
                <li><a href="Consultas.jsp" class="menu-item">&#128196; Consultas</a></li>
            </ul>
        </nav>
    </navbar>

    <!-- Contenedor principal -->
    <main class="main-content">
        <!-- Barra de navegación superior -->
        <header class="navbar">
            <div class="user-info">
                <p>Bienvenido, <span id="username"><%= usuarioSesion%></span></p>
                <form action="" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button class="button-red" type="submit">Cerrar Sesión</button>
                </form>
            </div>
        </header>

        <!-- Contenido del dashboard -->
        <section class="dashboard">
            <!-- banner  -->
            <div class="banner">
                <div class="banner-header">
                    <h1>Crear Nueva Consulta</h1>
                </div>
                <div class="banner-line"></div>
            </div>

            <!-- Formulario para seleccionar la fecha -->
            <form action="Consultas.jsp" class="form" method="POST">
                <!-- Selección de Paciente -->
                <div class="form-group">
                    <label for="idpaciente">Seleccione Paciente:</label>
                        <select id="idpaciente" name="idpaciente" required>
                            <%
                                for (Paciente paciente : listaPacientes) {
                            %>
                            <option value="<%= paciente.getId()%>"><%= paciente.getNombre() %>
                            </option>
                            <%
                                }
                            %>
                        </select>
                </div>
                <div class="form-group">
                    <!-- Selección de Fecha -->
                    <label for="fecha">Fecha de la Cita:</label>
                    <input type="date" id="fecha" name="fecha" required>
                </div>
                <button type="submit" class="button-black">Buscar Horas Disponibles</button>
            </form>

                    <%
                        System.out.println(fechastr);
                        if (!mostrarFormulario) {
                    %>

                    <form action="Consultas.jsp" class="form" method="POST">
                        <!-- Hora de la Cita -->
                        <p>Para concluir la consulta ingresa los siguientes datos</p>
                        <div class="form-group">
                            <label for="hora">Seleccione Hora:</label>
                        <select id="hora" name="hora" required>
                            <%
                                for (String hora : horasDisponibles) {
                            %>
                            <option value="<%= hora %>"><%= hora %>
                            </option>
                            <%
                                }
                            %>
                        </select>
                        </div>
                        <!--- Descripcion de la Cita ---->
                        <div class="form-group">
                            <label  for="descripcion">Descripcion de la cita</label>
                            <textarea id="descripcion" name="descripcion" rows="4" cols="50" required></textarea><br><br>


                            <!-- Pasar los valores de idPaciente, idMedico y fecha al siguiente formulario -->
                            <input type="hidden" name="idpaciente" value="<%= idpacientestr %>">
                            <input type="hidden" name="fecha" value="<%= fechastr %>">

                            <button type="submit" class="button-black">Guardar Consulta</button>
                        </div>
                    </form>
                    <%
                        }
                    %>
        </section>
    </main>
</div>

<%
        // Instancia del DAO

        String idpacientestrcrea = request.getParameter("idpaciente");
        String idmedicostrcrea = idSesionString;
        String fechast = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String descripcion = request.getParameter("descripcion");
        String idsucursalstr = new MedicoDAO().obtenerMedico(Integer.parseInt(idSesionString)).getIdsucursal();

        try {
            // Verificar que los parámetros no estén vacíos
            if (idpacientestrcrea != null && fechast != null && hora != null && descripcion != null) {
                int idpaciente = Integer.parseInt(idpacientestrcrea);
                int idmedico = Integer.parseInt(idmedicostrcrea);
                int idsucursal = Integer.parseInt(idsucursalstr);
                LocalDate fecha = LocalDate.parse(fechast);

                // Crear la consulta
                boolean citaCreada = consultaDAO.crearConsulta(idpaciente, idmedico, idsucursal, fecha, hora, descripcion);

                if (citaCreada) {
                    System.out.println("Consulta creada exitosamente.");
                    response.sendRedirect("Consultas.jsp");
                } else {
                    System.out.println("Error al crear la conculta.");
                }
            } else {
                System.out.println("Uno o más campos están vacíos al agendar consulta.");
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