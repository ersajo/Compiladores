%{
#include "lista.h"
#include "revision.tab.h"
%}

NUM [0-9]+
DEC [0-9]*"."[0-9]+
CAD \"[^\"]+\"
SIG "="|"+"|"-"|"*"|'%'|"("|")"|"^"|","
INI [a-zA-Z_]
CAR [a-zA-Z0-9_]*
VAR {INI}{CAR}
TYPE int|double|string
%%

div|"/" {
  printf("\tSoy div\n");
  return(DIV);
}

pow|POW {
  printf("\tSoy pow\n");
  return(POW);
}

; {
  printf("\tPC\n");
  return(PC);
}

{SIG}     {
  printf("\tSigno\n");
  return (yytext[0]);
}

{CAD}   {
  printf("\tCadena: %s\n",yytext);
  char* aux;
  aux = malloc(255);
  int i = 0;
  while(yytext[i+2]){
    aux[i] = yytext[i+1];
    i++;
  }
  aux[i] = '\0';
  yylval.cadena = aux;
  printf("%s",aux);
  return (CADENA);
}

{NUM}   {
  printf("\tNumero entero %s\n",yytext);
  yylval.entero = atoi(yytext);
  return (ENTERO);
}

{TYPE}  {
  printf("\tTipo: %s\n",yytext);
  char* aux;
  aux = malloc(255);
  int i = 0;
  while(yytext[i]){
    aux[i] = yytext[i];
    i++;
  }
  aux[i] = '\0';
  yylval.cadena = aux;
  return (TIPO);
}

{DEC}   {
  printf("\tNumero decimal %s\n",yytext);
  yylval.decimal = atof(yytext);
  return (DECIMAL);
}

{VAR}  {
        int i = 0;
        char* aux;
        aux = malloc(255);
        while(yytext[i]){
          aux[i] = yytext[i];
          i++;
        }
        if(i<=20){
         printf("\tVariable %s\n",yytext);
         aux[i] = '\0';
         yylval.cadena = aux;
         return (VARIABLE);
        }
        }

"\n"    {
  printf("\tSalto de linea\n");
  return (yytext[0]);
}

.   ;

%%
