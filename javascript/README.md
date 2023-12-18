# Javascript

## Preguntas conceptuales

* En JavaScript, todas las operaciones de red son asíncronas. ¿Porque es esto importante?

Porque asigna estas tareas por el lado del servidor utilizando hilos y continúa con su ejecución

* En Javascript, queremos realizar acciones tras una operación/solicitud de red completa. ¿Qué paradigma de programación hace esto posible?

EL paradigma de programación asincrónica

* ¿Javascript proporciona soporte limitado para la herencia a través de qué mecanismo?

A través de los prototipos

* ¿Qué es el DOM? ¿Qué librería nos ayuda a usar Javascript para manipular el DOM?

El DOM (Document Object Model) es una representación en forma de árbol donde presenta la estructuraa del documento HTML.

Algunas de las librerías que ayudan a manipular es DOM es jQuery.

## Booleano

Con el siguiente programa validamos las siguientes salidas 

```js
console.log(undefined == null)
console.log(NaN == NaN)
console.log(null == false)
console.log(0 == false)
console.log("" == false)
```

Las cuales tienen el siguiente output

```
true
false
false
true
true
```

## Arrays

Vamos a analizar el comportamiento de los arrays con los siguientes ejemplos

```js
array = [1, 2, 3] + [4, 5, 6]
console.log(array)
array = !![]
console.log(array)
console.log([] == true)
console.log([10, 1, 3].sort())
console.log([] == true)
```

El output es el siguiente

```
1,2,34,5,6
true
false
[ 1, 10, 3 ]
false
```

## Clausuras

Podemos usar las funciones anidadas

```js
function f1(x) {
  var baz = 3;
  return function (y) {
    console.log(x + y + (baz++));
    }
}
var bar = f1(5);
bar(11);
```
Y el output de este código es `19` dado que en inicialmente asigna el valor x con 5 y luego al ejecutar la funcion bar con 11, le asigna el valor de 11 a y y luego imprime 5+11+3 => 19, y al valor de baz le agrega 1.

## Algoritmos

El siguiente código tiene complejidad O(n²)

```js
function greatestNumber(array) {
    for (let i of array) {
        let isIValTheGreatest = true;
        for (let j of array) {
            if (j > i) {
                isIValTheGreatest = false;
            }
        }
        if (isIValTheGreatest) {
            return i;
        }
    }
}
```

Para poder tener un algoritmo con complejidad O(n) debemos deshacernos de un bucle for y dado que buscamos el greatest number lo podemos lograr de la siguiente manera

```js
function greatestNumber(array) {
    let greatest = array[0];
    for (let i of array) {
        if (i > greatest) {
            greatest = i;
        }
    }
    return greatest;
}
```

De esta manera nuestro algoritmo realiza la misma acción pero con menos complejidad

```js
function containsX(string) {
    foundX = false;
    for(let i = 0; i < string.length; i++) {
        if (string[i] === "X") {
            foundX = true;
        }
    }
    return foundX;
}
```

¿Cuál es la complejidad temporal de esta función en términos de notación O grande? Luego, modifica el código para mejorar la eficiencia del algoritmo en los mejores y promedios escenarios.

El siguiente algoritmo tiene una complejidad O(n) dado que posee un bucle for y una estructura de control que posee una operación de asignación, por lo tanto tiene complejidad O(n). Este algoritmo se puede optimizar al momento de retornar true cuando encuentre la primera "X", así rompe el bucle previamente.

```js
function containsX(string) {
    for(let i = 0; i < string.length; i++) {
        if (string[i] === "X") {
            return true;
        }
    }
    return false;
}
```

## Clases
Creamos la clase pokemon con las siguiente características:

- El constructor toma 3 parámetros (HP, ataque, defensa)
- El constructor debe crear 6 campos (HP, ataque, defensa, movimiento, nivel, tipo). Los valores de (mover, nivelar,
tipo) debe inicializarse en ("", 1, "").
- Implementa un método `fight` que arroje un error que indique que no se especifica ningún movimiento.
- Implementa un método `canFly` que verifica si se especifica un tipo. Si no, arroja un error. Si es así, verifica si el tipo incluye "volar". En caso afirmativo, devuelve verdadero; si no, devuelve falso.

```js
class Pokemon{
    constructor(HP, ataque, defensa){
        this.HP = HP;
        this.ataque = ataque;
        this.defensa = defensa;
        this.movimientos = "";
        this.nivel = 1;
        this.tipo = "";
    }

    fight(){
        if (this.movimientos === ""){
            throw new Error("No se a seleccionado ningún movimiento")
        }
    }

    canFly(){
        if (this.tipo === ""){
            throw new Error("No se especificó un tipo");
        }
        
        return this.tipo.includes("volador");
    }   
}
```

Y ahora creamos la clase Charizard:
- El constructor toma 4 parámetros (HP, ataque, defensa, movimiento)
- El constructor configura el movimiento y el tipo (para "disparar/volar") además de establecer HP, ataque y defensa como el
constructor de superclase.
- Sobreescribe el método `fight`. Si se especifica un movimiento, imprime una declaración que indique que se está utilizando el movimiento y devuelve el campo de ataque. Si no, arroja un error.

```js
class Charizard extends Pokemon{
    constructor(hp, ataque, defensa, movimiento) {
        super(hp, ataque, defensa);
        this.movimiento = movimiento;
        this.tipo = "volador";
    }
    fight(){
        super.fight();
        console.log("Usó " + this.movimiento);
    }
}
```