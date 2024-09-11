<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de Sesion</title>
    </head>
    <body>
        <form action="inicioSesion.jsp" method="POST" style="display: flex; justify-content: center; align-items: center;">
            <div>
                <div>
                    <p style="font-size:15px;">SGCD</p>
                    <h1>INICIO DE SESIÓN</h1>
                </div>
                <div style="margin: 10px;">
                    <label for="username" style="display: flex; justify-content: center; margin: 10px;">Usuario</label>
                    <input type="text" name="username" id="username" placeholder="Nombre de Usuario" style=" border: none; height: 30px; width: 200px;">

                    <label for="contrasena" style="display: flex; justify-content: center; margin: 10px;">Contraseña</label>
                    <input type="contrasena" name="contrasena" id="contrasena" placeholder="******" style="border: none; height: 30px; width: 200px;">

                </div>
                <div style="display: flex; align-items: center; justify-content: space-evenly; margin-top: 20px;">
                    <button type="submit" value="Iniciar sesion" style="height: 35px; border-radius: 20px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">Enviar</button>
                    <button type="submit" value="Volver a Index.jsp" style="height: 35px; border-radius: 20px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">
                        <a href="./index.jsp">Volver al menu</a>
                    </button>
                </div>
                <div style="display: flex; align-items: center; justify-content: center; margin-top:20px ;">
                    <h4><a href="./registroPaciente.jsp">Dar CLICK aquí para registrar paciente</a></h4>
                </div>
            </div>
        </form>
    </body>
</html>

