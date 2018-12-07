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
%token POT

/*No terminales*/
%type <entero> exp
%type <decimal> expd
%type <cadena> expc

/*Precedencia*/
/*EL ULTIMO TIENE MAYOR PRECEDENCIA*/
%left '+' '-'
%left '*' DIV
%left POT
%left '(' ')'

/*Gramatica*/
%%

input:  /* cadena vacia */
       | input line
;

line:   '\n'
       | expc '\n' { printf("\t\tresultado: %s\n", $1); }
       | exp '\n' { printf("\t\tresultado: %d\n", $1); }
       | expd '\n' { printf("\t\tresultado: %f\n", $1); }
;

exp:   ENTERO { $$ = $1; }
    | '-' exp { $$ = $2 * (-1); }
    | exp '+' exp   { $$ = $1 + $3; }
    | exp '-' exp   { $$ = $1 - $3; }
    | exp '*' exp   { $$ = $1 * $3; }
    | exp DIV exp   { $$ = $1 / $3; }
    | '(' exp ')' { $$ = $2; }
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
  | expc POT exp {
                  char* aux;
                  if($3 == 0){
                    $$ = '\0';
                  }
                  else if($3 > 0){
                    int i, j, k = 0;
                    aux = malloc((sizeString($1)*$3)+1);
                    for(j = 0; j < $3; j++){
                      i = 0;
                      while($1[i]){
                        aux[k] = $1[i];
                        k++; i++;
                      }
                    }
                    aux[k] = '\0';
                    $$ = aux;
                  }
                  else if($3 < 0){
                    $3 = $3 * (-1);
                    int i, j, k = 0, l=0;
                    aux = malloc((sizeString($1)*$3)+1);
                    while($1[l]){l++;}
                    for(j = 0; j < $3; j++){
                      i = l-1;
                      while($1[i]){
                        aux[k] = $1[i];
                        k++; i--;
                      }
                    }
                    aux[k] = '\0';
                    $$ = aux;
                  }
                }
    | expc '-' expc {
                    char* cadena;
                    int i, j, k, flag=0;
                    cadena = malloc(sizeString($1)+1);
                    if(sizeString($3)>0){
                      for(i=0, k=0; i<sizeString($1);i++){
                        for(j=0; j<sizeString($3)&&flag==0;j++){
                          if($1[i+j] == $3[j]){
                            continue;
                          }
                          else{
                            break;
                          }
                        }
                        if(j==sizeString($3)){
                          flag=1;
                          i=i+j-1;
                          j=-1;
                        }
                        else{
                          cadena[k] = $1[i];
                          k++;
                        }
                      }
                    cadena[k] = '\0';
                    }
                    else{
                      cadena=$1;
                    }
                    $$ = cadena;
                    }
;

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
