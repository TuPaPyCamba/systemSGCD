<%--
  Created by IntelliJ IDEA.
  User: maxim
  Date: 31/08/2024
  Time: 05:38 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<form action="login" method="post">
    Usuario: <input type="text" name="usuario" required /><br/>
    Contraseña: <input type="password" name="contraseña" required /><br/>
    <input type="submit" value="Login" />
</form>
<p><%= request.getParameter("error") %></p>
</body>
</html>
