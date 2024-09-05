package com.sgcd.dao;

import com.sgcd.model.Cita;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CitaDAO {

    // Metodo de creacion
    public int create(Cita cita) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO Citas (paciente_id, medico_id, fecha, hora) VALUES (?, ?, ?, ?)";
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setInt(1, cita.getPacienteId());
            stmt.setInt(2, cita.getMedicoId());
            stmt.setDate(3, cita.getFecha());
            stmt.setTime(4, cita.getHora());
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para buscar una cita por ID
    public Cita findById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Cita cita = null;
        String SQL_SELECT_BY_ID = "SELECT * FROM Citas WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_BY_ID);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                cita = new Cita();
                cita.setId(rs.getInt("id"));
                cita.setPacienteId(rs.getInt("paciente_id"));
                cita.setMedicoId(rs.getInt("medico_id"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getTime("hora"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return cita;
    }

    // Metodo para editar
    public int update(Cita cita) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE Citas SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);
            stmt.setInt(1, cita.getPacienteId());
            stmt.setInt(2, cita.getMedicoId());
            stmt.setDate(3, cita.getFecha());
            stmt.setTime(4, cita.getHora());
            stmt.setInt(5, cita.getId());
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para eliminar
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_DELETE = "DELETE FROM Citas WHERE id = ?";

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
}