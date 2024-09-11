package com.sgcd.util;

import java.sql.Connection;
import java.sql.*;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/sistema_dental";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se pudo cargar el controlador JDBC", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void close(AutoCloseable ac) {
        if (ac != null) {
            try {
                ac.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

//    public static void main(String[] args) throws SQLException {
//        Connection conn = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        String SQL_SELECT_BY_ID = "SELECT * FROM pacientes";
//        try {
//            conn = getConnection();
//            stmt = conn.prepareStatement(SQL_SELECT_BY_ID);
//            rs = stmt.executeQuery();
//            while (rs.next()) {
//                System.out.println(rs.getInt("id") + " " + rs.getString("nombre"));
//            }
//        } catch (Exception e) {
//            System.out.println(e);
//        } finally {
//            if (rs != null) {
//                close(rs);
//            }
//            if (stmt != null) {
//                close(stmt);
//            }
//            if (conn != null) {
//                close(conn);
//            }
//        }
//    }
}
