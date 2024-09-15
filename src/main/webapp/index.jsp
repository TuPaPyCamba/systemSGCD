<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/index.css">
    <link rel="stylesheet" href="./css/navbarStyles.css">
    <!--Font Awesome-->
    <link rel="stylesheet" href="./css/fontawesome.min.css">

    <title>Salud Dental</title>
       <%
//        if (session.getAttribute("tipoUsuario")!= "paciente" || session.getAttribute("tipoUsuario")!= "medico" || session.getAttribute("tipoUsuario")!= "administrador"){
//            response.sendRedirect("/SystemSGCD/inicioSesion.jsp");
//        }
       %>
</head>

<body>
    <div class="headerContainer">
        <div class="headerLogo">
            <h1 class="logoTitle"> Salud Dental</h1>
        </div>
        <nav class="headerNav">
            <a href="#home" class="navLink">Home</a>
            <a href="#about" class="navLink">Quienes Somos</a>
            <a href="#sercies" class="navLink">Servicios</a>
            <a href="#contact" class="navLink">Ubicación y Contacto</a>
            <a href="#doubts" class="navLink">Dudas y comentarios</a>
            <a href="./InicioSesion/inicioSesion.jsp" class="navLink">Iniciar Sesion</a>
            <a href="queries.html" class="navLink">Consultas</a>
        </nav>
        <a href="" class="navLink">Citas</a>
    </div>
    <!-- Home Section -->

<section class="home" id="home">
    <div class="container">

        <div class="box">
            <div class="content">
                <h1>Haz que tu sonrisa sea bella</h1>
                <h2>Nosotros cuidamos la salud de tus dientes</h2>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.
                    Laboriosam eos quos </p>
                <span>Dr. Alejandro Martínez</span>
                <br>
                <a href="" class="btn">Saber más</a>
            </div>
        </div>
    </div>
</section>

<!-- Quienes somos Section -->

<section class="about" id="about">

    <div class="heading">
        <h2>Quienes somos</h2>
    </div>

    <div class="container">
        <div class="image">
            <img src="./img/Banner.jpg" alt="">
        </div>
        <div class="content">
            <h1>Por qué preferirnos?</h1>
            <h2>Somos expertos</h2>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Adipisci quaerat
                consequatur illo? Dolore quam temporibus hic similique sunt. Quis quas
                molestias aperiam, eum officiis veniam ullam! Repellendus totam
                quisquam tempore.</p>
            <p class="p">Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus molestias
                similique illo laborum voluptatibus deleniti porro totam at sint.</p>

            <a href="" class="btn">Saber más</a>
        </div>
    </div>
</section>

<!--== Services Section ==-->

<section class="services" id="sercies">

    <div class="heading">
        <h2>Servicios</h2>
    </div>

    <div class="container">

        <div class="box">
            <div class="image">
                <img src="./img/Service-2.jpg" alt="">
            </div>
            <div class="content">
                <h1>Salud Oral</h1>
                <h5>Tu amigo el Dentista</h5>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Veniam quasi deleniti
                    id amet doloribus consectetur laudantium porro soluta, corrupti hic nemo
                    ipsam nulla ex at laborum odit? Beatae cupiditate voluptas voluptatum
                    necessitatibus maxime.</p>

                <a href="" class="btn">Haz tu cita</a>
            </div>
        </div>

        <div class="box">
            <div class="image">
                <img src="./img/Service-1.jpg" alt="">
            </div>
            <div class="content">
                <h1>Blanqueamiento Dental</h1>
                <h5>Tu amigo el Dentista</h5>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Veniam quasi deleniti
                    id amet doloribus consectetur laudantium porro soluta, corrupti hic nemo
                    ipsam nulla ex at laborum odit? Beatae cupiditate voluptas voluptatum
                    necessitatibus maxime.</p>

                <a href="" class="btn">Haz tu Cita</a>
            </div>
        </div>

        <div class="box">
            <div class="image">
                <img src="./img/Service-3.jpg" alt="">
            </div>
            <div class="content">
                <h1>Transplantes</h1>
                <h5>Tu amigo el Dentista</h5>
                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Veniam quasi deleniti
                    id amet doloribus consectetur laudantium porro soluta, corrupti hic nemo
                    ipsam nulla ex at laborum odit? Beatae cupiditate voluptas voluptatum
                    necessitatibus maxime.</p>

                <a href="" class="btn">Haz tu Cita</a>
            </div>
        </div>

    </div>
