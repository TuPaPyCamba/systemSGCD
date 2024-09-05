package com.sgcd.dao;

import com.sgcd.model.Paciente;
import com.sgcd.util.DatabaseConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PacienteDAO {

    private Connection getConnection() throws SQLException {
        return DatabaseConfig.getConnection();
    }

    public void addPaciente(Paciente paciente) throws SQLException {
        String query = "INSERT INTO Pacientes (usuario, contraseña, nombre, apellidos, telefono, direccion, aprobado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, paciente.getUsuario());
            statement.setString(2, paciente.getContraseña());
            statement.setString(3, paciente.getNombre());
            statement.setString(4, paciente.getApellidos());
            statement.setString(5, paciente.getTelefono());
            statement.setString(6, paciente.getDireccion());
            statement.setBoolean(7, paciente.isAprobado());
            statement.executeUpdate();
        }
    }

    // Métodos adicionales para actualizar, borrar y obtener pacientes
}