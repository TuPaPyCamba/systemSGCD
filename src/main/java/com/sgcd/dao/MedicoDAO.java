package com.sgcd.dao;

import com.sgcd.model.Medico;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase MedicoDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Medico.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de Medicos.
 */
public class MedicoDAO {

    /**
     * Crea un nuevo registro de médico en la base de datos.
     *
     * @param medico Objeto Medico con los datos del nuevo médico
     * @return Número de registros creados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int create(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para insertar un nuevo registro de medico
        String SQL_INSERT = "INSERT INTO medicos (usuario, contrasena, nombre, apellidos, idsucursal, especialidad) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);

            // Establecer los parámetros en la consulta
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getNombre());
            stmt.setString(4, medico.getApellidos());
            stmt.setInt(5, medico.getIdsucursal());
            stmt.setString(6, medico.getEspecialidad());

            // Ejecutar la consulta y verificar si la inserción fue exitosa
            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve la cantidad de registros añadidos
    }

    /**
     * Obtiene todos los registros de médicos en la base de datos.
     *
     * @return Lista de objetos Medico con los datos de todos los médicos
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Medico> obtenerMedicos() throws SQLException {
        List<Medico> medicos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        // Consulta SQL para obtener todos los registros de medicos
        String SQL_SELECT = "SELECT * FROM medicos";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Medico medico = new Medico();

                // Establecer los parámetros para cada objeto consulta
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getInt("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));

                medicos.add(medico); // Agrega el objeto a la lista
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return medicos; // Devuelve lista de objetos Medico con todos los datos de los medicos
    }

    /**
     * Obtiene un médico específico a través de su ID.
     *
     * @param id ID del médico a buscar
     * @return Objeto Medico con los datos del médico encontrado
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public Medico obtenerMedico(int id) throws SQLException {
        Medico medico = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        // Consulta SQL para obtener un registro de medico segun su id
        String SQL_SELECT = "SELECT * FROM medicos WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                medico = new Medico();

                // Establecer los parámetros para el objeto medico
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getInt("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return medico; // Devuelve un objeto Medico con toda su informacion
    }

    /**
     * Actualiza un médico existente en la base de datos.
     *
     * @param medico Objeto Medico con los datos actualizados del médico
     * @return Número de registros actualizados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int actualizar(Medico medico) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para actualizar los datos del objeto medico
        String SQL_UPDATE = "UPDATE medicos SET usuario = ?, contrasena = ?, nombre = ?, apellidos = ?, idsucursal = ?, especialidad = ? WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);

            // Establecer los parámetros en la consulta
            stmt.setString(1, medico.getUsuario());
            stmt.setString(2, medico.getContrasena());
            stmt.setString(3, medico.getNombre());
            stmt.setString(4, medico.getApellidos());
            stmt.setInt(5, medico.getIdsucursal());
            stmt.setString(6, medico.getEspecialidad());
            stmt.setInt(7, medico.getId());

            registros = stmt.executeUpdate(); // Ejecutar la actualización
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return registros; // Devuelve el número de registros actualizados
    }

    /**
     * Elimina un médico de la base de datos por su ID.
     *
     * @param id ID del médico a eliminar
     * @return Número de registros eliminados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar un registro de medico
        String SQL_DELETE = "DELETE FROM medicos WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_DELETE);
            stmt.setInt(1, id);

            registros = stmt.executeUpdate(); // Se ejecuta la consulta
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
     * Obtiene una lista de médicos por el ID de su sucursal.
     *
     * @param Idsucursal ID de la sucursal
     * @return Lista de objetos Medico que pertenecen a la sucursal especificada
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Medico> obtenerMedicosPorSucursal(int Idsucursal) throws SQLException {
        List<Medico> medicos = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        // Consulta SQL para obtener a medicos por sucursal
        String sql = "SELECT * FROM medicos WHERE idsucursal = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Idsucursal);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Medico medico = new Medico();

                // Establecer los parámetros para cada objeto consulta
                medico.setId(rs.getInt("id"));
                medico.setUsuario(rs.getString("usuario"));
                medico.setContrasena(rs.getString("contrasena"));
                medico.setNombre(rs.getString("nombre"));
                medico.setApellidos(rs.getString("apellidos"));
                medico.setIdsucursal(rs.getInt("idsucursal"));
                medico.setEspecialidad(rs.getString("especialidad"));

                medicos.add(medico); // Agrega el objeto a la lista
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return medicos; // Devuelve lista de objetos Medico con todos los datos de los medicos
    }

}