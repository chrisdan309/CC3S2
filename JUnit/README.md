# Tarea JUnit y RSpec

## JUnit architecture

La arquitectura del JUnit5:

### JUnit Platform:

- Lanza testing frameworks en la JVM
- Tiene un TestEngine API usado para build un testing framework que corra en el JUnit platform

### JUnit Jupiter:

- Combina un nuevo modelo de programación para escribir test y un extension mode para extensiones
- Agrega nuevas annotaciones `@BeforeEach`, `@AfterEach`, `@AfterAll`, `BeforeAll`, etc.

### JUnit Vintage:

- Provee soporte para ejecutar versiones previas de JUnit en esta nueva plataforma.

## JUnit Maven Dependencies

Agregamos la siguiente dependencia en un `pom.xml` del proyecto.

- JUnit5 Library

```xml
<dependency>
     <groupId>org.junit.jupiter</groupId>
     <artifactId>junit-jupiter-engine</artifactId>
     <version>5.1.1</version>
     <scope>test</scope>
</dependency>
<dependency>
     <groupId>org.junit.platform</groupId>
     <artifactId>junit-platform-runner</artifactId>
     <version> 1.1.1</version>
     <scope>test</scope>
</dependency>
```

## RSpec

La idea de TDD es que en vez de escribir siempre pruebas para alagún código que ya tenemos, trabajaremos un bucle red-green:

- Escribir el caso de prueba más pequeño posible que coincida con lo que necesitamos programar
- Corre el test y míralo fallar. Eso te hará pensar como escribir el código para que pase la prueba.
- Esscribir el código para lograr que pase el test.
- Corre el conjunto de tests hasta que pases todos los tests.
- Regresa y refactoriza tu nuevo código para hacerlo lo más simple y claro posible manteniendo test suite green.

Este flujo de trabajo implica un "paso cero": Pensando cuidadosamente en que exactamente es lo que debemos construir y como. Cuando comenzamos con la implementación es fácil desenfocarse y escribir código innecesario.

El BDD es una idea construida sobre el TDD. La idea es escribir los tests como especificaciones del comportamiento del sistema. Abordamos el mismo reto de una forma diferente, nos lleva a pensar con más claridad a escribir pruebas más fáciles de entender.

Un problema común es escribir tests que abarcan mucho, prueban poco y requieren mucho esfuerzo para entender que está ocurriendo.

El siguiente ejemplo es escrito usando test-unit, un testing framework que es parte de la librería estándar de Ruby.

```ruby
def test_making_order
  book = Book.new(:title => "RSpec Intro", :price => 20)
  customer = Customer.new
  order = Order.new(customer, book)

  order.submit

  assert(customer.orders.last == order)
  assert(customer.ordered_books.last == book)
  assert(order.complete?)
  assert(!order.shipped?)
end
```

Con RSpec podemos usar más el lenguaje común describiendo el comportamiento.

```ruby
describe Order do
  describe "#submit" do

    before do
      @book = Book.new(:title => "RSpec Intro", :price => 20)
      @customer = Customer.new
      @order = Order.new(@customer, @book)

      @order.submit
    end

   describe "customer" do
     it "puts the ordered book in customer's order history" do
       expect(@customer.orders).to include(@order)
       expect(@customer.ordered_books).to include(@book)
     end
   end

   describe "order" do
     it "is marked as complete" do
       expect(@order).to be_complete
     end

     it "is not yet shipped" do
       expect(@order).not_to be_shipped
     end
   end
  end
end
```

Para un ciclo BDD completo se requeriría de una herramienta como `Cucumber` para escribir un escenario en lenguaje humano.

### RSpec Basics

El tutorial se basará en implementar parte de un `string calculator`, el plan es:

- Crear una simple calculadora con un metodo `int Add(string numbers)`.
- El método puede tomar 0, 1 o 2 números, y retornará su suma. Para un string vacío retornará 0, Por ejemplo los inputs pueden ser "", "1" o "1,2".
- Permitir al método ADD manejar una desconocida cantidad de números.

### Setting Up RSpec

Comenzaremos un nuevo proyecto Ruby donde configuraremos Rpec como una dependencia via bundle.

