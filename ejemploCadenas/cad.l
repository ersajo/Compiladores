%{
#include "cad.tab.h"
%}

NUM [0-9]+
DEC [0-9]*"."[0-9]+
CAD \"[^\"]+\"
%%

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
  return (CADENA);
}

{NUM}   {
  printf("\tNumero entero %s\n",yytext);
  yylval.entero = atoi(yytext);
  return (ENTERO);
}

{DEC}   {
  printf("\tNumero decimal %s\n",yytext);
  yylval.decimal = atof(yytext);
  return (DECIMAL);
}

div {
  printf("\tSoy div\n");
  return(DIV);
}

"+"|"-"|"*"     {
  printf("\tSigno\n");
  return (yytext[0]);
}

"\n"    {
  printf("\tSalto de linea\n");
  return (yytext[0]);
}

.   ;

%%
