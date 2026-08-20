%{
/*
 * Parser calculadora
 *
 * Este archivo recibe los tokens enviados por el scanner.
 * Luego organiza y resuelve las operaciones respetando su prioridad.
 */

#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
void yyerror(const char *mensaje);
%}

%union {
    int val;
}

/* NUMBER guarda el valor encontrado por el scanner */
%token <val> NUMBER

/* Tokens para operadores, parentesis y final de linea */
%token ADD SUB MUL DIV ABS EOL
%token OP CP

/* Estas reglas producen un resultado de tipo entero */
%type <val> exp factor term

%%

calclist:
      /* Permite que la entrada comience vacia */
    | calclist exp EOL {
          /*
           * Muestra el mismo resultado en decimal y hexadecimal.
           * %d imprime en decimal y %X imprime en hexadecimal.
           */
          printf(
              "Decimal: %d | Hexadecimal: 0x%X\n",
              $2,
              $2
          );
      }
    | calclist EOL {
          /* Permite lineas vacias o lineas con solo comentarios */
      }
    ;

exp:
      factor {
          $$ = $1;
      }
    | exp ADD factor {
          $$ = $1 + $3;
      }
    | exp SUB factor {
          $$ = $1 - $3;
      }
    ;

factor:
      term {
          $$ = $1;
      }
    | factor MUL term {
          $$ = $1 * $3;
      }
    | factor DIV term {
          /* Revisa que el segundo numero no sea cero */
          if ($3 == 0) {
              yyerror("Division por cero");
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }
    ;

term:
      NUMBER {
          $$ = $1;
      }
    | ABS term {
          /* Convierte un numero negativo en positivo */
          $$ = ($2 >= 0) ? $2 : -$2;
      }
    | OP exp CP {
          /* Usa el resultado de la expresion entre parentesis */
          $$ = $2;
      }
    ;

%%

void yyerror(const char *mensaje) {
    fprintf(stderr, "Error: %s\n", mensaje);
}

int main(void) {
    /* Inicia el analisis de las operaciones */
    yyparse();
    return 0;
}
