%{
/*
 * Scanner calculadora
 *
 * Reconoce numeros, operadores normales y operadores de bits.
 * El simbolo | se puede usar para valor absoluto o para OR.
 */

#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

"//".*                { /* Ignora los comentarios */ }

"("                   { return OP; }
")"                   { return CP; }

"+"                   { return ADD; }
"-"                   { return SUB; }
"*"                   { return MUL; }
"/"                   { return DIV; }

"&"                   { return AND; }
"|"                   { return OR; }

/* Reconoce numeros hexadecimales */
0[xX][0-9a-fA-F]+     {
                          yylval.val = (int)strtol(yytext, NULL, 0);
                          return NUMBER;
                      }

/* Reconoce numeros decimales */
[0-9]+                {
                          yylval.val = (int)strtol(yytext, NULL, 10);
                          return NUMBER;
                      }

\n                    { return EOL; }

[ \t]+                { /* Ignora espacios y tabulaciones */ }

.                     {
                          printf(
                              "Caracter no reconocido: %c\n",
                              *yytext
                          );
                      }

%%
