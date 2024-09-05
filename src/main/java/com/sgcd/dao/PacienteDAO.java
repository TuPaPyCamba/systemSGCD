package com.sgcd.dao;

import com.sgcd.model.Paciente;
import com.sgcd.util.DatabaseConfig;
import static com.sgcd.util.DatabaseConfig.close;
import static com.sgcd.util.DatabaseConfig.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PacienteDAO {

    private static final String SQL_INSERT = "INSERT INTO Pacientes (usuario, contraseña, nombre, apellidos, telefono, direccion, aprobado) VALUES (?, ?, ?, ?, ?, ?, ?)";  

    public int insertar(Paciente paciente) {
        Connection conn = null;
        PreparedStatement stmt = null;
        int registros = 0;
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_INSERT);
            stmt.setString(1, paciente.getPaciente());
            stmt.setString(2, paciente.getContraseña());
            stmt.setString(3, paciente.getNombre());
            stmt.setString(4, paciente.getApellidos());
            stmt.setString(5, paciente.getTelefono());
            stmt.setString(6, paciente.getDireccion());
            stmt.setBoolean(7, paciente.isAprobado());
            stmt.executeUpdate();

            registros = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(System.out);
        }finally{
            if(stmt != null)
        try{
            close(stmt); 
        }catch(Exception e){
            System.out.println("Problema con el cierre de Statement DB");
        }
            if(conn != null)
        try{
            close(conn);
        }catch(Exception e){
            System.out.println("Problema con el cierre de conexion DB");
        }
        }
        return registros;
    }

    // Métodos adicionales para actualizar, borrar y obtener pacientes
}