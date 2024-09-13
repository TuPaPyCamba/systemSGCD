/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.sgcd.util;


public class Redireccion {

    public static String manejarPagina(String tipoUsuario) {

//        if (tipoUsuario == null) {
//            return "/inicioSesion.jsp";
//        }

        switch (tipoUsuario.toLowerCase()) {
            case "administradores":
                return "/index.jsp";
            case "pacientes":
                return "/index.jsp";
            case "medicos":
                return "/index.jsp";
            default:
                return "/inicioSesion.jsp";
        }
    }

}
