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

    // Metodo de creacion (actualizado para email)
    public int create(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO pacientes(usuario, contrasena, email, nombre, apellidos, telefono, direccion) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setString(1, paciente.getUsuario());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getEmail());
            stmt.setString(4, paciente.getNombre());
            stmt.setString(5, paciente.getApellidos());
            stmt.setString(6, paciente.getTelefono());
            stmt.setString(7, paciente.getDireccion());

            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para editar (actualizado para email)
    public int actualizar(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE pacientes SET usuario = ?, contrasena = ?, email = ?, nombre = ?, apellidos = ?, telefono = ?, direccion = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);
            stmt.setString(1, paciente.getUsuario());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getEmail());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());
            stmt.setInt(7, paciente.getId());
            registros = stmt.executeUpdate();
            System.out.println(registros);
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para eliminar (funcional para la ultima version)
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

    // Metodo para traer todos los registros (funcional para la ultima version)
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
                paciente.setId(rs.getInt("id"));
                paciente.setUsuario(rs.getString("usuario"));
                paciente.setContrasena(rs.getString("contrasena"));
                paciente.setEmail(rs.getString("email"));
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