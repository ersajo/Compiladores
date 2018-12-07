/*
Para compilar:
flex cad.l
bison cad.y -d
gcc lex.yy.c cad.tab.c
./a.exe
*/

%{
#include <math.h>
#include <stdio.h>
#include "lista.h"

List lista = NULL;

int Insertar (Elem e, char* cad, List *lista);
int len(List lista);
int Pertenece (char* cad, List lista);
void printList(List l);
Elem* getElemento(char* cad, List lista);
int isEmpty(List l);

void insertarVariable(char* tipo, char* variable);

int sizeString(char *string);
char* suma(char* cad1, char* cad2);
char* potencia(char* cad, int val);
char* resta(char* cad1, char* cad2);
%}

/*Declaraciones de BISON*/
%union{
  Elem elemento;
  int entero;
  double decimal;
  char *cadena;
}

/*Terminales*/
%token <elemento> ELEMENTO
%token <entero> ENTERO
%token <decimal> DECIMAL
%token <cadena> CADENA
%token <cadena> VARIABLE
%token <cadena> TIPO
%token DIV
%token PC
%token POW

/*No terminales*/
%type <entero> exp
%type <decimal> expd
%type <cadena> expc
%type <cadena> var

/*Precedencia*/
/*EL ULTIMO TIENE MAYOR PRECEDENCIA*/
%left '+' '-'
%left '*' DIV
%left '^' POW
%left '(' ')'

/*Gramatica*/
%%

input:  /* cadena vacia */
       | input line
;

line:   '\n'  { printList(lista); }
       | expc PC '\n' { printf("\t\tresultado: %s\n", $1); }
       | exp PC '\n' { printf("\t\tresultado: %d\n", $1); }
       | expd PC '\n' { printf("\t\tresultado: %f\n", $1); }
       | var PC '\n' { printf("\t\tresultado: %s\n", $1); }
;

var:  TIPO VARIABLE { insertarVariable($1,$2); $$ = $2; }
;

exp:   ENTERO { $$ = $1; }
    | '-' exp { $$ = $2 * (-1); }
    | exp '+' exp   { $$ = $1 + $3; }
    | exp '-' exp   { $$ = $1 - $3; }
    | exp '*' exp   { $$ = $1 * $3; }
    | exp DIV exp   { $$ = $1 / $3; }
    | '(' exp ')' { $$ = $2; }
    | POW '(' exp ',' exp ')' { $$ = pow($3,$5); }
;

expd:   DECIMAL { $$ = $1; }
    | POW '(' exp ',' '-' exp ')' { $$ = pow($3,($6*(-1))); }
    | '-' expd { $$ = $2 * (-1); }
    | expd '+' expd   { $$ = $1 + $3; }
    | expd '-' expd   { $$ = $1 - $3; }
    | expd '*' expd   { $$ = $1 * $3; }
    | expd DIV expd   { $$ = $1 / $3; }
    | POW '(' expd ',' expd ')' { $$ = pow($3,$5); }
    | exp '+' expd   { $$ = $1 + $3; }
    | exp '-' expd   { $$ = $1 - $3; }
    | exp '*' expd   { $$ = $1 * $3; }
    | exp DIV expd   { $$ = $1 / $3; }
    | POW '(' exp ',' expd ')' { $$ = pow($3,$5); }
    | expd '+' exp   { $$ = $1 + $3; }
    | expd '-' exp   { $$ = $1 - $3; }
    | expd '*' exp   { $$ = $1 * $3; }
    | expd DIV exp   { $$ = $1 / $3; }
    | POW '(' expd ',' exp ')' { $$ = pow($3,$5); }
;

expc:  CADENA { $$ = $1; }
    | expc '+' expc   { $$ = suma($1, $3); }
    | expc '^' exp { $$ = potencia($1, $3); }
    | expc '-' expc { $$ = resta($1,$3); }
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

char* suma(char* cad1, char* cad2){
  int i = 0, j = 0;
  char *aux;
  aux = malloc(sizeString(cad1)+sizeString(cad2)+1);
  while(cad1[i]){
    aux[j] = cad1[i];
    i++; j++;
  }
  i = 0;
  while(cad2[i]){
    aux[j] = cad2[i];
    i++; j++;
  }
  aux[j] = '\0';
  return aux;
}

char* potencia(char* cad, int val){
  char* aux;
  if(val == 0){
    return '\0';
  }
  else if(val > 0){
    int i, j, k = 0;
    aux = malloc((sizeString(cad)*val)+1);
    for(j = 0; j < val; j++){
      i = 0;
      while(cad[i]){
        aux[k] = cad[i];
        k++; i++;
      }
    }
    aux[k] = '\0';
    return aux;
  }
  else if(val < 0){
    val = val * (-1);
    int i, j, k = 0, l=0;
    aux = malloc((sizeString(cad)*val)+1);
    while(cad[l]){l++;}
    for(j = 0; j < val; j++){
      i = l-1;
      while(cad[i]){
        aux[k] = cad[i];
        k++; i--;
      }
    }
    aux[k] = '\0';
    return aux;
  }
}

char* resta(char* cad1, char* cad2){
  char* cadena;
  int i, j, k, flag=0;
  cadena = malloc(sizeString(cad1)+1);
  if(sizeString(cad2)>0){
    for(i=0, k=0; i<sizeString(cad1);i++){
      for(j=0; j<sizeString(cad2)&&flag==0;j++){
        if(cad1[i+j] == cad2[j]){
          continue;
        }
        else{
          break;
        }
      }
      if(j==sizeString(cad2)){
        flag=1;
        i=i+j-1;
        j=-1;
      }
      else{
        cadena[k] = cad1[i];
        k++;
      }
    }
  cadena[k] = '\0';
  }
  else{
    cadena=cad1;
  }
  return cadena;
}

int sizeString(char* string){
  int i = 0;
  while(string[i]){i++;}
  return i;
}

int Insertar (Elem e, char* cad, List *l){
  printf("I:%s\t%d\n",cad,Pertenece(cad,*l));
  if (!Pertenece(cad,*l)){
    List aux = malloc(sizeof(nodoL));
    aux->valor = cad;
    aux->elemento = e;
    aux->len = len(*l) + 1;
    aux->sig = *l;
    *l = aux;
    return 1;
  }else{
    return 0;
  }
}

int len(List l){
  int i = 0;
  if (l == NULL){
    return 0;
  }else{
    return l->len;
  }
}

int Pertenece (char* cad, List l){
  if(l == NULL){
    return 0;
  }else{
    printf("P:%s\t%d\t%d\n", cad, l==NULL, cad == l->valor);
    if(cad == l->valor){
      return 1;
    }else{
      Pertenece(cad,l->sig);
    }
  }
}

void printList(List l){
  if(l!=NULL){
    printf("%s\t%s\n", l->valor,l->elemento.tipo);
    printList(l->sig);
  }
}

Elem* getElemento(char* cad, List l){
  if(l!=NULL){
    if(l->valor == cad){
      return &l->elemento;
    }else{
      getElemento(cad, l->sig);
    }
  }
}

int isEmpty(List l){
  if(l == NULL){
    return 0;
  }else{
    return 1;
  }
}

void insertarVariable(char* tipo, char* variable){
  Elem e;
  e.tipo = tipo;
  Insertar(e,variable,&lista);
}
