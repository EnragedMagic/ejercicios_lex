# Lineas con un comentario

La calculadora original no acepta correctamente una línea que tenga únicamente un comentario. Esto sucede porque el scanner reconoce el comentario con `//` y lo ignora, pero el salto de línea permanece y se envía al parser como un token `EOL`.

El parser espera recibir primero una expresión y después el final de la línea. Sin embargo, como todo el comentario fue ignorado, recibe solamente `EOL` y no encuentra ninguna expresión para evaluar. Por esta razón, muestra un error de sintaxis.

La manera más sencilla de solucionarlo es desde el parser, agregando una regla que le permita aceptar líneas vacías. De esta forma, una línea que solo contiene un comentario se procesa igual que una línea sin contenido.

La regla quedaría así:

~~~yacc
calclist:
      /* vacío */
    | calclist exp EOL { printf("= %d\n", $2); }
    | calclist EOL     { /* Línea vacía o comentario */ }
    ;
~~~

La última opción permite que el parser reciba un `EOL` sin necesitar una expresión antes. Por lo tanto, la calculadora puede ignorar correctamente las líneas vacías y las líneas que contienen solamente comentarios.
