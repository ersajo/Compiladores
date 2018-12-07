#include <stdio.h>
int sizeString(char *string);

int main(int argc, char const *argv[]) {
  printf("%s\t%s\n", argv[1], argv[2]);
  char *aux;
  int i,j,k;
  for (i = 0; i < sizeString(argv[1]); i++){
    aux = argv[1];
    k = i;
    for(j = 0; j < sizeString(argv[2]); j++){
      if(aux[k] == argv[2][j]){
        while(aux[k]){
          aux[k] = aux[k+1];
          k++;
        }
        k = i;
      }else{break;}
    }
  }
  aux[i] = '\0';
  printf("%s\n", aux);
  return 0;
}

int sizeString(char *string){
  int i = 0;
  while(string[i]){i++;}
  return i;
}
