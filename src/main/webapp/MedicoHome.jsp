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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--google fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"

    <!-- queries css -->
    <link rel="stylesheet" href="/css/queries.css">
    <title>Document</title>
</head>
<body>

<!-- Side Menu -->

<div class="side-menu">
    <div class="brand-name">
        <h1>Salud Dental</h1>
    </div>

    <ul>
        <li><i class="fa-solid fa-house-chimney-user"></i>&nbsp; <a href="index.html">Home</a></li>
        <li><i class="fa-solid fa-table-columns"></i>&nbsp; <a href="#">Dashboard</a></li>
        <li><i class="fa-solid fa-user-tie"></i>&nbsp; <a href="#">Administrador</a></li>
        <li><i class="fa-solid fa-hospital-user"></i>&nbsp; <a href="#">Paciente</a></li>
        <li><i class="fa-solid fa-user-doctor"></i>&nbsp; <a href="#">Médicos</a></li>
        <li><i class="fa-regular fa-calendar-check"></i>&nbsp; <a href="#">Citas</a></li>
        <li><i class="fa-solid fa-hand-holding-hand"></i>&nbsp; <a href="#">Ayuda</a></li>
        <li><i class="fa-solid fa-gears"></i>&nbsp; <a href="#">Ajustes</a></li>
        <li><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp; <a href="#">Salir</a></li>
    </ul>
</div>

<div class="container">
    <div class="header">
        <div class="nav">
            <div class="search">
                <input type="text" placeholder="Buscar">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
            <div class="user">
                <a href="#" class="btn">Añadir</a>
                <p>Fernando Camba</p>
                <div class="img-case">
                    <img src="/imgs/user.png" alt="">
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>