package ws.synopsis.springboot.apifirst.cobol.utils;

public class Utils {
    public static String ajustarCadena(String cadenaOriginal, int longitud, String caracterCompletar, String alinear) {
        // Convertimos a minúsculas para facilitar la comparación
        alinear = alinear.toUpperCase();

        // Si la cadena original es más larga, cortamos
        if (cadenaOriginal.length() > longitud) {
            return cadenaOriginal.substring(0, longitud);
        }

        // Si la cadena original es más corta, completamos
        StringBuilder cadenaAjustada = new StringBuilder(cadenaOriginal);
        while (cadenaAjustada.length() < longitud) {
            if (alinear.equals("DER")) {
                cadenaAjustada.insert(0, caracterCompletar);
            } else {
                cadenaAjustada.append(caracterCompletar);
            }
        }

        return cadenaAjustada.toString();
    }
}
