package com.sgcd.dao;

import com.sgcd.model.Medico;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MedicoDAO {

    // Método de creación (actualizado para sucursal y email)
    public int create(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_INSERT = "INSERT INTO medicos (usuario, contrasena, email, nombre, apellidos, idsucursal, especialidad) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getEmail());
            stmt.setString(4, medico.getNombre());
            stmt.setString(5, medico.getApellidos());
            stmt.setString(6, medico.getIdsucursal());
            stmt.setString(7, medico.getEspecialidad());
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo para traer todos los registros (actualizado para sucursal y email)
    public List<Medico> obtenerMedicos() throws SQLException {
        List<Medico> medicos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String SQL_SELECT = "SELECT * FROM medicos";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Medico medico = new Medico();
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setEmail(rs.getString("email"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getString("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));

                medicos.add(medico);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return medicos;
    }

    // Metodo para buscar un medico por id (Funcional para la ultima version)
    public Medico obtenerMedico(int id) throws SQLException {
        Medico medico = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String SQL_SELECT = "SELECT * FROM medicos WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                medico = new Medico();
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setEmail(rs.getString("email"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getString("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return medico;
    }

    // Metodo para editar (actualizado para sucursal y email)
    public int actualizar(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_UPDATE = "UPDATE medicos SET usuario = ?, contrasena = ?, email = ?, nombre = ?, apellidos = ?, idsucursal = ?, especialidad = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getEmail());
            stmt.setString(4, medico.getNombre());
            stmt.setString(5, medico.getApellidos());
            stmt.setString(6, medico.getIdsucursal());
            stmt.setString(7, medico.getEspecialidad());
            stmt.setInt(8, medico.getId());
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

    // Método para eliminar (funcional para la ultima version)
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String SQL_DELETE = "DELETE FROM medicos WHERE id = ?";

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

    // Metodo para buscar por idSucursal (actualizado para sucursal y email)
    public List<Medico> obtenerMedicosPorSucursal(int Idsucursal) throws SQLException {
        List<Medico> medicos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM medicos WHERE idsucursal = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Idsucursal);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Medico medico = new Medico();
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setEmail(rs.getString("email"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getString("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));
                medicos.add(medico);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return medicos;
    }

}