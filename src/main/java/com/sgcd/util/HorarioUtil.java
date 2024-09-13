package com.sgcd.util;

import java.util.Arrays;
import java.util.List;

public class HorarioUtil {

    public static List<String> obtenerHorasDisponibles() {
        return Arrays.asList(
                "10:00 AM",
                "10:30 AM",
                "11:00 AM",
                "11:30 AM",
                "12:00 PM",
                "12:30 PM"
        );
    }
}