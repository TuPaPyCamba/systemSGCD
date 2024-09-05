package com.sgcd.model;

import com.sgcd.dao.CitaDAO;
import com.sgcd.dao.ConsultaDAO;
import java.sql.SQLException;
import java.util.List;

public class Agenda {

    private CitaDAO citaDAO;
    private ConsultaDAO consultaDAO;

    public Agenda() {
        this.citaDAO = new CitaDAO();
        this.consultaDAO = new ConsultaDAO();
    }

    // Obtiene todas las citas
    public List<Cita> getAllCitas() throws SQLException {
        return citaDAO.findAllCitas();
    }

    // Obtiene todas las consultas
    public List<Consulta> getAllConsultas() throws SQLException {
        return consultaDAO.findAllConsultas();
    }

    // Obtiene todas las citas para un paciente específico
    public List<Cita> getCitasPorPaciente(int pacienteId) throws SQLException {
        return citaDAO.findCitasByPacienteId(pacienteId);
    }

    // Obtiene todas las consultas para un paciente específico
    public List<Consulta> getConsultasPorPaciente(int pacienteId) throws SQLException {
        return consultaDAO.findConsultasByPacienteId(pacienteId);
    }

    // Obtiene todas las citas para un medico específico
    public List<Cita> getCitasPorMedico(int medicoId) throws SQLException {
        return citaDAO.findCitasByMedicoId(medicoId);
    }

    // Obtiene todas las consultas para un medico específico
    public List<Consulta> getConsultasPorMedico(int medicoId) throws SQLException {
        return consultaDAO.findConsultasByMedicoId(medicoId);
    }
}