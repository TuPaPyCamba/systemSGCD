package com.sgcd.dao;

import com.sgcd.model.Cita;
import com.sgcd.util.HorarioUtil;

import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    public boolean crearCita(int idPaciente, int idMedico, LocalDate fecha, String hora, String descripcion) {
        // Verificar si el horario ya está ocupado
        if (esHorarioOcupado(idMedico, fecha, hora)) {
            System.out.println("El médico ya tiene una cita en ese horario.");
            return false;
        }

        System.out.println(idPaciente);
        System.out.println(idMedico);
        System.out.println(fecha);
        System.out.println(hora);
        System.out.println(descripcion);

        String sql = "INSERT INTO citas (idPaciente, idMedico, fecha, hora, descripcion) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idPaciente);
            stmt.setInt(2, idMedico);
            stmt.setDate(3, Date.valueOf(fecha));
            stmt.setString(4, hora);
            stmt.setString(5, descripcion);

            int filasInsertadas = stmt.executeUpdate();

            if (filasInsertadas > 0) {
                System.out.println("Cita creada exitosamente.");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private boolean esHorarioOcupado(int idMedico, LocalDate fecha, String hora) {
        String sql = "SELECT COUNT(*) FROM citas WHERE idMedico = ? AND DATE(fecha) = ? AND hora = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idMedico);
            stmt.setDate(2, Date.valueOf(fecha));
            stmt.setString(3, hora);

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

    public List<String> obtenerCitasPorMedicoYDia(int idmedico, LocalDate dia) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT hora FROM citas WHERE idmedico = ? AND fecha = ?";
        List<String> citas = new ArrayList<>();

        System.out.println(dia);

        try {

            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(dia));

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                citas.add(rs.getString("hora"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas;
    }

    public List<String> obtenerHorasDisponiblesParaCitas(int idMedico, LocalDate dia) {
        System.out.println(dia);

        List<String> todasLasHoras = HorarioUtil.obtenerHorasDisponibles();
        List<String> citasOcupadas = new CitaDAO().obtenerCitasPorMedicoYDia(idMedico, dia);

        // Eliminar las horas ocupadas de la lista de horas disponibles
        List<String> horasDisponibles = new ArrayList<>(todasLasHoras);
        horasDisponibles.removeAll(citasOcupadas);

        System.out.println(dia);
        System.out.println(horasDisponibles);

        return horasDisponibles;
    }
}

