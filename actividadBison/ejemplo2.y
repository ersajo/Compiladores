/*
Para compilar:
flex ejemplo2.l
bison ejemplo2.y -d
gcc lex.yy.c ejemplo2.tab.c
./a.exe
*/

%{
//#include <math.h>
#include <stdio.h>
%}

/*Declaraciones de BISON*/
%union{
  int entero;
  float decimal;
  char* cadena;
}

/*Terminales*/
%token <entero> ENTERO
%token <decimal> DECIMAL
%token <cadena> CADENA
%token DIV

/*No terminales*/
%type <decimal> exp
%type <cadena> cad

/*Precedencia*/
/*EL ULTIMO TIENE MAYOR PRECEDENCIA*/
%left '+' '-'
%left '*' DIV

/*Gramatica*/
%%

input:  /* cadena vacia */
       | input line
;

line:   '\n'
       | exp '\n' { printf("\t\tresultado: %f\n", $1); }
       | cad '\n' { printf("\t\tresultado: %s\n", $1); }
;

exp:   ENTERO { $$ = $1; }
    | DECIMAL { $$ = $1; }
    | exp '+' exp   { $$ = $1 + $3; }
    | exp '-' exp   { $$ = $1 - $3; }
    | exp '*' exp   { $$ = $1 * $3; }
    | exp DIV exp   { $$ = $1 / $3; }
;

cad:  CADENA { $$ = $1; }
    | cad '+' cad   {
                    int i = 1;
                    int j = 1;
                    while($1[i + 1]){
                      $1[i-1] = $1[i];
                      i++;
                    }
                    i--;
                    while($3[j + 1]){
                      $1[i] = $3[j];
                      j++;
                      i++;
                    }
                    $$ = $1;
                    }

%%

int main() {
  yyparse();
}

/*Una de las gramaticas detecta un error irrecuperable*/
yyerror (char *s)
{
  printf("--%s--\n", s);
}

int yywrap()
{
  return 1;
}
