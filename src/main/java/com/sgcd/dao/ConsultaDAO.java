package com.sgcd.dao;

import com.sgcd.model.Consulta;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class ConsultaDAO {

    // Metodo de creacion
    public int create(Consulta consulta) throws SQLException {
        String sql = "INSERT INTO Consultas (paciente_id, medico_id, fecha, hora) VALUES (?,?,?,?)";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;
        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, consulta.getPacienteId());
            stmt.setInt(2, consulta.getMedicoId());
            stmt.setDate(3, consulta.getFecha());
            stmt.setTime(4, consulta.getHora());

            registros = stmt.executeUpdate();
        } finally {
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros;
    }

    // Metodo para buscar una consulta por ID
    public Consulta findById(int id) throws SQLException {
        String sql = "SELECT * FROM Consultas WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Consulta consulta = null;

        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setPacienteId(rs.getInt("paciente_id"));
                consulta.setMedicoId(rs.getInt("medico_id"));
                consulta.setFecha(rs.getDate("fecha"));
                consulta.setHora(rs.getTime("hora"));
            }
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return consulta;
    }

    // Metodo para editar
    public int update(Consulta consulta) throws SQLException {
        String sql = "UPDATE Consultas SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, consulta.getPacienteId());
            stmt.setInt(2, consulta.getMedicoId());
            stmt.setDate(3, consulta.getFecha());
            stmt.setTime(4, consulta.getHora());
            stmt.setInt(5, consulta.getId());

            registros = stmt.executeUpdate();
        } finally {
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros;
    }

    // Metodo para eliminar
    public int delete(int id) throws SQLException {
        String sql = "DELETE FROM Consultas WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            registros = stmt.executeUpdate();
        } finally {
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros;
    }
}
