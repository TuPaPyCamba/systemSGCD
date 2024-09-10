package com.sgcd.model;

public class Paciente {
    private int id;
    private String usuario;
    private String contrasena;
    private String nombre;
    private String apellidos;
    private String telefono;
    private String direccion;

    public Paciente(String usuario, String contrasena, String nombre, String apellidos, String telefono, String direccion) {
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;
    }

    public Paciente() {
    }

    // Getters y Setters
    public int getIdPaciente(){
        return id; 
    }
    public void setIdPaciente(int id) {
        this.id = id; 
    }

    public String getPaciente() {
        return usuario; 
    }
    public void setPaciente(String usuario) {
        this.usuario = usuario; 
    }

    public String getContrasena() {
        return contrasena;
    }
    public void setContrasena(String contraseña) {
        this.contrasena = contraseña;
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

    public String getTelefono() {
        return telefono; 
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono; 
    }

    public String getDireccion() {
        return direccion; 
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion; 
    }
}