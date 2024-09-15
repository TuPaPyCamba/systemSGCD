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

    // Metodo de creacion
    public boolean crearCita(int idPaciente, int idMedico, LocalDate fecha, String hora, String descripcion) {
        // Verificar si el horario ya está ocupado
        if (esHorarioOcupadoParaMedico(idMedico, fecha, hora)) {
            System.out.println("El Medico ya tiene una cita en este horario.");
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

    // Metodo de verificacion medico
    private boolean esHorarioOcupadoParaMedico(int idMedico, LocalDate fecha, String hora) {
        String sql = "SELECT COUNT(*) FROM citas WHERE idmedico = ? AND DATE(fecha) = ? AND hora = ?";
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

    // Metodo de verificaicon paciente
    private boolean esHorarioOcupadoParaPaciente(int idMedico, LocalDate fecha, String hora) {
        String sql = "SELECT COUNT(*) FROM citas WHERE idmedico = ? AND DATE(fecha) = ? AND hora = ?";
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

    // Metodo para editar
    public int update(Cita cita) throws SQLException {
        String sql = "UPDATE citas SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ?, descripcion = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, cita.getIdPaciente());
            stmt.setInt(2, cita.getIdMedico());
            stmt.setDate(3, java.sql.Date.valueOf(cita.getFecha()));
            stmt.setString(4, cita.getHora());
            stmt.setString(5, cita.getDescripcion());
            stmt.setInt(6, cita.getId());

            registros = stmt.executeUpdate();
        } finally {
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros;
    }

    // Obtener citas por medico y dia
    public List<String> obtenerCitasPorMedicoYDia(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT hora FROM citas WHERE idmedico = ? AND fecha = ?";
        List<String> citas = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

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

    // Obtener citas por paciente y dia
    public List<String> obtenerCitasPorPacienteYDia (int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT hora FROM citas WHERE idpaciente = ? AND fecha = ?";
        List<String> citas = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

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

    // Obtener horas disponibles para consulta
    public List<String> obtenerHorasDisponiblesParaCitas(int idMedico, LocalDate dia) {
        System.out.println(dia);

        List<String> todasLasHoras = HorarioUtil.obtenerHorasDisponiblesParaCitas();
        List<String> citasOcupadas = new CitaDAO().obtenerCitasPorMedicoYDia(idMedico, dia);

        // Eliminar las horas ocupadas de la lista de horas disponibles
        List<String> horasDisponibles = new ArrayList<>(todasLasHoras);
        horasDisponibles.removeAll(citasOcupadas);

        return horasDisponibles;
    }

    // Metodo para obtener todas las consultas
    public List<Cita> findAllCitas() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        String sql = "SELECT * FROM citas";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Cita cita = new Cita();
                cita.setId(rs.getInt("id"));
                cita.setIdMedico(rs.getInt("idmedico"));
                cita.setIdPaciente(rs.getInt("idpaciente"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getString("hora"));
                cita.setDescripcion(rs.getString("descripcion"));
                citas.add(cita);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas;
    }

    // Obtener citas por medico y dia
    public List<Cita> obtenerTodasCitas(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        String sql = "SELECT * FROM citas WHERE idmedico = ? AND fecha = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            while (rs.next()) {
                Cita cita = new Cita();
                cita.setId(rs.getInt("id"));
                cita.setIdMedico(rs.getInt("idmedico"));
                cita.setIdPaciente(rs.getInt("idpaciente"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getString("hora"));
                cita.setDescripcion(rs.getString("descripcion"));
                citas.add(cita);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return citas;
    }
}

