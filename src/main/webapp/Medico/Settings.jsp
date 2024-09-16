<%@ page import="com.sgcd.dao.MedicoDAO" %>
<%@ page import="com.sgcd.model.Medico" %>
<%@ page import="java.sql.SQLException" %><%--
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
        <div>
          <div class="g-container">
            <h1 class="text-2xl font-bold mb-4">Editar Médico</h1>

            <%
              // Obtener el ID del médico desde los parámetros de la solicitud
              String idParam = request.getParameter("id");
              if (idParam != null) {
                int idMedico = Integer.parseInt(idParam);

                try {
                  // Crear una instancia de MedicoDAO y obtener el médico por ID
                  MedicoDAO medicoDAO = new MedicoDAO();
                  medico = 1;

                  if (medico != null) {
            %>
            <!-- Formulario para editar información del médico -->
            <form action="actualizarMedico.jsp" method="post" class="mb-4">
              <input type="hidden" name="id" value="<%= medico.getId() %>">
              <div class="mb-4">
                <label for="usuario" class="block text-gray-700">Usuario:</label>
                <input type="text" id="usuario" name="usuario" value="<%= medico.getUsuario() %>" required class="border px-3 py-2 rounded">
              </div>
              <div class="mb-4">
                <label for="contrasena" class="block text-gray-700">Contraseña:</label>
                <input type="password" id="contrasena" name="contrasena" value="<%= medico.getContrasena() %>" required class="border px-3 py-2 rounded">
              </div>
              <div class="mb-4">
                <label for="nombre" class="block text-gray-700">Nombre:</label>
                <input type="text" id="nombre" name="nombre" value="<%= medico.getNombre() %>" required class="border px-3 py-2 rounded">
              </div>
              <div class="mb-4">
                <label for="apellidos" class="block text-gray-700">Apellidos:</label>
                <input type="text" id="apellidos" name="apellidos" value="<%= medico.getApellidos() %>" required class="border px-3 py-2 rounded">
              </div>
              <div class="mb-4">
                <label for="especialidad" class="block text-gray-700">Especialidad:</label>
                <input type="text" id="especialidad" name="especialidad" value="<%= medico.getEspecialidad() %>" required class="border px-3 py-2 rounded">
              </div>
              <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Actualizar</button>
            </form>
            <% } else { %>
            <p class="mt-4 text-red-500">No se encontró el médico con el ID especificado.</p>
            <% } %>

            <a href="Pacientes.jsp" class="mt-4 inline-block bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Volver a Pacientes</a>
          </div>
          <%
            int id = Integer.parseInt(request.getParameter("id"));
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            String especialidad = request.getParameter("especialidad");

            Medico medico = new Medico();
            medico.setId(id);
            medico.setUsuario(usuario);
            medico.setContrasena(contrasena);
            medico.setNombre(nombre);
            medico.setApellidos(apellidos);
            medico.setEspecialidad(especialidad);

            MedicoDAO medicoDAO = new MedicoDAO();
            try {
              int registros = medicoDAO.actualizar(medico);

              if (registros > 0) {
                response.sendRedirect("Pacientes.jsp?msg=Medico actualizado con éxito.");
              } else {
                request.setAttribute("error", "No se actualizó ningún registro.");
                request.getRequestDispatcher("editarMedico.jsp?id=" + id).forward(request, response);
              }
            } catch (SQLException e) {
              e.printStackTrace();
              request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
              request.getRequestDispatcher("editarMedico.jsp?id=" + id).forward(request, response);
            }
          }
        %>
        </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>