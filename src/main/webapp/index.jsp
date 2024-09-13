<html>
    <head>
        <%
            if (session.getAttribute("tipoUsuario")!= "paciente" || session.getAttribute("tipoUsuario")!= "medico" || session.getAttribute("tipoUsuario")!= "administrador"){
                response.sendRedirect("/SystemSGCD/inicioSesion.jsp");
            }
        %>
    </head>
    <body>
<h2>Hello World!</h2>
</body>
</html>
