%{
/*
 * Scanner calculadora
 *
 * Este archivo reconoce numeros decimales y hexadecimales.
 * Tambien identifica los operadores y los parentesis.
 */

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

"//".*                { /* Ignora todo lo que este despues de // */ }

"("                   { return OP; }
")"                   { return CP; }

"+"                   { return ADD; }
"-"                   { return SUB; }
"*"                   { return MUL; }
"/"                   { return DIV; }
"|"                   { return ABS; }

/*
 * Reconoce numeros hexadecimales como 0x10, 0xFF o 0x2A.
 * strtol convierte el texto hexadecimal en un numero entero.
 */
0[xX][0-9a-fA-F]+     {
                          yylval.val = (int)strtol(yytext, NULL, 0);
                          return NUMBER;
                      }

/*
 * Reconoce los numeros decimales normales.
 * strtol convierte el texto encontrado en un numero entero.
 */
[0-9]+                {
                          yylval.val = (int)strtol(yytext, NULL, 10);
                          return NUMBER;
                      }

\n                    { return EOL; }

[ \t]+                { /* Ignora espacios y tabulaciones */ }

.                     {
                          fprintf(
                              stderr,
                              "Caracter no reconocido: %c\n",
                              *yytext
                          );
                      }

%%
