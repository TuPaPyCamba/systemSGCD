package com.sgcd.servlets;

import com.sgcd.util.Autentificacion;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author jh
 */
public class Login extends HttpServlet {

    private Autentificacion autentificacion = new Autentificacion();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        HttpSession session = request.getSession();

        if (autentificacion.autentificarUsuario(usuario, contrasena, session)) {
            String tipoUsuario = (String) session.getAttribute("tipoUsuario");
            response.sendRedirect(ManejoPaginaCorrespondiente(tipoUsuario));
        }
    } 


    private String ManejoPaginaCorrespondiente(String tipoUsuario) {
        switch (tipoUsuario) {
            case "administrador":
                return "/SystemSGCD/gestionPaciente.jsp";
            case "paciente":
                return "/SystemSGCD/index.jsp";
            case "medico":
                return "/SystemSGCD/index.jsp";
            default:
                return "/SystemSGCD/inicioSesion.jsp";
        }
    }

}
