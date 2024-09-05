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

//    !!!!!!!!!!! Pruebas que ando haciendo !!!!!!!!!!!!!!!!!!!!
//    // Verifica si el médico tiene citas programadas en la misma fecha y hora
//    private boolean medicoTieneCitasEnFechaHora(int medicoId, Date fecha, Time hora) throws SQLException {
//        List<Cita> citas = citaDAO.findCitasByMedicoId(medicoId);
//        for (Cita cita : citas) {
//            if (cita.getFecha().equals(fecha) && cita.getHora().equals(hora)) {
//                return true;
//            }
//        }
//        return false;
//    }
//
//    // Verifica si el médico tiene consultas programadas en la misma fecha y hora
//    private boolean medicoTieneConsultasEnFechaHora(int medicoId, Date fecha, Time hora) throws SQLException {
//        List<Consulta> consultas = consultaDAO.findConsultasByMedicoId(medicoId);
//        for (Consulta consulta : consultas) {
//            if (consulta.getFecha().equals(fecha) && consulta.getHora().equals(hora)) {
//                return true;
//            }
//        }
//        return false;
//    }
//
//    // Crear una cita
//    public void createCita(Cita cita) throws SQLException {
//        // Verifica si el médico ya tiene una cita o consulta programada en la misma fecha y hora
//        if (medicoTieneCitasEnFechaHora(cita.getMedicoId(), cita.getFecha(), cita.getHora()) ||
//                medicoTieneConsultasEnFechaHora(cita.getMedicoId(), cita.getFecha(), cita.getHora())) {
//            throw new SQLException("El médico ya tiene una cita o consulta programada en la misma fecha y hora.");
//        }
//        citaDAO.create(cita);
//    }
//
//    // Crear una consulta
//    public void createConsulta(Consulta consulta) throws SQLException {
//        // Verifica si el médico ya tiene una cita o consulta programada en la misma fecha y hora
//        if (medicoTieneCitasEnFechaHora(consulta.getMedicoId(), consulta.getFecha(), consulta.getHora()) ||
//                medicoTieneConsultasEnFechaHora(consulta.getMedicoId(), consulta.getFecha(), consulta.getHora())) {
//            throw new SQLException("El médico ya tiene una cita o consulta programada en la misma fecha y hora.");
//        }
//        consultaDAO.create(consulta);
//    }

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