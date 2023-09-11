import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class StringCalculatorSpecToJUnit {

    @Test
    void testEmptyString() {
        Assertions.assertEquals(0, StringCalculator.add(""));
    }

    @Test
    void testOneNumber() {
        Assertions.assertEquals(4, StringCalculator.add("4"));
        Assertions.assertEquals(10, StringCalculator.add("10"));
    }

    @Test
    void testTwoNumbers() {
        Assertions.assertEquals(6, StringCalculator.add("2,4"));
        Assertions.assertEquals(117, StringCalculator.add("17,100"));
    }
}
