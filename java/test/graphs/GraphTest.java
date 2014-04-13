
public class GraphTest{
     @Test
     public void testGraph() {

        // MyClass is tested
        MyClass tester = new MyClass();

        // check if multiply(10,5) returns 50
        assertEquals("10 x 5 must be 50", 50, tester.multiply(10, 5));
      }
}