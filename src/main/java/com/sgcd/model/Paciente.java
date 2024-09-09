package com.sgcd.model;

public class Paciente {
    private int id;
    private String usuario;
    private String contraseña;
    private String nombre;
    private String apellidos;
    private String telefono;
    private String direccion;

    public Paciente(String usuario, String contraseña, String nombre, String apellidos, String telefono, String direccion) {
        this.usuario = usuario;
        this.contraseña = contraseña;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;
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

    public String getContraseña() {
        return contraseña; 
    }
    public void setContraseña(String contraseña) {
        this.contraseña = contraseña; 
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