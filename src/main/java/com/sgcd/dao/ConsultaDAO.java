package com.sgcd.dao;

import com.sgcd.model.Cita;
import com.sgcd.model.Consulta;
import com.sgcd.util.HorarioUtil;

import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ConsultaDAO {

    // Metodo de creacion
    public boolean crearConsulta(int idpaciente, int idmedico, LocalDate fecha, String hora, String descripcion) {
        // Verificar si el horario ya está ocupado para el Paciente
        if (esHorarioOcupadoParaPaciente(idpaciente, fecha, hora) && esHorarioOcupadoParaMedico(idmedico, fecha, hora)) {
            System.out.println("El Paciente ya tiene una cita programada en ese horario.");
            return false;
        }

        System.out.println(idpaciente);
        System.out.println(idmedico);
        System.out.println(fecha);
        System.out.println(hora);
        System.out.println(descripcion);

        String sql = "INSERT INTO concultas (idpaciente, idmedico, fecha, hora, descripcion) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idpaciente);
            stmt.setInt(2, idmedico);
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
    private boolean esHorarioOcupadoParaMedico(int idmedico, LocalDate fecha, String hora) {
        String sql = "SELECT COUNT(*) FROM consultas WHERE idmedico = ? AND DATE(fecha) = ? AND hora = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idmedico);
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

    // Metodo de verificacion paciente
    private boolean esHorarioOcupadoParaPaciente(int idpaciente, LocalDate fecha, String hora) {
        String sql = "SELECT COUNT(*) FROM concultas WHERE idpaciente = ? AND DATE(fecha) = ? AND hora = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idpaciente);
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
        String sql = "DELETE FROM consultas WHERE id = ?";
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

    // Metodo para editar
    public int update(Consulta consulta) throws SQLException {
        String sql = "UPDATE consultas SET paciente_id = ?, medico_id = ?, fecha = ?, hora = ?, descripcion = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, consulta.getIdPaciente());
            stmt.setInt(2, consulta.getIdMedico());
            stmt.setDate(3, java.sql.Date.valueOf(consulta.getFecha()));
            stmt.setString(4, consulta.getHora());
            stmt.setString(5, consulta.getDescripcion());
            stmt.setInt(6, consulta.getId());

            registros = stmt.executeUpdate();
        } finally {
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros;
    }

    // Obtener Consultas por paciente y dia
    public List<String> obtenerConsultasPorPacienteYDia(int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT * FROM consultas WHERE idpaciente = ? AND fecha = ?";
        List<String> consultas = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                consultas.add(rs.getString("hora"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas;
    }

    //Obtener Consultas por medico y dia
    public  List<String> obtenerConsultasPorMedicoYDia(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "SELECT * FROM consultas WHERE idmedico = ? AND fecha = ?";
        List<String> consultas = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                consultas.add(rs.getString("hora"));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas;
    }

    // Obtener horas disponibles para consulta
    public List<String> obtenerHorasDisponiblesParaConsultaPorPaciente(int idpaciente, LocalDate fecha) {

        List<String> todasLasHoras = HorarioUtil.obtenerHorasDisponiblesParaConsulta();
        List<String> consultasOcupadas = new ConsultaDAO().obtenerConsultasPorPacienteYDia(idpaciente, fecha);

        // Eliminar las horas ocupadas de la lista de horas disponibles
        List<String> horasDisponibles = new ArrayList<>(todasLasHoras);
        horasDisponibles.removeAll(consultasOcupadas);

        return horasDisponibles;
    }

    // Método para obtener todas las consultas
    public List<Consulta> findAllConsultas() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Consulta> consultas = new ArrayList<>();
        String SQL_SELECT_ALL = "SELECT * FROM consultas";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Consulta consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setIdPaciente(rs.getInt("paciente_id"));
                consulta.setIdMedico(rs.getInt("medico_id"));
                consulta.setFecha(rs.getDate("fecha").toLocalDate());
                consulta.setHora(rs.getString("hora"));
                consulta.setDescripcion(rs.getString("descripcion"));
                consultas.add(consulta);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas;
    }

    // Obtener citas por medico y dia
    public List<Consulta> obtenerTodasConsultas(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Consulta> consultas = new ArrayList<>();
        String sql = "SELECT * FROM consultas WHERE idmedico = ? AND fecha = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            while (rs.next()) {
                    Consulta consulta = new Consulta();
                    consulta.setId(rs.getInt("id"));
                    consulta.setIdMedico(rs.getInt("idmedico"));
                    consulta.setIdPaciente(rs.getInt("idpaciente"));
                    consulta.setFecha(rs.getDate("fecha").toLocalDate());
                    consulta.setHora(rs.getString("hora"));
                    consulta.setDescripcion(rs.getString("descripcion"));
                    consultas.add(consulta);
                }

        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework in a real application
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return consultas;
    }
}
