package com.sgcd.servlets;

import com.sgcd.util.Autentificacion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author jh
 */
@WebServlet(name="Login", urlPatterns={"/Login"})
public class Login extends HttpServlet {

    private Autentificacion autentificacion = new Autentificacion();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        HttpSession session = request.getSession();

        if (autentificacion.autentificacionUsuario(usuario, contrasena, session)) {
            String tipoUsuario = (String) session.getAttribute("tipoUsuario");
            response.sendRedirect(ManejoPaginaCorrespondiente(tipoUsuario));
        }
    } 


    private String ManejoPaginaCorrespondiente(String tipoUsuario) {
        switch (tipoUsuario) {
            case "administrador":
                return "index.jsp";
            case "paciente":
                return "gestionPaciente.jsp";
            case "medico":
                return "gestionMedico.jsp";
            default:
                return "login.jsp";
        }
    }

}
