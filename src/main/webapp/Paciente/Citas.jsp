<%@page import="com.sgcd.dao.SucursalDao"%>
<%@ page import="com.sgcd.model.Sucursal" %>
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
        <%
                    if (!"pacientes".equals(session.getAttribute("tipoUsuario"))) {
                        response.sendRedirect("/SystemSGCD/InicioSesion/InicioSesion.jsp");
                    }
        %>
        <title>Agendar Nuevas Citas</title>
    <link rel="stylesheet" href="../css/modulos.css">
    <link rel="stylesheet" href="../css/Dashboards.css">
    <link rel="stylesheet" href="../css/Agenda.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
    SucursalDao sucursalDAO = new SucursalDao();

    // Obtener las listas de médicos y pacientes
    List<Medico> listaMedicos = null;
    List<Sucursal> listaSucursales = sucursalDAO.listaDeSucursales();
    
    // Obtener el id de la sucursal seleccionada
    String id_sucursalstr = request.getParameter("id-sucursal");
    String idsucursalstr = request.getParameter("idsucursal");

    // Variables para manejar la selección y la fecha
    String idmedicostr = request.getParameter("idmedico");
    String idpacientestr = idSesionString;
    String fechastr = request.getParameter("fecha");

    List<String> horasDisponibles = new ArrayList<>();
    
    // Variable para controlar el que mexico aparezca
    String mostrar_medico = request.getParameter("mostrar-medico");
    
    // Variables para manejar los distintos pasos de la creacion
    boolean mostrarMedicos = false;
    boolean mostrarFormulario = false;
    boolean mostrarSucursales = true;
    
    // Si ya se completo el primer paso (Ya hay id de sucursal), mostrar los
    // medicos disponibles
    if (idsucursalstr != null) {
        //TODO: La logica para mostrar el siguiente paso, que es seleccionar medico y fecha
        //listaMedicos = medicoDAO; // TODO: Obtener medicos por id de sucursal
        listaMedicos = medicoDAO.obtenerMedicosPorSucursal(Integer.parseInt(idsucursalstr));
        mostrarMedicos = true;
        mostrarSucursales = false;
    }

    // Si ya se completo el segundo paso (Ya hay id de medico y fecha), mostrar
    // las fechas disponibles
    if (idmedicostr != null && fechastr != null) {

        int idmedico = Integer.parseInt(idmedicostr);
        int idpaciente = Integer.parseInt(idpacientestr);
        LocalDate fecha = LocalDate.parse(fechastr);

        // Obtener las horas disponibles para el médico y el día seleccionado
        horasDisponibles = citaDAO.obtenerHorasDisponiblesParaCitas(idmedico, fecha);

        mostrarFormulario = true;
        mostrarSucursales = false;
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
        <a href="Medicos.jsp" class="menu-item">
            <i class="fas fa-user-md"></i><span>Medicos</span>
        </a>
        <a href="Citas.jsp" class="menu-item">
            <i class="fas fa-calendar-check"></i><span>Citas</span>
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
                <form action="" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit">Cerrar Sesion</button>
                </form>
            </div>
        </div>

        <!-- Contenido del dashboard -->
        <div class="container">
            <div class="g-container">
                <div class="g-banner-container">
                    <div class="g-banner-labelbutton-container">
                        <h2 class="label-banner">Crear Cita</h2>
                    </div>
                </div>
                <% // Muestra las sucursales disponibles
                    if (mostrarSucursales) {
                %>
                <form action="Citas.jsp" method="POST"> <!-- Formulario para seleccionar la sucursal -->
                    <label for="sucursal">Seleccione la sucursal a la que quiere acudir</label>
                    <select id="select-sucursales" name="idsucursal" required>
                        <%
                            for (Sucursal sucursal : listaSucursales) {
                        %>
                            <option value="<%= sucursal.getIdsucursal()%>">Nombre: <%= sucursal.getNombre() %>,
                                Direccion: <%= sucursal.getDireccion()%>
                            </option>
                        <%
                            }
                        %>
                    </select>
                    <input type="submit" value="Buscar medicos" name="buscar-medicos" />
                </form>
                <%
                }
                %>
                <% // Muestra los medicos disponibles por sucursal
                        if (mostrarMedicos) {
                    %>
                    <h2>Sucursal seleccionada: <%= sucursalDAO %></h2>
                <form action="Citas.jsp" method="POST">
                    <input type="hidden" value="<%= id_sucursalstr %>" name="id-sucursal">
                    <input type="hidden" value="false" name="mostrar-medico">
                    <!-- Selección de Médico -->
                    <div class="seleccionarMedico">
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
                        <div class="seleccionarMedico">
                            <div class="">
                            <label for="fecha">Fecha de la Cita:</label>
                            <input type="date" id="fecha" name="fecha" required>
                        </div>
                        <button type="submit">Buscar Horas Disponibles</button>
                    </div>
                </form>
                <%
                    }
                %>

                    
                    <% // Muestra los medicos disponibles
                        System.out.println(fechastr);
                        if (mostrarFormulario) {
                    %>
                    <h2>Sucursal seleccionada: <%= sucursalDAO %></h2>
                    <h2>Medico seleccionado: <%= medicoDAO.findById(Integer.parseInt(idmedicostr)).getNombre() %></h2>
                    <form action="Citas.jsp" method="POST">
                        <!-- Hora de la Cita -->
                        <p>Para concluir la cita ingresa los siguientes datos</p>
                        <div class="seleccionarMedico">
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

                        <!--- Descripcion de la Cita ---->
                        <label for="descripcion">Descripcion de la cita</label>
                        <textarea id="descripcion" name="descripcion" rows="4" cols="50" required></textarea>


                        <!-- Pasar los valores de idPaciente, idMedico y fecha al siguiente formulario -->
                        <input type="hidden" name="idmedico" value="<%= idmedicostr %>">
                        <input type="hidden" name="fecha" value="<%= fechastr %>">

                        <button type="submit">Guardar Cita</button>
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