package com.sgcd.service;

import com.sgcd.dao.PacienteDAO;
import com.sgcd.model.Paciente;

import java.sql.SQLException;

public class PacienteService {

    private PacienteDAO pacienteDAO = new PacienteDAO();

    public void registerPaciente(Paciente paciente) throws SQLException {
        pacienteDAO.addPaciente(paciente);
    }

    // Métodos adicionales para manejar la lógica de negocio
}