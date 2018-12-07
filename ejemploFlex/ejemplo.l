void f1(char*);
alfa [0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]
beta [0-9a-zA-Z_]*
%%
a {printf("e");}
{alfa}"."{alfa}"."{alfa}"."{alfa} {printf("ip correcto -");}
{beta}[a-z]{beta}[A-Z]{beta}|{beta}[A-Z]{beta}[a-z]{beta} {f1(yytext);}
%%
void f1(char* yytext){
  int i = 0;
  while(yytext[i]){i++;}
  if(i<8 || i>16){printf("pass incorrecto");}
  else{printf("pass correcto");}
}
