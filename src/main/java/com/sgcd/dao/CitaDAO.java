package com.sgcd.dao;

import com.sgcd.model.Cita;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    // Metodo de creacion
    public boolean crearCita(int idPaciente, int idMedico, LocalDateTime fechaHora, String descripcion) {
        // Verificar si el médico ya tiene una cita en esa fecha y hora
        if (esHorarioOcupado(idMedico, fechaHora)) {
            System.out.println("El médico ya tiene una cita en ese horario.");
            return false;  // No se puede crear una cita si el horario está ocupado
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        // SQL para insertar una nueva cita
        String sql = "INSERT INTO citas (idPaciente, idMedico, fechaHora, descripcion) VALUES (?, ?, ?, ?)";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Asignar parámetros al PreparedStatement
            stmt.setInt(1, idPaciente);
            stmt.setInt(2, idMedico);
            stmt.setTimestamp(3, Timestamp.valueOf(fechaHora));
            stmt.setString(4, descripcion);

            int filasInsertadas = stmt.executeUpdate();

            if (filasInsertadas > 0) {
                System.out.println("Cita creada exitosamente.");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Hubo un problema al crear la cita
    }

    public boolean esHorarioOcupado(int idMedico, LocalDateTime fechaHora) {
        String sql = "SELECT COUNT(*) FROM citas WHERE idMedico = ? AND fechaHora = ?";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idMedico);
            stmt.setTimestamp(2, Timestamp.valueOf(fechaHora));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Metodo para eliminar
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_DELETE = "DELETE FROM citas WHERE id = ?";

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

    // Método para obtener todas las citas
    public List<Cita> findAllCitas() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        String SQL_SELECT_ALL = "SELECT * FROM citas";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Cita cita = new Cita();
                cita.setId(rs.getInt("id"));
                cita.setIdPaciente(rs.getInt("paciente_id"));
                cita.setIdMedico(rs.getInt("medico_id"));
                cita.setFechaHora(rs.getTimestamp("fechahora").toLocalDateTime());
                citas.add(cita);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas;
    }

    public List<LocalDateTime> obtenerCitasPorMedicoYDia(int idmedico, LocalDate dia) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT fechaHora FROM citas WHERE idmedico = ? AND DATE(fechaHora) = ?";
        List<LocalDateTime> citas = new ArrayList<>();

        try {

            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idmedico);
            stmt.setDate(2, Date.valueOf(dia));

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                citas.add(rs.getTimestamp("fechaHora").toLocalDateTime());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas;
    }

}