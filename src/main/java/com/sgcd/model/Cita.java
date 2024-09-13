package com.sgcd.model;

import java.time.LocalDate;

public class Cita {
    private int id;
    private int idPaciente;
    private int idMedico;
    private LocalDate fecha;
    private String hora;
    private String descripcion;

    public Cita() {
    }

    public Cita(int idpaciente, int idmedico, LocalDate fecha, String hora, String descripcion) {
        this.idPaciente = idpaciente;
        this.idMedico = idmedico;
        this.fecha = fecha;
        this.hora = hora;
        this.descripcion = descripcion;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idpaciente) {
        this.idPaciente = idpaciente;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idmedico) {
        this.idMedico = idmedico;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getHora() { return hora; }

    public void setHora(String hora) { this.hora = hora; }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}