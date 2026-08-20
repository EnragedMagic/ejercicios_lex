# Ejercicio 4: Scanner manual y scanner de Flex

Los dos scanners reconocen prácticamente los mismos elementos, como números, operadores, paréntesis y comentarios. Sin embargo, tienen una pequeña diferencia al leer los comentarios.

Flex ignora el texto que aparece después de `//`, pero deja el salto de línea. Esto hace que después del comentario se envíe un token `EOL`.

En cambio, el scanner manual lee el comentario hasta encontrar el salto de línea y también lo consume. Por eso, no envía el token `EOL`.

Por ejemplo, con esta entrada:

~~~text
5 + 3 // suma
~~~

Flex reconoce:

~~~text
NUMBER ADD NUMBER EOL
~~~

El scanner manual reconoce:

~~~text
NUMBER ADD NUMBER
~~~

En conclusión, reconocen los mismos elementos principales, pero no funcionan exactamente igual porque manejan de forma diferente el salto de línea después de un comentario.
