<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="registroPaciente.jsp" method="POST" onsubmit="return validateForm()" style="display: flex; justify-content: center; align-items: center;">
            <div>
                <div>
                    <p style="font-size:15px;">SGCD</p>
                    <h1>INICIO DE SESIÓN PACIENTE</h1>
                </div>
                <div style="margin: 10px;">

                    <label for="usuario" style="display: flex; justify-content: center; margin: 10px;">Usuario</label>
                    <input type="text" name="usuario" id="usuario" placeholder="Nombre de Usuario" style=" border: none; height: 30px; width: 200px;">

                    <label for="constrasena" style="display: flex; justify-content: center; margin: 10px;">Contraseña</label>
                    <input type="password" name="contrasena" id="contrasena" placeholder="******" style="border: none; height: 30px; width: 200px;">

                    <label for="nombre" style="display: flex; justify-content: center; margin: 10px;">Nombre *</label>
                    <input type="text" name="nombre" id="nombre" placeholder="Nombre" style="border: none; height: 30px; width: 200px;">

                    <label for="apellido" style="display: flex; justify-content: center; margin: 10px;">Apellido *</label>
                    <input type="text" name="apellido" id="" placeholder="Apellido" style="border: none; height: 30px; width: 200px;">

                    <label for="telefono" style="display: flex; justify-content: center; margin: 10px;">Telefono *</label>
                    <input type="tel" name="telefono" id="telefono" placeholder="Telefono" style="border: none; height: 30px; width: 200px;">

                    <label for="direccion" style="display: flex; justify-content: center; margin: 10px;">Direccion</label>
                    <input type="text" name="direccion" id="direccion" placeholder="Direccion" style="border: none; height: 30px; width: 200px;">

                </div>
                <div style="display: flex; align-items: center; justify-content: space-evenly; margin-top: 20px;">
                    <button type="submit" style="height: 35px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">Enviar</button>
                    <button type="button" style="height: 35px; width: 120px; background-color: whitesmoke; border: none; color:#626262; cursor: pointer;">
                        <a href="./inicioSesion.jsp">Volver</a>
                    </button>
                </div>
                <div style="display: flex; align-items: center; justify-content: center; margin-top:20px ;">
                    <h4><a href="./inicioSesion.jsp">Dar CLICK aquí para iniciar sesión</a></h4>
                </div>
            </div>
        </form>
    </body>
</html>
