package com.sgcd.util;

import java.sql.*;

public class DatabaseConfig {

    private static final String URL = "jdbc:mysql://localhost:3306/sgcd";
    private static final String USER = "root";
    private static final String PASSWORD = "password";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
     public static void close(ResultSet rs) throws SQLException {
        rs.close();
    }

    public static void close(Statement stmt) throws SQLException {
        stmt.close();
    }

    public static void close(PreparedStatement stmt) throws SQLException {
        stmt.close();
    }
    
    public static void close(Connection conn) throws SQLException {
        conn.close();
    }
}