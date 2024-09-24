package com.sgcd.dao;

import com.sgcd.model.Sucursal;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase SucursalDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Sucursal.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de Sucursal.
 */
public class SucursalDao {

    /**
     * Crea un nuevo registro de sucursal en la base de datos.
     *
     * @param sucursal Objeto Sucursal con los datos de la nueva sucursal
     * @return Número de registros creados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int createSucursal(Sucursal sucursal) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para insertar un nuevo registro de sucursal
        String sql = "INSERT INTO sucursal (nombre, direccion, telefono, ciudad, estado, pais) VALUES (?,?,?,?,?,?)";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            stmt.setString(1, sucursal.getNombre());
            stmt.setString(2, sucursal.getDireccion());
            stmt.setString(3, sucursal.getTelefono());
            stmt.setString(4, sucursal.getCiudad());
            stmt.setString(5, sucursal.getEstado());
            stmt.setString(6, sucursal.getPais());

            // Ejecutar la consulta y verificar si la inserción fue exitosa
            registros = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (stmt != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros añadidos
    }

    /**
     * Actualiza una sucursal existente en la base de datos.
     *
     * @param sucursal Objeto Sucursal con los datos actualizados de la sucursal
     * @return Número de registros actualizados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    private int actualizarSucursal(Sucursal sucursal) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para actualizar los datos del objeto sucursal
        String sql = "UPDATE sucursales SET nombre = ?, direccion = ?, telefono = ?, ciudad = ?, estado = ?, pais = ? WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            stmt.setString(1, sucursal.getNombre());
            stmt.setString(2, sucursal.getDireccion());
            stmt.setString(3, sucursal.getTelefono());
            stmt.setString(4, sucursal.getCiudad());
            stmt.setString(5, sucursal.getEstado());
            stmt.setString(6, sucursal.getPais());


            registros = stmt.executeUpdate(); // Ejecutar la actualización
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (stmt != null) close(conn);
            if (stmt != null) close(stmt);
        }
        return registros; // Devuelve el número de registros actualizados
    }

    /**
     * Elimina una sucursal de la base de datos por su ID.
     *
     * @param idsucursal ID de la sucursal a eliminar
     * @return Número de registros eliminados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int deleteSucursal(int idsucursal) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar un registro de sucursal
        String sql = "DELETE FROM sucursales WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idsucursal);

            registros = stmt.executeUpdate(); // Se ejecuta la consulta
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros eliminados
    }

    /**
     * Obtiene todos los registros de pacientes en la base de datos.
     *
     * @return Lista de objetos Paciente con los datos de todos los pacientes
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Sucursal> listaDeSucursales() throws SQLException {
        List<Sucursal> sucursales = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM sucursales";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Sucursal sucursal = new Sucursal();
                sucursal.setIdsucursal(rs.getInt("idsucursal"));
                sucursal.setNombre(rs.getString("nombre"));
                sucursal.setDireccion(rs.getString("direccion"));
                sucursal.setTelefono(rs.getString("telefono"));
                sucursal.setCiudad(rs.getString("ciudad"));
                sucursal.setEstado(rs.getString("estado"));
                sucursal.setPais(rs.getString("pais"));

                sucursales.add(sucursal);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return sucursales;
    }

    /**
     * Obtiene un registro de sucursal segun su id en la base de datos.
     *
     * @return Objeto Sucursal con los datos de la sucursal
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public Sucursal obtenerSucursalPorId(int idsucursal) throws SQLException {
        Sucursal sucursal = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        // Consulta SQL para obtener todos los registros de pacientes
        String sql = "SELECT * FROM sucursales WHERE idsucursal = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, idsucursal);
            rs = stmt.executeQuery();

            while (rs.next()) {
                sucursal = new Sucursal();

                // Establecer los parámetros para el objeto sucursal
                sucursal.setIdsucursal(rs.getInt("idsucursal"));
                sucursal.setNombre(rs.getString("nombre"));
                sucursal.setDireccion(rs.getString("direccion"));
                sucursal.setTelefono(rs.getString("telefono"));
                sucursal.setCiudad(rs.getString("ciudad"));
                sucursal.setEstado(rs.getString("estado"));
                sucursal.setPais(rs.getString("pais"));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        }
        return sucursal; // Devuelve el Objetos sucursal segun su ID
    }
}
