package com.sgcd.model;

import com.sgcd.util.DatabaseConfig;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

public class Cita {
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
    public void create(Cita cita) throws SQLException {
        String sql = "INSERT INTO Citas (paciente_id, medico_id, fecha, hora) VALUES (?,?,?,?)";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, cita.getPacienteId());
            stmt.setInt(2, cita.getMedicoId());
            stmt.setDate(3, cita.getFecha());
            stmt.setTime(4, cita.getHora());
            stmt.executeUpdate();
        }
    }

    // Metodo para buscar una cita por ID
    public Cita findById(int id) throws SQLException {
        String sql = "SELECT * FROM Citas WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
        PreparedStatement stmt = con.prepareStatement(sql)){

             stmt.setInt(1, id);
             try (ResultSet rs = stmt.executeQuery()){
                 if (rs.next()){
                     Cita cita = new Cita();
                     cita.setId(rs.getInt("id"));
                     cita.setPacienteId(rs.getInt("paciente_id"));
                     cita.setMedicoId(rs.getInt("medico_id"));
                     cita.setFecha(rs.getDate("fecha"));
                     cita.setHora(rs.getTime("hora"));
                     return cita;
                 }
             }
        }
        return null;
    }

    // Metodo para editar
    public void update(Cita cita) throws SQLException {
        String sql = "UPDATE Citas SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ? WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)){

            stmt.setInt(1, cita.getPacienteId());
            stmt.setInt(2, cita.getMedicoId());
            stmt.setDate(3, cita.getFecha());
            stmt.setTime(4, cita.getHora());
            stmt.setInt(5, cita.getId());
            stmt.executeUpdate();
        }
    }

    // Metodo para eliminar
    public void delete(Cita cita) throws SQLException {
        String sql = "DELETE FROM Citas WHERE id = ?";
        try (Connection con = DatabaseConfig.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)){

            stmt.setInt(1, cita.getId());
            stmt.executeUpdate();
        }
    }
}