package com.sgcd.model;

import com.sgcd.util.DatabaseConfig;

import java.sql.*;

public class Consulta {
    private int id;
    private int pacienteId;
    private int medicoId;
    private Date fecha;
    private Time hora;

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPacienteId() { return pacienteId; }
    public void setPacienteId(int pacienteId) { this.pacienteId = pacienteId; }

    public int getMedicoId() { return medicoId; }
    public void setMedicoId(int medicoId) { this.medicoId = medicoId; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public Time getHora() { return hora; }
    public void setHora(Time hora) { this.hora = hora; }

    // Metodo de creacion
    public void create(Consulta consulta) throws SQLException {
        String sql = "INSERT INTO Consulta (paciente_id, medico_id, fecha, hora) VALUES (?,?,?,?)";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, consulta.getPacienteId());
            stmt.setInt(2, consulta.getMedicoId());
            stmt.setDate(3, consulta.getFecha());
            stmt.setTime(4, consulta.getHora());
            stmt.executeUpdate();
        }
    }

    // Metodo para buscar una cita por ID
    public Consulta findById(int id) throws SQLException {
        String sql = "SELECT * FROM Consulta WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)){

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()){
                if (rs.next()){
                    Consulta consulta = new Consulta();
                    consulta.setId(rs.getInt("id"));
                    consulta.setPacienteId(rs.getInt("paciente_id"));
                    consulta.setMedicoId(rs.getInt("medico_id"));
                    consulta.setFecha(rs.getDate("fecha"));
                    consulta.setHora(rs.getTime("hora"));
                    return consulta;
                }
            }
        }
        return null;
    }

    // Metodo para editar
    public void update(Consulta consulta) throws SQLException {
        String sql = "UPDATE Consulta SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ? WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)){

            stmt.setInt(1, consulta.getPacienteId());
            stmt.setInt(2, consulta.getMedicoId());
            stmt.setDate(3, consulta.getFecha());
            stmt.setTime(4, consulta.getHora());
            stmt.setInt(5, consulta.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Consulta consulta) throws SQLException {
        String sql = "DELETE FROM Consulta WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)){

            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        }
    }
}