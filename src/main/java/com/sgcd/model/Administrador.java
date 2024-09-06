package com.sgcd.model;

public class Administrador {
    private int id;
    private String usuario;
    private String contraseña;
    private String nombre;
    private String apellidos;

    public Administrador(int id, String usuario, String contraseña, String nombre, String apellidos) {
        this.id = id;
        this.usuario = usuario;
        this.contraseña = contraseña;
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

    // Métodos para gestionar usuarios y consultas
    public void agregarPaciente(Paciente paciente) {

    }

    public void eliminarPaciente(int id) {

    }

    public void agregarMedico(Medico medico) {

    }

    public void eliminarMedico(int id) {

    }

    public void agregarConsulta(Consulta consulta) {

    }

    public void eliminarConsulta(int id) {

    }
}
