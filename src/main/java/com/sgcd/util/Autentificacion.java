/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.sgcd.util;

import static com.sgcd.util.DatabaseConnection.getConnection;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

public class Autentificacion {

    public boolean autentificacionUsuario(String usuario, String contrasena, HttpSession session) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String SQL_AUTH = "SELECT 'administrador' AS tabla_origen, id, nombre_usuario "
                + "FROM administrador "
                + "WHERE nombre_usuario = ? AND contrasena = ? "
                + "UNION ALL "
                + "SELECT 'paciente' AS tabla_origen, id, nombre_usuario "
                + "FROM paciente "
                + "WHERE nombre_usuario = ? AND contrasena = ? "
                + "UNION ALL "
                + "SELECT 'medico' AS tabla_origen, id, nombre_usuario "
                + "FROM medico "
                + "WHERE nombre_usuario = ? AND contrasena = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_AUTH);

            for (int i = 0; i < 3; i++) {
                stmt.setString(i * 2 + 1, usuario);
                stmt.setString(i * 2 + 2, contrasena);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int usuarioId = rs.getInt("id");
                    String tablaOrigen = rs.getString("tabla_origen");

                    session.setAttribute("userId", usuarioId);
                    session.setAttribute("username", usuario);
                    session.setAttribute("userType", tablaOrigen);

                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
