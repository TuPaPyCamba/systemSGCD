package com.sgcd.model;

import java.time.LocalDate;

public class Consulta {
    private int id;
    private int idPaciente;
    private int idMedico;
    private int idsucursal;
    private LocalDate fecha;
    private String hora;
    private String descripcion;

    public Consulta() {
    }

    public Consulta(int id, int idPaciente, int idMedico, int idsucursal, LocalDate fecha, String hora, String descripcion) {
        this.id = id;
        this.idPaciente = idPaciente;
        this.idMedico = idMedico;
        this.idsucursal = idsucursal;
        this.fecha = fecha;
        this.hora = hora;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public int getIdPaciente() { return idPaciente; }

    public void setIdPaciente(int idPaciente) { this.idPaciente = idPaciente; }

    public int getIdMedico() { return idMedico; }

    public void setIdMedico(int idMedico) { this.idMedico = idMedico; }

    public int getIdsucursal() { return idsucursal; }

    public void setIdsucursal(int idsucursal) { this.idsucursal = idsucursal; }

    public LocalDate getFecha() { return fecha; }

    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public String getHora() { return hora; }

    public void setHora(String hora) { this.hora = hora; }

    public String getDescripcion() { return descripcion;}

    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}