</section>

<!---== Ubicacion y contacto Section ==--->

<section class="contact" id="contact">
    <div class="ubicacionSection">
        <div>
            <div class="heading">
                <h2>Ubicación y contacto</h2>
            </div>

            <div class="paragraph">
                <p>Nos encontramos en Mar Mediterráneo #227; Col. Popotla</p>
            </div>

            <div class="container">
                <div class="image">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3761.9516900277167!2d-99.18267432423428!3d19.457649581827102!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85d1f898679c7b35%3A0x2a36459193a6193e!2sMar%20Mediterr%C3%A1neo%2C%20Ciudad%20de%20M%C3%A9xico%2C%20CDMX!5e0!3m2!1ses!2smx!4v1725935448595!5m2!1ses!2smx"
                        width="500" height="350" style="border:0;" allowfullscreen="" loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </div>
        <div class="contactoSection">
            <h1>Contacto</h1>
            <form action="">
                <div class="inputBoxContacto">
                    <input type="text" placeholder="Ingresa tu Nombre">
                </div>
                <div class="inputBoxContacto">
                    <input type="email" placeholder="Ingresa tu Email">
                </div>
                <div class="inputBoxContacto">
                    <input type="number" placeholder="Ingresa tu Teléfono">
                </div>
                <div class="inputBoxContacto">
                    <textarea name="" placeholder="Mensaje" id="" cols="30" rows="10"></textarea>
                </div>
                <button type="submit" class="buttonContacto">Enviar</button>
            </form>
        </div>
    </div>
</section>

<!---== Dudas y comentarios Section ==--->

<section class="doubts" id="doubts">
    <div class="ubicacionSection">
        <div>
            <div class="heading">
                <h2>Dudas y comentarios</h2>
            </div>
            <div class="container">
                <div class="image">
                    <img src="./img/dentist-2.jpg" alt="">
                </div>
            </div>
        </div>
        <div class="contactoSection">
            <h1>Dudas y comentarios</h1>
            <form action="">
                <div class="inputBoxContacto">
                    <input type="text" placeholder="Ingresa tu Nombre">
                </div>
                <div class="inputBoxContacto">
                    <input type="email" placeholder="Ingresa tu Email">
                </div>
                <div class="inputBoxContacto">
                    <input type="number" placeholder="Ingresa tu Teléfono">
                </div>
                <div class="inputBoxContacto">
                    <textarea name="" placeholder="Mensaje" id="" cols="30" rows="10"></textarea>
                </div>
                <button type="submit" class="buttonContacto">Enviar</button>
            </form>
        </div>
    </div>
</section>
<footer>
    <div class="container">

        <div class="box">
            <h2>Salud Dental</h2>
            <p>Somos un equipo de Doctores Profesionales</p>
        </div>

        <div class="box">
            <h2>Acceso Rápido</h2>
            <a href="#home">Home</a>
            <a href="#about">Quienes Somos</a>
            <a href="#sercies">Servicios</a>
            <a href="#contact">Ubicación y Contacto</a>
            <a href="#doubts">Dudas y comentarios</a>
            <a href="">Acceso</a>
        </div>

        <div class="box">
            <h2>Links</h2>
            <a href="">Ayuda</a>
            <a href="">Tienes una pregunta?</a>
            <a href="">Polí­ticas de privacidad</a>
            <a href="">Términos y Condiciones</a>
            <a href="">Nos interesa tu opinión</a>
        </div>

        <div class="box">
            <h2>FeedBack</h2>
            <p>Recibe noticias</p>
            <div class="input">
                <input type="email" placeholder="Ingresa tu Email">
                <button value="Send" class="send">Enviar</button>
            </div>
        </div>
    </div>

    <div class="credit">
        <p>Todos los derechos reservados | <span>MexiCode</span></p>
    </div>
</footer>
</body>

</html>