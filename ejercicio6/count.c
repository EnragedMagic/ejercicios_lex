#include <stdio.h>
#include <stdlib.h>

/*
 * Revisa si el caracter actual es una letra.
 * Una palabra se forma con letras de la A a la Z.
 */
int es_letra(int caracter) {
    return (caracter >= 'a' && caracter <= 'z') ||
           (caracter >= 'A' && caracter <= 'Z');
}

/*
 * Lee el archivo caracter por caracter y cuenta
 * las lineas, las palabras y los caracteres.
 */
void contar_archivo(FILE *archivo) {
    long lineas = 0;
    long palabras = 0;
    long caracteres = 0;

    int caracter;
    int dentro_palabra = 0;

    while ((caracter = fgetc(archivo)) != EOF) {
        caracteres++;

        /* Cada salto de linea cuenta como una nueva linea */
        if (caracter == '\n') {
            lineas++;
        }

        /*
         * Si encuentra una letra y antes no estaba dentro
         * de una palabra, significa que comienza una nueva.
         */
        if (es_letra(caracter)) {
            if (!dentro_palabra) {
                palabras++;
                dentro_palabra = 1;
            }
        } else {
            /* Un espacio o simbolo indica que la palabra termino */
            dentro_palabra = 0;
        }
    }

    printf("Lineas: %ld\n", lineas);
    printf("Palabras: %ld\n", palabras);
    printf("Caracteres: %ld\n", caracteres);
}

int main(int argc, char *argv[]) {
    FILE *archivo;

    /*
     * El programa espera que se escriba el nombre
     * del archivo que se quiere analizar.
     */
    if (argc != 2) {
        printf("Uso: %s <archivo>\n", argv[0]);
        return 1;
    }

    archivo = fopen(argv[1], "r");

    if (archivo == NULL) {
        printf("No se pudo abrir el archivo.\n");
        return 1;
    }

    contar_archivo(archivo);
    fclose(archivo);

    return 0;
}
