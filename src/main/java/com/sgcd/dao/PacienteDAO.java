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

/**
 * Clase PacienteDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Paciente.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de Pacientes.
 */
public class PacienteDAO {

    /**
     * Crea un nuevo registro de paciente en la base de datos.
     *
     * @param paciente Objeto Paciente con los datos del nuevo paciente
     * @return Número de registros creados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int create(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para insertar un nuevo registro de paciente
        String SQL_INSERT = "INSERT INTO pacientes(usuario, contrasena, nombre, apellidos, telefono, direccion) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);

            // Establecer los parámetros en la consulta
            stmt.setString(1, paciente.getUsuario());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());

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
     * Actualiza un paciente existente en la base de datos.
     *
     * @param paciente Objeto Paciente con los datos actualizados del paciente
     * @return Número de registros actualizados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int actualizar(Paciente paciente) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para actualizar los datos del objeto paciente
        String SQL_UPDATE = "UPDATE pacientes SET usuario = ?, contrasena = ?, nombre = ?, apellidos = ?, telefono = ?, direccion = ? WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_UPDATE);

            // Establecer los parámetros en la consulta
            stmt.setString(1, paciente.getUsuario());
            stmt.setString(2, paciente.getContrasena());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());
            stmt.setInt(7, paciente.getId());

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
     * Elimina un paciente de la base de datos por su ID.
     *
     * @param id ID del paciente a eliminar
     * @return Número de registros eliminados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar un registro de paciente
        String SQL_DELETE = "DELETE FROM pacientes WHERE id = ?";

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
     * Obtiene todos los registros de pacientes en la base de datos.
     *
     * @return Lista de objetos Paciente con los datos de todos los pacientes
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Paciente> obtenerPacientes() throws SQLException {
        List<Paciente> pacientes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        // Consulta SQL para obtener todos los registros de pacientes
        String SQL_SELECT_ALL = "SELECT * FROM pacientes";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Paciente paciente = new Paciente();

                // Establecer los parámetros para cada objeto consulta
                paciente.setId(rs.getInt("id"));
                paciente.setUsuario(rs.getString("usuario"));
                paciente.setContrasena(rs.getString("contrasena"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setApellidos(rs.getString("apellidos"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));

                pacientes.add(paciente); // Agrega el objeto a la lista
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return pacientes; // Devuelve lista de objetos Paciente con todos los datos de los pacientes
    }
}