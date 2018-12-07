#include <stdio.h>
#include <stdlib.h>

typedef struct Elem{
  char *tipo;
  int entero;
  double decimal;
  char* cadena;
}Elem;

typedef struct List{
  char* valor;
  int len;
  Elem elemento;
  struct List *sig;
}List;

int sizeString(char *string);
void newList(List *l);
int Insertar (Elem e, char* cad, List* lista);
int len(List* lista);
int Pertenece (char* cad, List* lista);
Elem getElemento(char* cad, List* lista);
void newElem(Elem* e);
int isEmpty(List* l);
void printList(List* l);

int main() {
  List lista;
  newList(&lista);
  Elem e1;
  newElem(&e1);
  char *aux1 = "var1";
  e1.tipo = "entero";
  e1.entero = 4;
  Elem e2;
  newElem(&e2);
  char *aux2 = "var2";
  e2.tipo = "float";
  e2.decimal = 4.5;

  printf("1 len: %d\n", len(&lista));
  printf("1 Pertenece: %d\n", Pertenece(aux1,&lista));
  printf("aux: %s\tsizeString: %d\n", aux1,sizeString(aux1));
  printf("1 isEmpty: %d\n", isEmpty(&lista));
  printf("1 Insertar: %d\n", Insertar(e1,aux1,&lista));
  printf("2 isEmpty: %d\n", isEmpty(&lista));
  printf("2 Pertenece: %d\n", Pertenece(aux1,&lista));
  printf("2 len: %d\n", len(&lista));
  printf("3 Pertenece: %d\n", Pertenece(aux2,&lista));
  //printList(&lista);
  printf("2 Insertar: %d\n", Insertar(e2,aux2,&lista));
  printf("3 len: %d\n", len(&lista));
  printf("4 Pertenece: %d\n", Pertenece(aux1,&lista));
  printf("5 Pertenece: %d\n", Pertenece(aux2,&lista));
  //pos = getElemento(aux2, &lista);
  //printf("getElemento: %s\n", pos.tipo);
  return 0;
}

int sizeString(char* string){
  int i = 0;
  while(string[i]){i++;}
  return i;
}

void newList(List *l){
  l->valor = "\0";
  l->sig = NULL;
  l->len = 0;
}

int Insertar (Elem e, char* cad, List* lista){
  if(isEmpty(lista)){
    lista->valor = cad;
    lista->elemento = e;
    lista->len = lista->len + 1;
    lista->sig = NULL;
    return 1;
  }else{
    if(cad == lista->valor){
      return 0;
    }else{
      if(lista->sig == NULL){
        List l;
        l.valor = cad;
        l.elemento = e;
        l.len = 1;
        l.sig = NULL;
        lista->sig = &l;
        lista->len = lista->len + 1;
      }else{
        Insertar(e,cad,lista->sig);
      }
    }
  }
}

int len(List* lista){
  return lista->len;
}

int Pertenece (char* cad, List* lista){
  if(isEmpty(lista)){
    return 0;
  }else{
    if(cad == lista->valor){
      return 1;
    }else{
      if(lista->sig == NULL){
        return 0;
      }
      Pertenece(cad,lista->sig);
    }
  }
}

Elem getElemento(char* cad, List* lista){
  printf("%s\t%s\n",cad, lista->valor);
  if(cad == lista->valor){
    return lista->elemento;
  }else{
    if(lista->sig != NULL){
      getElemento(cad, lista->sig);
    }else{
      Elem e;
      newElem(&e);
      return e;
    }
  }
}

void newElem(Elem *e){
  e->tipo = "\0";
  e->entero = 0;
  e->decimal = 0;
  e->cadena = 0;
}

int isEmpty(List* l){
  return (l->sig==NULL && l->len==0 && l->valor=="\0") ? 1:0;
}

void printList(List* l){
  fflush(stdout);
  printf("v: %s\n", l->valor);
  if (l->sig != NULL){
    printList(l->sig);
  }
  if(isEmpty(l)){
    printf("LISTA VACIA!\n");
  }
}
