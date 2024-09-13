/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.sgcd.util;

import static com.sgcd.util.DatabaseConnection.getConnection;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

public class Autentificacion {

    public boolean autentificarUsuario(String usuario, String contrasena, HttpSession session) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String SQL_AUTH = "SELECT 'administradores' AS tipoUsuario, id, usuario AS usuario FROM administradores "
                + "WHERE usuario = ? AND contrasena = ? "
                + "UNION ALL "
                + "SELECT 'pacientes' AS tipoUsuario, id, usuario AS usuario FROM pacientes "
                + "WHERE usuario = ? AND contrasena = ? "
                + "UNION ALL "
                + "SELECT 'medicos' AS tipoUsuario, id, usuario AS usuario FROM medicos "
                + "WHERE usuario = ? AND contrasena = ?";

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(SQL_AUTH);

            for (int i = 0; i < 3; i++) {
                stmt.setString(i * 2 + 1, usuario);
                stmt.setString(i * 2 + 2, contrasena);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int usuarioIdInt = rs.getInt("id");
                    String usuarioId = Integer.toString(usuarioIdInt);
                    String tipoUsuario = rs.getString("tipoUsuario");

                    session.setAttribute("usuarioId", usuarioId);
                    session.setAttribute("usuario", usuario);
                    session.setAttribute("tipoUsuario", tipoUsuario);

                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
