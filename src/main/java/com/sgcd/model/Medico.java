package com.sgcd.model;

public class Medico {
    private int id;
    private String usuario;
    private String contrasena;
    private String email;
    private String nombre;
    private String apellidos;
    private String idsucursal;
    private String especialidad;

    public Medico() {

    }

    public Medico(int id, String usuario, String contrasena, String email, String nombre, String apellidos, String idsucursal, String especialidad) {
        this.id = id;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.email = email;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.idsucursal = idsucursal;
        this.especialidad = especialidad;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getIdsucursal() {
        return idsucursal;
    }

    public void setIdsucursal(String idsucursal) {
        this.idsucursal = idsucursal;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }
}