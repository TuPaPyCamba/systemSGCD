
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="Login.java" method="post">
            Usuario: <input type="text" name="usuario" required /><br/>
            Contraseña: <input type="password" name="contrasena" required /><br/>
            <input type="submit" value="Login" />
        </form>
        <p><%= request.getParameter("error") %></p>
    </body>
</html>
