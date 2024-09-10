package com.sgcd.dao;

import com.sgcd.model.Paciente;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PacienteDAO {

    // Metodo de creacion
    public int create(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO pacientes(usuario, contrasena, nombre, apellidos, telefono, direccion) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setString(1, paciente.getPaciente());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());

            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    public Paciente findById(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Paciente paciente = null;
        String SQL_SELECT_BY_ID = "SELECT * FROM pacientes WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_BY_ID);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                paciente.setIdPaciente(rs.getInt("id"));
                paciente.setPaciente(rs.getString("usuario"));
                paciente.setContrasena(rs.getString("contraseña"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApellidos(rs.getString("apellidos"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return paciente;
    }

    // Metodo para editar
    public int actualizar(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE pacientes SET usuario = ?, contraseña = ?, nombre = ?, apellidos = ?, telefono = ?, direccion = ?, aprobado = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);
            stmt.setString(1, paciente.getPaciente());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());
            stmt.setInt(7, paciente.getIdPaciente());

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
        String SQL_DELETE = "DELETE FROM pacientes WHERE id = ?";

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

    //Metodo para buscar pacientes por nombre
    public List<Paciente> findByName(String nombre) throws SQLException {
        List<Paciente> pacientes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String SQL_SELECT_BY_NAME = "SELECT * FROM pacientes WHERE nombre LIKE ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_BY_NAME);
            stmt.setString(1, "%" + nombre + "%");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("id"));
                paciente.setPaciente(rs.getString("usuario"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApellidos(rs.getString("apellidos"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));

                pacientes.add(paciente);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return pacientes;
    }

    // Metodo para traer todos los registros
    public List<Paciente> obtenerPacientes() throws SQLException {
        List<Paciente> pacientes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String SQL_SELECT_ALL = "SELECT * FROM pacientes";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = stmt.executeQuery();

            while (rs.next()) {

                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("id"));
                paciente.setPaciente(rs.getString("usuario"));
                paciente.setContrasena(rs.getString("contrasena"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApellidos(rs.getString("apellidos"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));

                pacientes.add(paciente);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return pacientes;
    }
}