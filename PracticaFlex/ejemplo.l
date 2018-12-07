numero [0-9]
mayuscula [A-Z]
inicio [a-zA-Z_]
op "+"|"-"|"*"|"/"
entero [0-9]*
caracter [a-zA-Z0-9_]*
decimal [0-9]*"."[0-9]*
%%
[entero|decimal]{op}[entero|decimal] {printf("Operacion valida");}
({caracter}{numero}{caracter}{mayuscula}{caracter})|({caracter}{mayuscula}{caracter}{numero}{caracter}) {int i = 0;
                                                                                                         while(yytext[i]){i++;}
                                                                                                         if(i<5 || i >20){printf("pass incorrecto");}
                                                                                                         else{printf("pass correcto");}
                                                                                                         }
{inicio}{caracter}  {int i = 0;
                     while(yytext[i]){i++;}
                     if(i>20){printf("variable incorrecto");}
                     else{printf("variable correcto");}
                    }
