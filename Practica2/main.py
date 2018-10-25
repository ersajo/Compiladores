#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
***Ejemplos de salidas para los caminos validos***

camino 1:
0(a) -> 0(b) -> 0(a) -> 0(b) -> 0
errores:
0(@), 0(*)

camino 2:
0(a) -> 0(b) -> 0(a) -> 1(b) -> 2
errores:
1(@), 2(*)
"""

from automata import *

aut = Automata()

automataFile = open("ejemplo.txt", "r")

aut.setEstados(automataFile.readline())
aut.setSigma(automataFile.readline())
aut.setInicial(automataFile.readline())
aut.setFinales(automataFile.readline())
for line in automataFile.readlines():
    aut.addTransicion(line)

automataFile.close()

print("")
print("*"*10, "Entrada", "*"*10)
print("Estados:", aut.getEstados())
print("Sigma:", aut.getSigma())
print("Estado Incial:", aut.getInicial())
print("Estados Finales:", aut.getFinales())
print("Transiciones:")
aut.printTransiciones()
print("*"*10, "Entrada", "*"*10)

aut.fillTransicion()

print("\n")
print("*"*10, "Automata completo", "*"*10)
print("Transiciones:")
aut.printTransiciones()

print("*"*10, "Automata completo", "*"*10)
print("\n")

while True:
    cad = input("Introduce una cadena para evaluar>>")
    if cad == "exit":
        exit()
    aut.reset(cad[0])
    aut.validar(aut.getInicial(), cad, aut.getRaiz(), aut.getError())
    #aut.printTree()
    print("*"*40)
