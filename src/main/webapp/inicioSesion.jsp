<%-- 
    Document   : inicioSesion
    Created on : Sep 9, 2024, 8:10:46 AM
    Author     : jh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de Sesion</title>
    </head>
    <body>
        <div style="display: flex; justify-content: center; align-items: center;">
            <div>
                <div>
                    <p style="font-size:15px;">SGCD</p>
                    <h1>INICIO DE SESIÓN</h1>
                </div>
                <div style="margin: 10px;">
                    <label for="username" style="display: flex; justify-content: center; margin: 10px;">Usuario</label>
                    <input type="text" name="username" id="username" placeholder="Nombre de Usuario" style=" border: none; height: 30px; width: 200px;">
                    <label for="password" style="display: flex; justify-content: center; margin: 10px;">Contraseña</label>
                    <input type="password" name="password" id="password" placeholder="******" style="border: none; height: 30px; width: 200px;">
                </div>
            </div>
        </div>
    </body>
</html>
