package com.sgcd.dao;

import com.sgcd.model.Cita;
import com.sgcd.util.HorarioUtil;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase CitaDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Cita.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de Citas.
 */
public class CitaDAO {

    /**
     * Crear una cita en la base de datos.
     *
     * @param idpaciente  ID del paciente
     * @param idmedico    ID del medico
     * @param idsucursal  ID de la sucursal donde se realiza la cita
     * @param fecha       Fecha de la cita
     * @param hora        Hora de la cita
     * @param descripcion Descripción de la cita
     * @return            true si la cita se creó exitosamente, false si el horario estaba ocupado
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public boolean crearCita(int idpaciente, int idmedico, int idsucursal, LocalDate fecha, String hora, String descripcion) {
        // Verificar si el horario ya está ocupado por el médico
        if (esHorarioOcupadoParaMedico(idmedico, fecha, hora)) {
            System.out.println("El Medico ya tiene una cita en este horario.");
            return false;
        }

        // Consulta SQL para insertar una nueva cita
        String sql = "INSERT INTO citas (idpaciente, idmedico, idsucursal, fecha, hora, descripcion) VALUES (?, ?, ?, ?, ?, ?)";

        // Establece la conexión a la base de datos
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer los parámetros en la consulta
            stmt.setInt(1, idpaciente);
            stmt.setInt(2, idmedico);
            stmt.setInt(3, idsucursal);
            stmt.setDate(4, Date.valueOf(fecha));
            stmt.setString(5, hora);
            stmt.setString(6, descripcion);

            // Ejecutar la consulta y verificar si la inserción fue exitosa
            int filasInsertadas = stmt.executeUpdate();

            if (filasInsertadas > 0) {
                System.out.println("Cita creada exitosamente.");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        }
        return false; // Devuelve true si la cita se creó exitosamente, false si el horario estaba ocupado
    }

    /**
     * Verifica si el horario está ocupado para un médico en una fecha y hora específicas.
     *
     * @param idMedico ID del médico
     * @param fecha    Fecha de la cita
     * @param hora     Hora de la cita
     * @return         true si el horario está ocupado, false si está disponible
     */
    private boolean esHorarioOcupadoParaMedico(int idMedico, LocalDate fecha, String hora) {
        // Consulta SQL para verificar si ya hay una cita programada para el médico en el horario dado
        String sql = "SELECT COUNT(*) FROM citas WHERE idmedico = ? AND DATE(fecha) = ? AND hora = ?";

        // Establece la conexión a la base de datos
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer los parámetros en la consulta
            stmt.setInt(1, idMedico);
            stmt.setDate(2, Date.valueOf(fecha));
            stmt.setString(3, hora);

            // Ejecutar la consulta y verificar si el resultado es mayor a 0
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        }
        return false; // Devuelve true si el horario está ocupado, false si está disponible
    }

    /**
     * Verifica si el horario está ocupado para un paciente en una fecha y hora específicas.
     *
     * @param idpaciente ID del paciente
     * @param fecha    Fecha de la cita
     * @param hora     Hora de la cita
     * @return         true si el horario está ocupado, false si está disponible
     */
    private boolean esHorarioOcupadoParaPaciente(int idpaciente, LocalDate fecha, String hora) {
        // Consulta SQL para verificar si ya hay una cita programada para el paciente en el horario dado
        String sql = "SELECT COUNT(*) FROM citas WHERE idpaciente = ? AND DATE(fecha) = ? AND hora = ?";

        // Establece la conexión a la base de datos
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer los parámetros en la consulta
            stmt.setInt(1, idpaciente);
            stmt.setDate(2, Date.valueOf(fecha));
            stmt.setString(3, hora);

            // Ejecutar la consulta y verificar si el resultado es mayor a 0
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        }
        return false; // Devuelve true si el horario está ocupado, false si está disponible
    }

    /**
     * Elimina una cita de la base de datos según su ID.
     *
     * @param id ID de la cita a eliminar
     * @return   Número de registros eliminados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int delete(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar una cita
        String SQL_DELETE = "DELETE FROM citas WHERE id = ?";

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
     * Actualiza una cita en la base de datos.
     *
     * @param cita Objeto Cita con los datos actualizados
     * @return     Número de registros actualizados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int update(Cita cita) throws SQLException {
        // Consulta SQL para actualizar los datos del objeto cita
        String sql = "UPDATE citas SET idpaciente = ?, idmedico = ?, idsucursal = ?, fecha = ?, hora = ?, descripcion = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            // Establece la conexión a la base de datos
            con = getConnection();
            stmt = con.prepareStatement(sql);
            // Establecer los parámetros en la consulta
            stmt.setInt(1, cita.getIdPaciente());
            stmt.setInt(2, cita.getIdMedico());
            stmt.setInt(3, cita.getIdsucursal());
            stmt.setDate(4, java.sql.Date.valueOf(cita.getFecha()));
            stmt.setString(5, cita.getHora());
            stmt.setString(6, cita.getDescripcion());
            stmt.setInt(7, cita.getId());

            registros = stmt.executeUpdate(); // Ejecutar la actualización
        } catch (SQLException ex) {
          ex.printStackTrace(System.out);  // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros; // Devuelve el número de registros actualizados
    }

    /**
     * Obtiene las horas de citas para un médico en un día específico.
     *
     * @param idmedico ID del médico para filtrar las citas
     * @param fecha    Fecha en la cual buscar las citas
     * @return         Lista de horas de las citas del médico en ese día
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<String> obtenerCitasPorMedicoYDia(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        // Consulta SQL para obtener los registros de cita segun el medico y dia
        String sql = "SELECT hora FROM citas WHERE idmedico = ? AND fecha = ?";
        List<String> citas = new ArrayList<>();

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Asigna los parámetros idmedico y fecha a la consulta
            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

            // Ejecuta la consulta y obtiene los resultados
            ResultSet rs = stmt.executeQuery();

            // Recorre los resultados para agregar las horas a la lista
            while (rs.next()) {
                citas.add(rs.getString("hora"));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas; // Devuelve lista de horas de las citas del médico en ese día
    }

    /**
     * Obtiene las horas de citas de un paciente en un día específico.
     *
     * @param idpaciente ID del paciente para filtrar las citas
     * @param fecha      Fecha en la cual buscar las citas
     * @return           Lista de horas de las citas del paciente en ese día
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<String> obtenerCitasPorPacienteYDia (int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        // Consulta SQL para obtener los registros de cita segun el paciente y dia
        String sql = "SELECT hora FROM citas WHERE idpaciente = ? AND fecha = ?";
        List<String> citas = new ArrayList<>();

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Asigna los parámetros idpaciente y fecha a la consulta
            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

            // Ejecuta la consulta y obtiene los resultados
            ResultSet rs = stmt.executeQuery();

            // Recorre los resultados para agregar las horas a la lista
            while (rs.next()) {
                citas.add(rs.getString("hora"));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas; // Devuelve Lista de horas de las citas del paciente en ese día
    }

    /**
     * Obtiene las horas disponibles para citas de un médico en un día específico,
     * excluyendo las horas ya ocupadas por citas existentes.
     *
     * @param idMedico ID del médico para filtrar las citas
     * @param dia      Día para buscar las horas disponibles
     * @return         Lista de horas disponibles para citas
     */
    public List<String> obtenerHorasDisponiblesParaCitas(int idMedico, LocalDate dia) {

        // Lista de horas permitidas para citas
        List<String> todasLasHoras = HorarioUtil.obtenerHorasDisponiblesParaCitas();
        // Lista de horas ocupadas
        List<String> citasOcupadas = new CitaDAO().obtenerCitasPorMedicoYDia(idMedico, dia);

        // Eliminar las horas ocupadas de la lista de horas disponibles
        List<String> horasDisponibles = new ArrayList<>(todasLasHoras);
        horasDisponibles.removeAll(citasOcupadas);

        System.out.println(horasDisponibles);

        return horasDisponibles; // Devuelve Lista de horas disponibles para citas ese dia
    }

    /**
     * Obtiene todas las citas almacenadas en la base de datos.
     *
     * @return         Lista de objetos Cita con todos los datos de las citas
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Cita> findAllCitas() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        // Consulta SQL para obtener todos los registros de citas
        String sql = "SELECT * FROM citas";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Cita cita = new Cita();
                // Establecer los parámetros para cada objeto cita
                cita.setId(rs.getInt("id"));
                cita.setIdMedico(rs.getInt("idmedico"));
                cita.setIdPaciente(rs.getInt("idpaciente"));
                cita.setIdsucursal(rs.getInt("idsucursal"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getString("hora"));
                cita.setDescripcion(rs.getString("descripcion"));

                citas.add(cita); // Agrega el objeto a la lista
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
            if (rs != null) close(rs);
        }
        return citas; // Devuelve lista de objetos Cita con todos los datos de las citas
    }

    /**
     * Obtiene todas las citas de un médico en un día específico.
     *
     * @param idmedico ID del médico para filtrar las citas
     * @param fecha    Fecha en la cual buscar las citas
     * @return         Lista de objetos Cita con los datos de las citas del médico
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Cita> obtenerTodasCitas(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        // Consulta SQL para todas las citas de un médico en un día específico
        String sql = "SELECT * FROM citas WHERE idmedico = ? AND fecha = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            // Recorre el resultado de la consulta y crea objetos Cita
            while (rs.next()) {
                Cita cita = new Cita();

                // Establecer los parámetros para cada objeto Cita
                cita.setId(rs.getInt("id"));
                cita.setIdMedico(rs.getInt("idmedico"));
                cita.setIdPaciente(rs.getInt("idpaciente"));
                cita.setIdsucursal(rs.getInt("idsucursal"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getString("hora"));
                cita.setDescripcion(rs.getString("descripcion"));

                citas.add(cita); // Agrega el objeto a la lista
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas; // Devuelve Lista de objetos Cita con los datos de las citas del médico
    }

    /**
     * Obtiene todas las citas de un paciente en un día específico.
     *
     * @param idpaciente ID del paciente para filtrar las citas
     * @param fecha      Fecha en la cual buscar las citas
     * @return           Lista de objetos Cita con los datos de las citas del paciente
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Cita> obtenerTodasCitasPorPaciente(int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Cita> citas = new ArrayList<>();
        // Consulta SQL para todas las citas de un paciente en un día específico
        String sql = "SELECT * FROM citas WHERE idpaciente = ? AND fecha = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            // Recorre el resultado de la consulta y crea objetos Cita
            while (rs.next()) {
                Cita cita = new Cita();

                // Establecer los parámetros para cada objeto Cita
                cita.setId(rs.getInt("id"));
                cita.setIdMedico(rs.getInt("idmedico"));
                cita.setIdPaciente(rs.getInt("idpaciente"));
                cita.setIdsucursal(rs.getInt("idsucursal"));
                cita.setFecha(rs.getDate("fecha").toLocalDate());
                cita.setHora(rs.getString("hora"));
                cita.setDescripcion(rs.getString("descripcion"));

                citas.add(cita); // Agrega el objeto a la lista
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return citas; // Devuelve Lista de objetos Cita con los datos de las citas del paciente
    }
}

