# Parte 1 Fundamentos de Ruby
## Problema 1
El siguiente problema nos pide implementar el comando grep en ruby, para eso requerimos leer los argumentos enviado en consola, utilizando ARGV para poder leer estos argumentos.

En la siguiente línea de código realizamos la lectura de los argumentos, siendo el primer argumento la cadena a evaluar y luego verificamos si inician con "-" para agregarlos a arguments o ":" para agregarlos a filesName
``` ruby
arguments = []
filesName = []
cad = ARGV[0]
for i in 1..argc-1
    if ARGV[i][0] == "-"
        command = ARGV[i][1..-1]
        arguments.push(command)
    elsif ARGV[i][0] == ":"
        fileName = ARGV[i][1..-1]
        filesName.push(fileName)
    else
        raise "Argumento incorrecto"
        Fail
    end
end
```
Verificamos si posee al menos un archivo para lectura
``` ruby
if filesName.empty?
    raise "No hay archivo para leer"
    Fail
end
```
Continuamos con la lógica de los comandos. Utilizando la primera línea recorremos el arreglo de nombres de los archivos para luego realizar una lectura del mismo, luego recorremos cada línea de este archivo para continuar con la lógica

``` ruby
filesName.each do |fileName|
    file = File.open(fileName, "r")
    file.each_line do |line|
```

Verificamos si el arreglo de argumentos es vacío o no para proceder con el uso de estos
``` ruby
if !arguments.empty?
```
Utilizando "include?()" verificamos si la siguiente letra pertecene al comando en cuestion, esto se hace de esta manera dado que los comandos pueden tener la forma -nlivx por ejemplo y también usamos include? para verificar si la cadena pertenece a la línea que se está evaluando.

Para el comando "n" imprimimos el nombre del archivo, seguido de la linea en la que pertenece y la línea que contiene la cadena.
``` ruby
if arguments.include?("n")
    if line.include?(cad)
        puts "#{fileName} #{file.lineno}: #{line}"
        break
    end
end
```

Para el comando "l" imprimimos solamente el nombre del archivo que contiene la cadena, seguida de la sentencia break para que no lo repita y continúe con el siguiente
``` ruby
if arguments.include?("l")
    if line.include?(cad)
        puts fileName
        break
    end
end
```

Para el comando "i" imprimimos la línea que contiene la cadena sin distinguir entre mayúsculas o minúsculas, utilizando downcase para convertir todo a minúscula
``` ruby
if arguments.include?("i")
    if line.downcase.include?(cad.downcase)
        puts line
    end
end
```

Para el comando "v" imprimimos las líneas que no contienen la cadena solo agregando "!" previo al line.include?.
``` ruby
if arguments.include?("v")
    if !line.include?(cad)
        puts line
    end
end
```
Para el comando "x" imprimimos las líneas que son iguales a la cadena
``` ruby
if arguments.include?("x")
    if line == cad
        puts line
    end
end
```

Si no tenemos ningún comando, imprimimos las líneas que contienen la cadena
``` ruby
else
    if line.include?(cad)
        puts line
    end
end

```
Finalmente cerramos el archivo
``` ruby
file.close
```

## Problema 2


## Preguntas
1. Si los métodos de clase son métodos de instancia, ¿qué clase contiene esos métodos de instancia?
La misma clase donde se crean estos métodos.

3. ¿Siempre es malo utilizar abstracciones en el código de prueba?
No, porque dependiendo de la feature a realizar, utilizaremos uno o más atributos o métodos de las mismas.

4. ¿Cuál es el requisito previo más importante antes de comenzar una refactorización?
Que la aplicación funcione previamente.