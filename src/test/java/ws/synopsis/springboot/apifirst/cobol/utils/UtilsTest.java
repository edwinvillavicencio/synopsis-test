package ws.synopsis.springboot.apifirst.cobol.utils;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UtilsTest {

    @Test
    void testAjustarCadenaRecortar() {
        String resultado = Utils.ajustarCadena("Hola Mundo", 5, "*", "IZQ");
        assertEquals("Hola ", resultado);
    }

    @Test
    void testAjustarCadenaCompletarIzquierda() {
        String resultado = Utils.ajustarCadena("Hola", 6, "*", "DER");
        assertEquals("**Hola", resultado);
    }

    @Test
    void testAjustarCadenaCompletarDerecha() {
        String resultado = Utils.ajustarCadena("Hola", 6, "*", "IZQ");
        assertEquals("Hola**", resultado);
    }

    @Test
    void testAjustarCadenaMismaLongitud() {
        String resultado = Utils.ajustarCadena("Hola", 4, "*", "IZQ");
        assertEquals("Hola", resultado);
    }

    @Test
    void testAjustarCadenaCaracterDiferente() {
        String resultado = Utils.ajustarCadena("123", 5, "0", "DER");
        assertEquals("00123", resultado);
    }

}
