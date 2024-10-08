package com.sgcd.model;

public class Administrador {
    private int id;
    private String usuario;
    private String contrasena;
    private int idsucursal;
    private String nombre;
    private String apellidos;

    public Administrador(){
    }

    public Administrador(String usuario, String contrasena, int idsucursal, String nombre, String apellidos) {
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.idsucursal = idsucursal;
        this.nombre = nombre;
        this.apellidos = apellidos;
    }

    public Administrador(int id, String usuario, String contrasena, int idsucursal, String nombre, String apellidos) {
        this.id = id;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.idsucursal = idsucursal;
        this.nombre = nombre;
        this.apellidos = apellidos;
    }

    // Getters y Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public int getIdsucursal() {
        return idsucursal;
    }

    public void setIdsucursal(int idsucursal) {
        this.idsucursal = idsucursal;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
}
