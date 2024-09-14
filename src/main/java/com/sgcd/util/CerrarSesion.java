/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.sgcd.util;
import jakarta.servlet.http.HttpSession;


public class CerrarSesion {

    public void invalidarSesion(HttpSession session) {
        session.invalidate();
    }
}
