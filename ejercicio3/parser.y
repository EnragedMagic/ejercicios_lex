%{
/*
 *Parser calculadora
 *
 * Resuelve operaciones normales y operaciones de bits.
 * El simbolo | funciona como valor absoluto y como OR.
 */

#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);
void yyerror(const char *mensaje);
%}

%union {
    int val;
}

%token <val> NUMBER

%token ADD SUB MUL DIV
%token AND OR
%token OP CP EOL

%type <val> exp and_exp suma factor term

%%

calclist:
      /* Permite comenzar con una entrada vacia */
    | calclist exp EOL {
          printf(
              "Decimal: %d | Hexadecimal: 0x%X\n",
              $2,
              $2
          );
      }
    | calclist EOL {
          /* Permite lineas vacias */
      }
    ;

/* El OR se realiza despues de las otras operaciones */
exp:
      and_exp {
          $$ = $1;
      }
    | exp OR and_exp {
          $$ = $1 | $3;
      }
    ;

/* El AND se realiza antes que el OR */
and_exp:
      suma {
          $$ = $1;
      }
    | and_exp AND suma {
          $$ = $1 & $3;
      }
    ;

/* Operaciones de suma y resta */
suma:
      factor {
          $$ = $1;
      }
    | suma ADD factor {
          $$ = $1 + $3;
      }
    | suma SUB factor {
          $$ = $1 - $3;
      }
    ;

/* Operaciones de multiplicacion y division */
factor:
      term {
          $$ = $1;
      }
    | factor MUL term {
          $$ = $1 * $3;
      }
    | factor DIV term {
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
    | OR term {
          /* Aqui | funciona como valor absoluto */
          $$ = ($2 >= 0) ? $2 : -$2;
      }
    | OP exp CP {
          $$ = $2;
      }
    ;

%%

void yyerror(const char *mensaje) {
    printf("Error: %s\n", mensaje);
}

int main(void) {
    yyparse();
    return 0;
}