```ruby
# Gemfile
source "https://rubygems.org"

gem "rspec"
```

Ahora corremos el comando `bundle install --path .bundle` para instsalar la última versión del RSPec y todas sus dependencias relacionadas.

### Writing the First Spec

Por convención, los tests escritos por Rpec son llamados "specs" y dentro del diretorio spec.

Escribimos el iguiente código.

```ruby
# spec/string_calculator_spec.rb
describe StringCalculator do
end
```

Con RSpec siempre describimos le comportamiento de las clases, módulos y sus métodos. El bloque `describe` es siempre usado en la parte superior del spec. Este puede aceptar cualquieer nombre de clase, en tal caso la clase necesita existir.

Corremos los specs con el siguiente comando `bundle exec rspec`

Vamos a tener el error de `uninitialized constant StringCalculator`. El cual se esperaba dado que la clase no había sido creada aún.

Creamos un directorio llamado `lib` y declaramos `StringCalculator` dentro de  `string_calculator.rb`

```ruby
# lib/string_calculator.rb
class StringCalculator
end
```
y agregamos la sentencia `require "string_calculator"` en el spec.

Hemos logrado etablecer un configuración de trabajo en nuestro proyecto. Tenemos un bucle de feedback funcional que incluye tests y código de aplicación.

Ahora continuaremos escribiendo algo de código.

Lo más simple que nuestra calculadora debe hacer es aceptar un string vacío y, en tal caso, retornar ceroa.

```ruby
# spec/string_calculator_spec.rb
require "string_calculator"

describe StringCalculator do
    describe ".add" do
        context "given an empty string" do
            it "returns zero" do
                expect(StringCalculator.add("")).to eql(0)
            end
        end 
    end
end
```

- Utilizamos otro bloque `describe` para describir el método de clase add. Por convención los métodos de clase son denotados por un punto ".add" y los métodos de instancia por un numeral "#add".
- Utilzamos el bloque `context` para describir el contexto bajo el cual se espera que el método add retorne 0.
- Utilizamos el bloque `it` para describir un ejemplo específico, el cual es la forma de RSpec para decir "test case". 
- Finalmente `expect(...).to` y `expect(...).not_to` son usados para definir el output esperado.

Al querer ejecutarlo obtendremos el error de que el método no está definido.

Escribimos el mínimo bloque de código para que pase el spec.

```ruby
# lib/string_calculator.rb
class StringCalculator
    def self.add(input)
        0
    end
end
```

### Towards Working Code

Ahora nuestra tarea es hacer que la calculadora trabaje con solo un número como un string.


```ruby
# spec/string_calculator_spec.rb
require "string_calculator"

describe StringCalculator do
    
    describe ".add" do
        context "given an empty string" do
            it "returns zero" do
                expect(StringCalculator.add("")).to eql(0)
            end
        end 

        context "given '4'" do
            it "returns 4" do
                expect(StringCalculator.add("4")).to eql(4)
            end
        end

        context "given '10'" do
            it "returns 10" do
                expect(StringCalculator.add("10")).to eql(10)
            end
        end
    end
end
```

Ahora vamos a escribir algunos ejemplos basados en strings separados on comas lo cual nos permitirá introducir el siguiente contexto "two numbers".

```ruby
context "two numbers" do
     context "given '2,4'" do
          it "returns 6" do
          expect(StringCalculator.add("2,4")).to eql(6)
          end
     end

     context "given '17,100'" do
          it "returns 117" do
          expect(StringCalculator.add("17,100")).to eql(117)
          end
     end
end
```

Luego de que el spec falle tendremos que realizar unos cambios al código.

```ruby
# lib/string_calculator.rb
class StringCalculator
    def self.add(input)
        if input.empty?
            0
        else
            numbers = input.split(",").map { |num| num.to_i }
            numbers.inject(0) { |sum, number| sum + number }
        end
    end
end
```

Podemos mostrar el output también de la siguiente manera usando el comando `bundle exec rspec --format documentation`:

```ruby
StringCalculator
  .add
    given an empty string
      returns zero
    single numbers
      given '4'
        returns 4
      given '10'
        returns 10
    two numbers
      given '2,4'
        returns 6
      given '17,100'
        returns 117
```

