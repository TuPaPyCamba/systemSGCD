/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.sgcd.util;


public class Redireccion {

    public static String manejarPagina(String tipoUsuario) {
        switch (tipoUsuario) {
            case "administrador":
                return "/SystemSGCD/gestionPaciente.jsp";
            case "paciente":
                return "/SystemSGCD/index.jsp";
            case "medico":
                return "/SystemSGCD/index.jsp";
            default:
                return "/SystemSGCD/inicioSesion.jsp";
        }
    }

}
