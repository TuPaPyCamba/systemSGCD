package com.sgcd.model;

import java.time.LocalDateTime;

public class Cita {
    private int id;
    private int idPaciente;
    private int idMedico;
    private LocalDateTime fechaHora;
    private String descripcion;
    private int duracion;

    public Cita() {
    }

    public Cita(int idpaciente, int idmedico, LocalDateTime fechaHora, String descripcion, int duracion) {
        this.idPaciente = idpaciente;
        this.idMedico = idmedico;
        this.fechaHora = fechaHora;
        this.descripcion = descripcion;
        this.duracion = duracion;
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

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

}