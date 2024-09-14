<%@ page import="com.sgcd.model.Consulta" %>
<%@ page import="com.sgcd.dao.ConsultaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 13/09/2024
  Time: 12:11 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>Gestion de Consultas</title>
  <link rel="stylesheet" href="../css/modulos.css">
  <link rel="stylesheet" href="../css/Dashboards.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <title>Admin Home Page</title>
</head>
<body>
<div class="dashboard">

  <!-- Menú lateral -->
  <div class="sidebar">
    <h2><a href="../index.jsp">Salud Dental</a></h2>
    <a href="Home.jsp" class="menu-item">
      <i class="fas fa-home"></i><span>Home</span>
    </a>
    <a href="GestionPacientes.jsp" class="menu-item">
      <i class="fas fa-user-injured"></i><span>Pacientes</span>
    </a>
    <a href="GestionMedicos.jsp" class="menu-item">
      <i class="fas fa-user-md"></i><span>Medicos</span>
    </a>
    <a href="GestionCitas.jsp" class="menu-item">
      <i class="fas fa-calendar-check"></i><span>Citas</span>
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
          <!-- banner de Consulta -->
          <div class="g-banner-container">
            <div class="g-banner-labelbutton-container">
              <h2 class="label-banner">Lista de Consultas</h2>
            </div>
            <div class="blue-line"></div>
          </div>
          <!-- Tabla de registros -->
          <table class="table">
            <thead>
            <tr>
              <th>ID</th>
              <th>Fecha</th>
              <th>Hora</th>
              <th>Descripcion</th>
              <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
              List<Consulta> consultas = null;
              ConsultaDAO consultaDAO = new ConsultaDAO();

              try {
                consultas = consultaDAO.findAllConsultas();
              } catch (SQLException ex) {
                throw new RuntimeException(ex);
              }

              if (consultas != null && !consultas.isEmpty()) {
                for(Consulta consulta : consultas) {
            %>
            <tr>
              <td><%= consulta.getId() %></td>
              <td><%= consulta.getFecha()%></td>
              <td><%= consulta.getHora()%></td>
              <td><%= consulta.getDescripcion()%></td>
              <td>
                <form action="Consultas.jsp" method="post" style="display: inline">
                  <input type="hidden" name="id" value="<%= consulta.getId() %>">
                  <button type="submit" class="btn-delete" onclick="return confirm('¿Estás seguro de que quieres eliminar a este Medico?');">Eliminar</button>
                </form>
                <button class="btn-edit" onclick="toggleForm(this)">Editar</button>
              </td>
            </tr>
            <%
              }
            } else {
            %>
            <tr>
              <td colspan="5">No se encontraron consultas.</td>
            </tr>
            <%
              }
            %>
            <!-- Logico de eliminacion -->
            <%
              // Manejo de la eliminación de una consulta
              String idParam = request.getParameter("id");
              if (idParam != null && !idParam.isEmpty()){
                int id = Integer.parseInt(idParam);
                try {
                  int registrosEliminados = consultaDAO.delete(id);
                  response.sendRedirect("Consultas.jsp");
                } catch (SQLException ex) {
                  throw new RuntimeException(ex);
                }
              }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</body>
</html>