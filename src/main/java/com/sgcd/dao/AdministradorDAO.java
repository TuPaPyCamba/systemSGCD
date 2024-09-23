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

/**
 * Clase AdministradorDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Administrador.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de administradores.
 */
public class AdministradorDAO {

    /**
     * Método para crear un nuevo administrador en la base de datos.
     * @param admin El objeto Administrador que contiene los datos a insertar.
     * @return El número de registros insertados en la base de datos.
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int create(Administrador admin) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para insertar un nuevo administrador
        String sql = "INSERT INTO administradores(usuario, contrasena, idsucursal, nombre, apellidos) VALUES (?, ?, ?, ?, ?)";

        try{
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            stmt.setString(1, admin.getUsuario());
            stmt.setString(2, admin.getContrasena());
            stmt.setInt(3, admin.getIdsucursal());
            stmt.setString(4, admin.getNombre());
            stmt.setString(5, admin.getApellidos());

            registros = stmt.executeUpdate(); // Se ejecuta la consulta
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros insertados
    }

    /**
     * Método para actualizar los datos de un administrador en la base de datos.
     * @param admin El objeto Administrador con los datos actualizados.
     * @return El número de registros actualizados en la base de datos.
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int actualizar(Administrador admin) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para actualizar un registro de administrador
        String sql = "UPDATE administradores SET usuario = ?, contrasena = ?, idsucursal = ?, nombre = ?, apellidos = ? WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            stmt.setString(1, admin.getUsuario());
            stmt.setString(2, admin.getContrasena());
            stmt.setInt(3, admin.getIdsucursal());
            stmt.setString(4, admin.getNombre());
            stmt.setString(5, admin.getApellidos());
            stmt.setInt(6, admin.getId());

            registros = stmt.executeUpdate(); // Se ejecuta la consulta de actualización
            System.out.println("Registros actualizados: " + registros);
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros actualizados
    }

    /**
     * Método para eliminar un administrador de la base de datos por su ID.
     * @param id El ID del administrador a eliminar.
     * @return El número de registros eliminados.
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar un registro de administrador
        String sql = "DELETE FROM administradores WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            registros = stmt.executeUpdate(); // Se ejecuta la consulta de eliminación
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros eliminados
    }

    /**
     * Método para obtener todos los administradores de la base de datos.
     * @return Una lista de objetos Administrador que representa todos los registros en la base de datos.
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Administrador> obtenerAdministradores() throws SQLException {
        List<Administrador> administradores = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM administradores";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery(); // Se ejecuta la consulta de selección

            // Recorre el resultado de la consulta y crea objetos Administrador
            while (rs.next()) {
                Administrador admin = new Administrador();

                // Establecer los parámetros para cada objeto Administrador
                admin.setId(rs.getInt("id"));
                admin.setUsuario(rs.getString("usuario"));
                admin.setContrasena(rs.getString("contrasena"));
                admin.setIdsucursal(rs.getInt("idsucursal"));
                admin.setNombre(rs.getString("nombre"));
                admin.setApellidos(rs.getString("apellidos"));

                administradores.add(admin); // Agrega el objeto a la lista
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return administradores; // Devuelve la lista de administradores
    }
}
