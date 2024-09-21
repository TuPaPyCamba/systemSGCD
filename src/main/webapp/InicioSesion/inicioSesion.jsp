<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.sgcd.util.Autentificacion" %>
<%@ page import="com.sgcd.util.Redireccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./InicioSesion.css">
        <link rel="stylesheet" href="../css/index-navbar.css">
        <title>Salud Dental</title>
        <script>
            function redireccionarUsuario(tipoUsuario) {
                let url;
                switch (tipoUsuario) {
                    case "administradores":
                        url = "/SystemSGCD/Administrador/Home.jsp";
                        break;
                    case "pacientes":
                        url = "/SystemSGCD/Paciente/Home.jsp";
                        break;
                    case "medicos":
                        url = "/SystemSGCD/Medico/Home.jsp";
                        break;
                    default:
                        url = "/SystemSGCD/InicioSesion.jsp";
                        break;
                    }
                    console.log("Redirigiendo a: " + url);
                    window.location.href = url;
                }
        </script>
    </head>
    <body>
        <header class="headerContainer">
            <div class="headerLogo">
                <h1 class="logoTitle"> Salud Dental</h1>
            </div>
            <nav class="headerNav">
                <a href="../index.jsp" class="navLink">Home</a>
                <a href="../index.jsp#about" class="navLink">Quienes Somos</a>
                <a href="../index.jsp#sercies" class="navLink">Servicios</a>
                <a href="../index.jsp#contact" class="navLink">Ubicación y Contacto</a>
                <a href="../index.jsp#doubts" class="navLink">Dudas y comentarios</a>
                <a href="" class="navLink">Iniciar Sesion</a>
            </nav>
        </header>

        <section class="loginSection">
            <div class="sectionForm">
                <h2 class="">Inicio de Sesion</h2>
                <p class="loginDescription">Si ya eres usuario registrado ingresa tus datos</p>

                <form action="../InicioSesion/InicioSesion.jsp" method="POST" class="formBox">
                    <div class="inputBox">
                        <input type="text" name="usuario" id="usuario" class="input" placeholder="Nombre de Usuario" required>
                        <label class="inputLabel">Email</label>
                    </div>

                    <div class="inputBox">
                        <input type="password" name="contrasena" id="contrasena" class="input" placeholder="******" required>
                        <label class="inputLabel">Password</label>
                    </div>

                    <button type="submit" class="formButton">Enviar</button>
                </form>
            </div>
        </section>
        <%
          Autentificacion autentificacion = new Autentificacion();
          Redireccion redireccion = new Redireccion();

          String usuario = request.getParameter("usuario");
          String contrasena = request.getParameter("contrasena");

          System.out.println(usuario);
          System.out.println(contrasena);

          session = request.getSession();

          if (autentificacion.autentificarUsuario(usuario, contrasena, session)) {
            String tipoUsuario = (String) session.getAttribute("tipoUsuario");
            if (tipoUsuario != null) {
        %>
        <script>
    redireccionarUsuario('<%= tipoUsuario %>');
        </script>
        <%
            }
          }
        %>
    </body>
</html>

