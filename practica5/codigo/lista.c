#include <stdio.h>
#include <stdlib.h>

typedef struct Elem{
  char *tipo;
  int entero;
  double decimal;
  char* cadena;
}Elem;

typedef struct nodo{
  char* valor;
  Elem elemento;
  int len;
  struct nodo *sig;
}nodoL;

typedef nodoL* List;

int sizeString(char *string);
int Insertar (Elem e, char* cad, List* lista);
int len(List lista);
int Pertenece (char* cad, List lista);
void printList(List l);
Elem* getElemento(char* cad, List lista);
int isEmpty(List l);

int main() {
  List lista = NULL;
  Elem pos;
  Elem* new;
  char *aux1 = "var1";
  char *aux2 = "var2";
  char *aux3 = "var3";
  pos.tipo = "entero";
  pos.entero = 4;
  printf("len: %d\n", len(lista));
  printf("Pertenece: %d\n", Pertenece(aux1,lista));
  Insertar(pos,aux1,&lista);
  pos.tipo = "float";
  pos.decimal = 4.5;
  printf("Pertenece: %d\n", Pertenece(aux1,lista));
  Insertar(pos,aux2,&lista);
  Insertar(pos,aux2,&lista);
  pos.tipo = "string";
  pos.cadena = "hola mundo";
  Insertar(pos,aux3,&lista);
  printf("len: %d\n", len(lista));
  printList(lista);
  new = getElemento(aux1, lista);
  printf("getElemento: %s\n", new->tipo);
  new = getElemento(aux2, lista);
  printf("getElemento: %s\n", new->tipo);
  new = getElemento(aux3, lista);
  printf("getElemento: %s\n", new->tipo);
  printList(lista);
  return 0;
}

int sizeString(char* string){
  int i = 0;
  while(string[i]){i++;}
  return i;
}

int Insertar (Elem e, char* cad, List *lista){
  if (!Pertenece(cad,*lista)){
    List aux = malloc(sizeof(nodoL));
    aux->valor = cad;
    aux->elemento = e;
    aux->len = len(*lista) + 1;
    aux->sig = *lista;
    *lista = aux;
    return 1;
  }else{
    return 0;
  }
}

int len(List lista){
  int i = 0;
  if (lista == NULL){
    return 0;
  }else{
    return lista->len;
  }
}

int Pertenece (char* cad, List lista){
  if(lista == NULL){
    return 0;
  }else{
    if(cad == lista->valor){
      return 1;
    }else{
      Pertenece(cad,lista->sig);
    }
  }
}

void printList(List l){
  if(l!=NULL){
    printf("%s\t%s\n", l->valor,l->elemento.tipo);
    printList(l->sig);
  }
}

Elem* getElemento(char* cad, List lista){
  if(lista!=NULL){
    if(lista->valor == cad){
      return &lista->elemento;
    }else{
      getElemento(cad, lista->sig);
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
