package com.sgcd.dao;

import com.sgcd.model.Administrador;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdministradorDAO {

    // Metodo de creacion (actualizado para email)
    public int create(Administrador admin) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String sql = "INSERT INTO administradores(usuario, contrasena, email, idsucursal, nombre, apellidos) VALUES (?, ?, ?, ?, ?, ?)";

        try{
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, admin.getUsuario());
            stmt.setString(2, admin.getContrasena());
            stmt.setString(3, admin.getEmail());
            stmt.setInt(4, admin.getIdsucursal());
            stmt.setString(5, admin.getNombre());
            stmt.setString(6, admin.getApellidos());

            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo de editar (actualizado para email)
    public int actualizar(Administrador admin) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String sql = "UPDATE administradores SET usuario = ?, contrasena = ?, email = ?, idsucursal = ?, nombre = ?, apellidos = ? WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, admin.getUsuario());
            stmt.setString(2, admin.getContrasena());
            stmt.setString(3, admin.getEmail());
            stmt.setInt(4, admin.getIdsucursal());
            stmt.setString(5, admin.getNombre());
            stmt.setString(6, admin.getApellidos());
            stmt.setInt(7, admin.getId());
            registros = stmt.executeUpdate();

            System.out.println("Registros actualizados: " + registros);
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros;
    }

    // Metodo de eliminar (actualizado para email)
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        String sql = "DELETE FROM administradores WHERE id = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
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

    // Metodo de obtener todos los registros (actualizado para email)
    public List<Administrador> obtenerAdministradores() throws SQLException {
        List<Administrador> administradores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM administradores";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setId(rs.getInt("id"));
                admin.setUsuario(rs.getString("usuario"));
                admin.setContrasena(rs.getString("contrasena"));
                admin.setEmail(rs.getString("email"));
                admin.setIdsucursal(rs.getInt("idsucursal"));
                admin.setNombre(rs.getString("nombre"));
                admin.setApellidos(rs.getString("apellidos"));
                administradores.add(admin);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return administradores;
    }
}
