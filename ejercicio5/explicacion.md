# Ejercicio 5: Casos donde Flex no es una buena opción

Flex funciona bien cuando puede reconocer los elementos de un lenguaje mediante patrones sencillos, como números, palabras y operadores. Sin embargo, hay lenguajes que necesitan analizar más que una secuencia de caracteres.

Un ejemplo es Python, porque utiliza la cantidad de espacios al inicio de cada línea para organizar los bloques de código. En este caso, no basta con reconocer palabras y símbolos, también es necesario comparar la indentación de cada línea.

Otro caso son los lenguajes que permiten comentarios dentro de otros comentarios:

~~~text
/* Comentario principal
   /* Comentario interno */
*/
~~~

Para procesarlos es necesario recordar cuántos comentarios se han abierto y cerrado. Esto es más difícil de representar utilizando solamente las reglas normales de Flex.

También puede ser complicado utilizar Flex cuando un mismo símbolo cambia de significado dependiendo de dónde aparece. En ese caso, el scanner necesita conocer lo que se analizó anteriormente o recibir ayuda del parser.

En conclusión, Flex no es la mejor opción para lenguajes que dependen mucho de la indentación, de elementos anidados o del contexto. En esos casos puede ser más sencillo crear un scanner manual o combinar Flex con otras estructuras.
