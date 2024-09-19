package com.sgcd.util;

import java.util.Arrays;
import java.util.List;

public class HorarioUtil {

    public static List<String> obtenerHorasDisponiblesParaCitas() {
        return Arrays.asList(
                "10:00 AM",
                "10:30 AM",
                "11:00 AM",
                "11:30 AM",
                "12:00 PM",
                "12:30 PM"
        );
    }

    public  static List<String> obtenerHorasDisponiblesParaConsulta() {
        return Arrays.asList(
                "15:00 PM",
                "16:00 PM",
                "17:00 PM",
                "18:00 PM",
                "19:00 PM"
        );
    }
}