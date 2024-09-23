package com.sgcd.dao;

import com.sgcd.model.Consulta;
import com.sgcd.util.HorarioUtil;
import static com.sgcd.util.DatabaseConnection.close;
import static com.sgcd.util.DatabaseConnection.getConnection;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase ConsultaDAO.
 * Esta clase se encarga de la interacción con la base de datos para la entidad Consulta.
 * Contiene métodos para crear, actualizar, eliminar y obtener registros de Consultas.
 */
public class ConsultaDAO {

    /**
     * Crear una consulta en la base de datos.
     *
     * @param idpaciente  ID del paciente
     * @param idmedico    ID del medico
     * @param idsucursal  ID de la sucursal donde se realiza la consulta
     * @param fecha       Fecha de la consulta
     * @param hora        Hora de la consulta
     * @param descripcion Descripción de la consulta
     * @return            true si la consulta se creó exitosamente, false si el horario estaba ocupado
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public boolean crearConsulta(int idpaciente, int idmedico, int  idsucursal, LocalDate fecha, String hora, String descripcion) {
        // Verificar si el horario ya está ocupado para el Paciente
        if (esHorarioOcupadoParaPaciente(idpaciente, fecha, hora) && esHorarioOcupadoParaMedico(idmedico, fecha, hora)) {
            System.out.println("El Paciente ya tiene una consulta programada en ese horario.");
            return false;
        }

        // Consulta SQL para insertar una nueva consulta
        String sql = "INSERT INTO consultas (idpaciente, idmedico, idsucursal, fecha, hora, descripcion) VALUES (?, ?, ?, ?, ?, ?)";

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
                System.out.println("Consulta creada exitosamente.");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        }
        return false; // Devuelve true si la consulta se creó exitosamente, false si el horario estaba ocupado
    }

    /**
     * Verifica si el horario está ocupado para un médico en una fecha y hora específicas.
     *
     * @param idmedico ID del médico
     * @param fecha    Fecha de la consulta
     * @param hora     Hora de la consulta
     * @return         true si el horario está ocupado, false si está disponible
     */
    private boolean esHorarioOcupadoParaMedico(int idmedico, LocalDate fecha, String hora) {
        // Consulta SQL para verificar si ya hay una consulta programada para el médico en el horario dado
        String sql = "SELECT COUNT(*) FROM consultas WHERE idmedico = ? AND DATE(fecha) = ? AND hora = ?";

        // Establece la conexión a la base de datos
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Establecer los parámetros en la consulta
            stmt.setInt(1, idmedico);
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
     * @param idpaciente ID del médico
     * @param fecha    Fecha de la consulta
     * @param hora     Hora de la consulta
     * @return         true si el horario está ocupado, false si está disponible
     */
    private boolean esHorarioOcupadoParaPaciente(int idpaciente, LocalDate fecha, String hora) {
        // Consulta SQL para verificar si ya hay una consulta programada para el paciente en el horario dado
        String sql = "SELECT COUNT(*) FROM consultas WHERE idpaciente = ? AND DATE(fecha) = ? AND hora = ?";

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
     * Elimina una consulta de la base de datos según su ID.
     *
     * @param id ID de la consulta a eliminar
     * @return   Número de registros eliminados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int delete(int id) throws SQLException {
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;
        // Consulta SQL para eliminar una consulta
        String sql = "DELETE FROM consultas WHERE id = ?";

        try {
            // Establece la conexión a la base de datos
            con = getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);
            registros = stmt.executeUpdate(); // Se ejecuta la consulta
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros; // Devuelve la cantidad de registros eliminados
    }

    /**
     * Actualiza una consulta en la base de datos.
     *
     * @param consulta Objeto Consulta con los datos actualizados
     * @return     Número de registros actualizados
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public int update(Consulta consulta) throws SQLException {
        // Consulta SQL para actualizar los datos del objeto consulta
        String sql = "UPDATE consultas SET idpaciente = ?, idmedico = ?, idsucursal = ?, fecha = ?, hora = ?, descripcion = ? WHERE id = ?";
        Connection con = null;
        PreparedStatement stmt = null;
        int registros = 0;

        try {
            // Establece la conexión a la base de datos
            con = getConnection();
            stmt = con.prepareStatement(sql);

            // Establecer los parámetros en la consulta
            stmt.setInt(1, consulta.getIdPaciente());
            stmt.setInt(2, consulta.getIdMedico());
            stmt.setInt(3, consulta.getIdsucursal());
            stmt.setDate(4, java.sql.Date.valueOf(consulta.getFecha()));
            stmt.setString(5, consulta.getHora());
            stmt.setString(6, consulta.getDescripcion());
            stmt.setInt(7, consulta.getId());

            registros = stmt.executeUpdate(); // Ejecutar la actualización
        } catch (SQLException ex){
          ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (con != null) close(con);
        }
        return registros; // Devuelve el número de registros actualizados
    }

    /**
     * Obtiene las horas de consultas para un paciente en un día específico.
     *
     * @param idpaciente ID del paciente para filtrar las consultas
     * @param fecha    Fecha en la cual buscar las consultas
     * @return         Lista de horas de las consultas del paciente en ese día
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<String> obtenerConsultasPorPacienteYDia(int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        // Consulta SQL para obtener los registros de consulta segun el paciente y dia
        String sql = "SELECT * FROM consultas WHERE idpaciente = ? AND fecha = ?";
        List<String> consultas = new ArrayList<>();

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);

            // Asigna los parámetros idmedico y fecha a la consulta
            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));

            // Ejecuta la consulta y obtiene los resultados
            ResultSet rs = stmt.executeQuery();

            // Recorre los resultados para agregar las horas a la lista
            while (rs.next()) {
                consultas.add(rs.getString("hora"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas; // Devuelve lista de horas de las consultas del paciente en ese día
    }

    /**
     * Obtiene las horas de Consultas para un médico en un día específico.
     *
     * @param idmedico ID del médico para filtrar las Consultas
     * @param fecha    Fecha en la cual buscar las Consultas
     * @return         Lista de horas de las Consultas del médico en ese día
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public  List<String> obtenerConsultasPorMedicoYDia(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        // Consulta SQL para obtener los registros de consulta segun el medico y dia
        String sql = "SELECT * FROM consultas WHERE idmedico = ? AND fecha = ?";
        List<String> consultas = new ArrayList<>();

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
                consultas.add(rs.getString("hora"));
            }
        } catch (Exception e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas; // Devuelve lista de horas de las consultas del médico en ese día
    }

    /**
     * Obtiene las horas disponibles para consultas de un paciente en un día específico,
     * excluyendo las horas ya ocupadas por consultas existentes.
     *
     * @param idpaciente ID del paciente para filtrar las consultas
     * @param fecha      Día para buscar las horas disponibles
     * @return         Lista de horas disponibles para consultas
     */
    public List<String> obtenerHorasDisponiblesParaConsultaPorPaciente(int idpaciente, LocalDate fecha) {

        // Lista de horas permitidas para consultas
        List<String> todasLasHoras = HorarioUtil.obtenerHorasDisponiblesParaConsulta();
        // Lista de horas ocupadas
        List<String> consultasOcupadas = new ConsultaDAO().obtenerConsultasPorPacienteYDia(idpaciente, fecha);

        // Eliminar las horas ocupadas de la lista de horas disponibles
        List<String> horasDisponibles = new ArrayList<>(todasLasHoras);
        horasDisponibles.removeAll(consultasOcupadas);

        return horasDisponibles; // Devuelve Lista de horas disponibles para consultas ese dia
    }

    /**
     * Obtiene todas las consultas almacenadas en la base de datos.
     *
     * @return         Lista de objetos consulta con todos los datos de las consultas
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Consulta> findAllConsultas() throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Consulta> consultas = new ArrayList<>();
        // Consulta SQL para obtener todos los registros de consultas
        String SQL_SELECT_ALL = "SELECT * FROM consultas";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Consulta consulta = new Consulta();

                // Establecer los parámetros para cada objeto consulta
                consulta.setId(rs.getInt("id"));
                consulta.setIdPaciente(rs.getInt("idpaciente"));
                consulta.setIdMedico(rs.getInt("idmedico"));
                consulta.setIdsucursal(rs.getInt("idsucursal"));
                consulta.setFecha(rs.getDate("fecha").toLocalDate());
                consulta.setHora(rs.getString("hora"));
                consulta.setDescripcion(rs.getString("descripcion"));

                consultas.add(consulta); // Agrega el objeto a la lista
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas; // Devuelve lista de objetos Consulta con todos los datos de las consultas
    }

    /**
     * Obtiene todas las consultas de un médico en un día específico.
     *
     * @param idmedico ID del médico para filtrar las consultas
     * @param fecha    Fecha en la cual buscar las consultas
     * @return         Lista de objetos Consulta con los datos de las consultas del médico
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Consulta> obtenerTodasConsultas(int idmedico, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Consulta> consultas = new ArrayList<>();
        // Consulta SQL para todas las citas de un médico en un día específico
        String sql = "SELECT * FROM consultas WHERE idmedico = ? AND fecha = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idmedico);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            // Recorre el resultado de la consulta y crea objetos Consulta
            while (rs.next()) {
                    Consulta consulta = new Consulta();

                    // Establecer los parámetros para cada objeto Cita
                    consulta.setId(rs.getInt("id"));
                    consulta.setIdMedico(rs.getInt("idmedico"));
                    consulta.setIdPaciente(rs.getInt("idpaciente"));
                    consulta.setIdsucursal(rs.getInt("idsucursal"));
                    consulta.setFecha(rs.getDate("fecha").toLocalDate());
                    consulta.setHora(rs.getString("hora"));
                    consulta.setDescripcion(rs.getString("descripcion"));

                    consultas.add(consulta); // Agrega el objeto a la lista
                }

        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas; // Devuelve Lista de objetos Consulta con los datos de las consultas del médico
    }

    /**
     * Obtiene todas las consulta de un paciente en un día específico.
     *
     * @param idpaciente ID del paciente para filtrar las consulta
     * @param fecha      Fecha en la cual buscar las consulta
     * @return           Lista de objetos Consulta con los datos de las consultas del paciente
     * @throws SQLException Si ocurre un error en la base de datos.
     */
    public List<Consulta> obtenerTodasConsultasParaPaciente(int idpaciente, LocalDate fecha) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Consulta> consultas = new ArrayList<>();
        // Consulta SQL para todas las consultas de un paciente en un día específico
        String sql = "SELECT * FROM consultas WHERE idpaciente = ? AND fecha = ?";

        try {
            // Establece la conexión a la base de datos
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idpaciente);
            stmt.setDate(2, java.sql.Date.valueOf(fecha));
            rs = stmt.executeQuery();

            // Recorre el resultado de la consulta y crea objetos Cita
            while (rs.next()) {
                Consulta consulta = new Consulta();

                // Establecer los parámetros para cada objeto Cita
                consulta.setId(rs.getInt("id"));
                consulta.setIdMedico(rs.getInt("idmedico"));
                consulta.setIdPaciente(rs.getInt("idpaciente"));
                consulta.setIdsucursal(rs.getInt("idsucursal"));
                consulta.setFecha(rs.getDate("fecha").toLocalDate());
                consulta.setHora(rs.getString("hora"));
                consulta.setDescripcion(rs.getString("descripcion"));

                consultas.add(consulta); // Agrega el objeto a la lista
            }

        } catch (SQLException e) {
            e.printStackTrace(System.out); // Manejo de excepciones
        } finally {
            // Cierre de recursos
            if (rs != null) close(rs);
            if (stmt != null) close(stmt);
            if (conn != null) close(conn);
        }
        return consultas; // Devuelve Lista de objetos Consulta con los datos de las consultas del paciente
    }
}
