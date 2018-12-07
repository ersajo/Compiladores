%{
#include "ejemplo2.tab.h"
%}

NUM [0-9]+
DEC [0-9]*"."[0-9]+
CAD "\""[a-zA-Z0-9" "]*"\""
%%

{CAD}   {
  printf("\tCadena\n");
  yylval.cadena = strdup(yytext);
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
