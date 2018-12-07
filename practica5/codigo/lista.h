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
