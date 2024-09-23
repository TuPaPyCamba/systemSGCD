<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.dao.PacienteDAO" %>
<%@ page import="com.sgcd.dao.CitaDAO" %>
<%@ page import="com.sgcd.model.Paciente" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sgcd.util.CerrarSesion" %>
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
        <link rel="stylesheet" href="../css/general.css">
        <link rel="stylesheet" href="../css/sidebar.css">
        <link rel="stylesheet" href="../css/table.css">
        <link rel="stylesheet" href="../css/search-bar.css">
        <link rel="stylesheet" href="../css/form.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%
                    if (!"pacientes".equals(session.getAttribute("tipoUsuario"))) {
                        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
                    }
        %>
        <title>Agendar Nuevas Citas</title>
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
    CitaDAO citaDAO = new CitaDAO();
    MedicoDAO medicoDAO = new MedicoDAO();

    // Obtener las listas de médicos y pacientes
    List<Medico> listaMedicos = medicoDAO.obtenerMedicos();

    // Variables para manejar la selección y la fecha
    String idmedicostr = request.getParameter("idmedico");
    String idpacientestr = idSesionString;
    String fechastr = request.getParameter("fecha");

    List<String> horasDisponibles = new ArrayList<>();
    boolean mostrarFormulario = true;

    if (idmedicostr != null && fechastr != null) {

        int idmedico = Integer.parseInt(idmedicostr);
        int idpaciente = Integer.parseInt(idpacientestr);
        LocalDate fecha = LocalDate.parse(fechastr);

        // Obtener las horas disponibles para el médico y el día seleccionado
        horasDisponibles = citaDAO.obtenerHorasDisponiblesParaCitas(idmedico, fecha);

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
                <li><a href="Medicos.jsp" class="menu-item">&#128104;&#8205;&#9877;&#65039; Medicos</a></li>
                <li><a href="Citas.jsp" class="menu-item">&#128197; Citas</a></li>
                <li><a href="Agenda.jsp" class="menu-item">&#128197; Agenda</a></li>
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
            <form action="Citas.jsp" class="form" method="POST">
                <!-- Selección de Médico -->
                <div class="form-group">
                    <label for="idmedico">Seleccione Médico:</label>
                        <select id="idmedico" name="idmedico" required>
                            <%
                                for (Medico medico : listaMedicos) {
                            %>
                            <option value="<%= medico.getId() %>">Nombre: <%= medico.getNombre() %>,
                                Especialidad: <%= medico.getEspecialidad() %>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                        <div class="form-group">
                            <label for="fecha">Fecha de la Cita:</label>
                            <input type="date" id="fecha" name="fecha" required>
                        </div>
                        <button type="submit" class="button-black">Buscar Horas Disponibles</button>
            </form>

                    <%
                        System.out.println(fechastr);
                        if (!mostrarFormulario) {
                    %>

                    <form action="Citas.jsp" class="form" method="POST">
                        <!-- Hora de la Cita -->
                        <p>Para concluir la cita ingresa los siguientes datos</p>
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
                        <div class="form-group">
                            <!--- Descripcion de la Cita ---->
                            <label for="descripcion">Descripcion de la cita</label>
                            <textarea id="descripcion" name="descripcion" rows="4" cols="50" required></textarea>


                            <!-- Pasar los valores de idPaciente, idMedico y fecha al siguiente formulario -->
                            <input type="hidden" name="idmedico" value="<%= idmedicostr %>">
                            <input type="hidden" name="fecha" value="<%= fechastr %>">
                        </div>
                        <button class="button-black" type="submit">Guardar Cita</button>
                    </form>
                    <%
                        }
                    %>
        </section>
    </main>
</div>
        <%
        // Instancia del DAO

        String idpacientestrcrea = idSesionString;
        String idmedicostrcrea = request.getParameter("idmedico");
        String fechast = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String descripcion = request.getParameter("descripcion");
        try {
            // Verificar que los parámetros no estén vacíos
            if (!idmedicostrcrea.isEmpty() && !fechast.isEmpty() && !hora.isEmpty() && !descripcion.isEmpty()) {
                int idpaciente = Integer.parseInt(idpacientestrcrea);
                int idmedico = Integer.parseInt(idmedicostrcrea);
                LocalDate fecha = LocalDate.parse(fechast);

                // Crear la cita
                boolean citaCreada = citaDAO.crearCita(idpaciente, idmedico, fecha, hora, descripcion);

                if (citaCreada) {
                    System.out.println("Cita creada exitosamente.");
                    response.sendRedirect("Citas.jsp");
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