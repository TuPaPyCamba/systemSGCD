package com.sgcd.controller;

import com.sgcd.model.Paciente;
import com.sgcd.service.PacienteService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private PacienteService pacienteService = new PacienteService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contraseña = request.getParameter("contraseña");

        try {
            Paciente paciente = pacienteService.findPacienteByUsuario(usuario);
            if (paciente != null && paciente.getContraseña().equals(contraseña)) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                response.sendRedirect("WEB-INF/views/dashboard.jsp");
            } else {
                response.sendRedirect("WEB-INF/views/login.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            throw new ServletException("Error al autenticar el usuario", e);
        }
    }
}