<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.sgcd.util.Autentificacion" %>
<%@ page import="com.sgcd.util.Redireccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de Sesion</title>
        <script>
            function redireccionarUsuario(tipoUsuario) {
                let url;
                switch (tipoUsuario) {
                    case "administradores":
                        url = "/SystemSGCD/index.jsp";
                        break;
                    case "pacientes":
                        url = "/SystemSGCD/index.jsp";
                        break;
                    case "medicos":
                        url = "/SystemSGCD/index.jsp";
                        break;
                    default:
                        url = "/SystemSGCD/inicioSesion.jsp";
                        break;
                    }
                    window.location.href = url;
                }
        </script>
    </head>
    <body>
        <%
            String ide = String.valueOf(session.getAttribute("usuarioId"));
            String typeuser = (String) session.getAttribute("tipoUsuario");
            String user = (String) session.getAttribute("usuario");
        %>
        <p>tipo usuario: <%= typeuser %>, usuario: <%= user %>, id: <%= ide %></p>
        <form action="inicioSesion.jsp" method="POST" style="display: flex; justify-content: center; align-items: center;">
            <div>
                <div>
                    <p style="font-size:15px;">SGCD</p>
                    <h1>INICIO DE SESIÓN</h1>
                </div>
                <div style="margin: 10px;">
                    <label for="usuario" style="display: flex; justify-content: center; margin: 10px;" >Usuario</label>
                    <input type="text" name="usuario" id="usuario" placeholder="Nombre de Usuario" style=" border: none; height: 30px; width: 200px;" required>

                    <label for="contrasena" style="display: flex; justify-content: center; margin: 10px;">Contraseña</label>
                    <input type="password" name="contrasena" id="contrasena" placeholder="******" style="border: none; height: 30px; width: 200px;" required>

                </div>
                <div style="display: flex; align-items: center; justify-content: space-evenly; margin-top: 20px;">
                    <button type="submit" value="Iniciar sesion" style="height: 35px; border-radius: 20px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">Enviar</button>
                    <button value="Volver a Index.jsp" style="height: 35px; border-radius: 20px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">
                        <a href="./index.jsp">Volver al menu</a>
                    </button>
                </div>
                <div style="display: flex; align-items: center; justify-content: center; margin-top:20px ;">
                    <h4><a href="./registroPaciente.jsp">Dar CLICK aquí para registrar paciente</a></h4>
                </div>
            </div>
        </form>
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

