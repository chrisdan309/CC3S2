# PC2 Parte 1
El código del problema 1 es de la siguiente manera:
``` ruby
def letraFaltante(cad)
  cad = cad.downcase
  for letra in 'a'..'z'
    return letra if !cad.include?(letra)
  end
end


cadena = "the quick brown box jumps over a lazy dog"
letraFalta = letraFaltante(cadena)
puts "La letra que falta es #{letraFalta}"
```
la funcion cad.downcase conveirte cada caracter a minúscula, luego dentro de un for con todas las letras del abecedario verificamos si no está, cuando encuentre que no está entonces retornará ese valor.


El código del problema 2:
``` ruby
class BinaryTree
  attr_accessor :valor, :izquierda, :derecha

  def initialize()
    @valor = nil
    @izquierda = nil
    @derecha = nil
  end

  def << (elemento)
    if @valor.nil?
      @valor = elemento
    elsif elemento <= @valor
      @izquierda = BinaryTree.new
      @izquierda <<(elemento)
    else
      @derecha = BinaryTree.new
      @derecha <<(elemento)
    end
  end

  def empty?
    @valor.nil?
  end

  def each()
    pass
  end

end
```

Primero creamos el método intialize para definir como nil los atributos de la clase BinaryTree, luego al ingresar un elemento verifica si el @valro es nil, si lo es agrega el elemento, sino verifica si es menor para agregarlo a la izquierda o si es mayor para agregarlo a la izquierda. El empty? verifica si el valor de la raíz es nil.
