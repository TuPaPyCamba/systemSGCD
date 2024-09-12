package com.sgcd.dao;

import com.sgcd.model.Medico;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class MedicoDAO {

    // Método de creación
    public int create(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO medicos (usuario, contrasena, nombre, apellidos, especialidad) VALUES (?, ?, ?, ?, ?)";
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getNombre());
            stmt.setString(4, medico.getApellidos());
            stmt.setString(5, medico.getEspecialidad());
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para traer todos los registros
    public List<Medico> obtenerMedicos() throws SQLException {
        List<Medico> medicos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String SQL_SELECT = "SELECT * FROM medicos";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Medico medico = new Medico();
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setEspecialidad(rs.getString("especialidad"));

                medicos.add(medico);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return medicos;
    }

    // Metodo para editar
    public int actualizar(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE medicos SET usuario = ?, contrasena = ?, nombre = ?, apellidos = ?, especialidad = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getNombre());
            stmt.setString(4, medico.getApellidos());
            stmt.setString(5, medico.getEspecialidad());
            stmt.setInt(6, medico.getId());
            registros = stmt.executeUpdate();
            System.out.println(registros);
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Método para buscar un médico por ID
    public Medico findById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Medico medico = null;
        String SQL_SELECT_BY_ID = "SELECT * FROM medicos WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_BY_ID);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setEspecialidad(rs.getString("especialidad"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return medico;
    }

    // Método para eliminar
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_DELETE = "DELETE FROM medicos WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_DELETE);
            stmt.setInt(1, id);
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    public List<LocalDateTime> obtenerHorasDisponiblesParaCitas(int idMedico, LocalDate dia) {
        // Horario de médico para citas (10 AM - 13 PM)
        LocalTime horaInicio = LocalTime.of(10, 0);
        LocalTime horaFin = LocalTime.of(13, 0);

        // Obtener citas existentes para ese día
        CitaDAO citaDAO = new CitaDAO();
        List<LocalDateTime> citasOcupadas = citaDAO.obtenerCitasPorMedicoYDia(idMedico, dia);

        // Crear la lista de horas disponibles
        List<LocalDateTime> horasDisponibles = new ArrayList<>();
        for (LocalTime hora = horaInicio; hora.isBefore(horaFin); hora = hora.plusHours(1)) {
            LocalDateTime fechaHora = LocalDateTime.of(dia, hora);
            if (!citasOcupadas.contains(fechaHora)) {
                horasDisponibles.add(fechaHora);
            }
        }

        return horasDisponibles;
    }

    public List<LocalDateTime> obtenerHorasDisponiblesParaConsultas(int idMedico, LocalDate dia) {
        // Horario de médico para citas (15 PM - 19 PM)
        LocalTime horaInicio = LocalTime.of(15, 0);
        LocalTime horaFin = LocalTime.of(19, 0);

        // Obtener citas existentes para ese día
        CitaDAO citaDAO = new CitaDAO();
        List<LocalDateTime> citasOcupadas = citaDAO.obtenerCitasPorMedicoYDia(idMedico, dia);

        // Crear la lista de horas disponibles
        List<LocalDateTime> horasDisponibles = new ArrayList<>();
        for (LocalTime hora = horaInicio; hora.isBefore(horaFin); hora = hora.plusHours(1)) {
            LocalDateTime fechaHora = LocalDateTime.of(dia, hora);
            if (!citasOcupadas.contains(fechaHora)) {
                horasDisponibles.add(fechaHora);
            }
        }

        return horasDisponibles;
    }

}