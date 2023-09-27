# Tarea HolaRuby
## Parte 1: Arreglos, hashes y enumerables
1. El siguiente código:
```ruby
def sum arr
  if arr.length == 0
    return 0
  else
    suma = 0
    arr.each do |i|
      suma += i
    end
    return suma
  end
end
```
Devuelve la suma de los elementos de un arreglo "arr" con longitud mayor que cero.
2. El siguiente código:
```ruby
def max_2_sum arr
  if arr.length == 0
    return 0
  else
    if arr.length == 1
      return arr[0]
    else
      arr.sort!
      return arr[-1] + arr[-2]
    end
  end
end
```
Ordena el arreglo con el método sort! y luego retorna la suma del mayor y segundo mayor.
3. El siguiente código:
```ruby
def sum_to_n? arr, n
  if arr.length == 0
    return false
  else
    if arr.length == 1
      return false
    else
      arr.sort!
      i = 0
      j = arr.length - 1
      while i < j
        if arr[i] + arr[j] == n
          return true
        else
          if arr[i] + arr[j] < n
            i += 1
          else
            j -= 1
          end
        end
      end
      return false
    end
  end
end
``` 
 Ordena el arreglo y luego toma el primer y último elemento, si la suma es mayor que el valor a buscar, resta 1 al segundo índice, sino suma 1 al primero.
 

 # Parte 2: Cadenas y expresiones regulares
1. El siguiente código imprime la cadena "Hello, " seguido del nombre ingresado:
```ruby
def hello(name)
  "Hello, " + name
end
```
2. El siguiente código:
```ruby
def starts_with_consonant? s
  s = s.downcase
  if s.length == 0
    return false
  else
    if s[0] =~ /[bcdfghjklmnpqrstvwxyz]/
      return true
    else
      return false
    end
  end
end
```
Utiliza el método downcase para convertir los caracteres de la cadena a minúsculas para luego, si la cadena es no vacía, utilizar expresiones regulares para saber si en el primer elemento hay una consonante.
3. El siguiente código:
```ruby
def binary_multiple_of_4? s
  if s.length == 0
    return false
  else
    if s =~ /^[0-1]+$/
      if s.to_i(2) % 4 == 0
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
``` 
Luego de verificar si la cadena es no vacía, verificamos utilizando expresiones regulares si la cadena posee solo los caracteres 0 y 1. Luego verifica si es múltiplo de 4 o no.

## Parte 3: Conceptos básicos de orientación a objetos

La clase BookInStock posee los atributos, los cuales podemos modificar, isbn y price. Dentro del método initialize verificamos si la cadena es vacía o si el precio es menor o igual a cero para generar un ArgumentError. Creamos los respectivos getters and setters y el método price_as_string para imprimir el precio con dos decimales


```ruby
class BookInStock
  attr_accessor :isbn, :price

  def initialize(isbn, price)
    if isbn.length == 0 || price <= 0
      raise ArgumentError
    else
      @isbn = isbn
      @price = price
    end
  end

  def isbn
    @isbn
  end

  def isbn=(isbn)
    @isbn = isbn
  end

  def price
    @price
  end

  def price=(price)
    @price = price
  end
  
  def price_as_string
    "$%.2f" % @price
  end

end
```

