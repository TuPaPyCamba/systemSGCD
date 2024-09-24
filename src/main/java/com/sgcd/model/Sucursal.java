package com.sgcd.model;

public class Sucursal {
    private int idsucursal;
    private String nombre;
    private String direccion;
    private String telefono;
    private String ciudad;
    private String estado;
    private String pais;

    public Sucursal(){
    }

    public Sucursal(int idsucursal, String nombre, String direccion, String telefono, String ciudad, String estado, String pais) {
        this.idsucursal = idsucursal;
        this.nombre = nombre;
        this.direccion = direccion;
        this.telefono = telefono;
        this.ciudad = ciudad;
        this.estado = estado;
        this.pais = pais;
    }

    // Getters y Setters
    public int getIdsucursal() { return idsucursal; }

    public void setIdsucursal(int idsucursal) { this.idsucursal = idsucursal; }

    public String getNombre() { return nombre; }

    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDireccion() { return direccion; }

    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getTelefono() { return telefono; }

    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCiudad() { return ciudad; }

    public void setCiudad(String ciudad) { this.ciudad = ciudad; }

    public String getEstado() { return estado; }

    public void setEstado(String estado) { this.estado = estado; }

    public String getPais() { return pais; }

    public void setPais(String pais) {
        this.pais = pais;
    }
}