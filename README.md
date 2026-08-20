# Ejercicios de Flex y Bison

## Autores

- Andres Coral
- Johan Galeano
- Carol Arenas

## Descripción general

Este repositorio contiene la solución de los seis ejercicios del primer capítulo del libro *Flex & Bison*.

Los ejercicios permiten entender cómo Flex reconoce elementos como números y operadores, mientras que Bison organiza esos elementos y resuelve las expresiones.

## Requisitos

Para compilar los ejercicios se necesita:

- Flex
- Bison
- GCC

En Ubuntu o WSL se pueden instalar con:

```bash
sudo apt update
sudo apt install flex bison gcc
```

## Compilación

Para los ejercicios que utilizan `scanner.l` y `parser.y`:

```bash
bison -d parser.y
flex scanner.l
gcc -o programa parser.tab.c lex.yy.c
./programa
```

Para compilar el ejercicio 6:

```bash
gcc -o word_count word_count.c
./word_count archivo.txt
```

---

## Ejercicio 1: Líneas con comentarios

La calculadora original no acepta una línea que solamente tenga un comentario.

El scanner ignora el comentario, pero envía el salto de línea al parser como `EOL`. El parser espera recibir una expresión antes de `EOL`, por lo que muestra un error.

La solución es permitir que el parser también acepte líneas vacías. Pensamos que es mejor solucionarlo allí porque el scanner ya está ignorando correctamente el comentario.

---

## Ejercicio 2: Números hexadecimales

La calculadora fue modificada para aceptar números decimales y hexadecimales.

Por ejemplo:

```text
20 + 0x10
```

El scanner reconoce los números que comienzan con `0x` y utiliza `strtol` para convertirlos a enteros.

El resultado se muestra en decimal y hexadecimal:

```text
Decimal: 36 | Hexadecimal: 0x24
```

Utilizamos el mismo token `NUMBER` para ambos formatos porque, después de convertirlos, los dos se pueden operar como números enteros.

---

## Ejercicio 3: Operadores AND y OR

Se agregaron dos operadores de bits:

- `&` para AND.
- `|` para OR.

El símbolo `|` también se utiliza para el valor absoluto. El parser puede diferenciarlos según su posición:

```text
|5
```

Aquí funciona como valor absoluto.

```text
5 | 3
```

Aquí funciona como OR.

Pensamos que esta era la solución más sencilla porque permite conservar el operador de valor absoluto y agregar OR sin utilizar otro símbolo.

---

## Ejercicio 4: Scanner manual y Flex

Los dos scanners reconocen números, operadores, paréntesis y comentarios. Sin embargo, no funcionan exactamente igual.

Flex ignora el comentario, pero conserva el salto de línea y envía `EOL`. El scanner manual también consume ese salto de línea.

Por ejemplo:

```text
5 + 3 // suma
```

Flex reconoce:

```text
NUMBER ADD NUMBER EOL
```

El scanner manual puede reconocer:

```text
NUMBER ADD NUMBER
```

La diferencia principal está en la forma de procesar el final de los comentarios.

---

## Ejercicio 5: Cuándo no utilizar Flex

Flex funciona bien para reconocer patrones sencillos como números, palabras y operadores.

No es la mejor opción para lenguajes que dependen de elementos más complejos, como:

- La indentación de Python.
- Los comentarios anidados.
- Los símbolos que cambian de significado según el contexto.

En estos casos puede ser más sencillo utilizar un scanner manual o combinar Flex con otras herramientas.

---

## Ejercicio 6: Contador escrito en C

Se creó un contador de palabras directamente en C.

El programa lee un archivo carácter por carácter y cuenta:

- Líneas.
- Palabras.
- Caracteres.

La versión en C puede ser un poco más rápida porque realiza el proceso directamente. Sin embargo, requiere más código y más control manual.

Flex permite hacer lo mismo con reglas más cortas y fáciles de modificar. Por eso pensamos que C ofrece mayor control, mientras que Flex facilita el desarrollo.

---

## Conclusión

Estos ejercicios nos ayudaron a entender que el scanner reconoce los elementos de la entrada y el parser decide cómo organizarlos y utilizarlos.

También aprendimos que Flex permite escribir reglas cortas y fáciles de mantener, mientras que hacerlo directamente en C requiere más código, pero ofrece mayor control.

Las soluciones fueron realizadas buscando que cada parte cumpliera una función clara y que el código fuera fácil de entender.
