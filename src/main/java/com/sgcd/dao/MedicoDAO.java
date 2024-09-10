package com.sgcd.dao;

import com.sgcd.model.Medico;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class MedicoDAO {

    // Método de creación
    public int create(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO Medicos (usuario, contrasena, nombre, apellidos, especialidad) VALUES (?, ?, ?, ?, ?)";
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

    // Método para buscar un médico por ID
    public Medico findById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Medico medico = null;
        String SQL_SELECT_BY_ID = "SELECT * FROM Medicos WHERE id = ?";

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

    // Método para editar
    public int update(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE Medicos SET usuario = ?, contrasena = ?, nombre = ?, apellidos = ?, especialidad = ? WHERE id = ?";

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
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Método para eliminar
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_DELETE = "DELETE FROM Medicos WHERE id = ?";

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