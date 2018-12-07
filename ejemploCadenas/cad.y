/*
Para compilar:
flex cad.l
bison cad.y -d
gcc lex.yy.c cad.tab.c
./a.exe
*/

%{
//#include <math.h>
#include <stdio.h>
int sizeString(char *string);
%}

/*Declaraciones de BISON*/
%union{
  int entero;
  float decimal;
  char *cadena;
}

/*Terminales*/
%token <entero> ENTERO
%token <decimal> DECIMAL
%token <cadena> CADENA
%token DIV

/*No terminales*/
%type <entero> exp
%type <decimal> expd
%type <cadena> expc

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
       | exp '\n' { printf("\t\tresultado: %d\n", $1); }
       | expd '\n' { printf("\t\tresultado: %f\n", $1); }
       | expc '\n' { printf("\t\tresultado: %s\n", $1); }
;

exp:   ENTERO { $$ = $1; }
    | exp '+' exp   { $$ = $1 + $3; }
    | exp '-' exp   { $$ = $1 - $3; }
    | exp '*' exp   { $$ = $1 * $3; }
    | exp DIV exp   { $$ = $1 / $3; }
;

expd:   DECIMAL { $$ = $1; }
    | expd '+' expd   { $$ = $1 + $3; }
    | expd '-' expd   { $$ = $1 - $3; }
    | expd '*' expd   { $$ = $1 * $3; }
    | expd DIV expd   { $$ = $1 / $3; }
    | exp '+' expd   { $$ = $1 + $3; }
    | exp '-' expd   { $$ = $1 - $3; }
    | exp '*' expd   { $$ = $1 * $3; }
    | exp DIV expd   { $$ = $1 / $3; }
    | expd '+' exp   { $$ = $1 + $3; }
    | expd '-' exp   { $$ = $1 - $3; }
    | expd '*' exp   { $$ = $1 * $3; }
    | expd DIV exp   { $$ = $1 / $3; }
;

expc:  CADENA { $$ = $1; }
    | expc '+' expc   {
                    int i = 0, j = 0;
                    char *aux;
                    aux = malloc(sizeString($1)+sizeString($3)+1);
                    while($1[i]){
                      aux[j] = $1[i];
                      i++; j++;
                    }
                    i = 0;
                    while($3[i]){
                      aux[j] = $3[i];
                      i++; j++;
                    }
                    aux[j] = '\0';
                    $$ = aux;
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

int sizeString(char *string){
  int i = 0;
  while(string[i]){i++;}
  return i;
}
