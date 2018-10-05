#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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
print("Nivel:", aut.getNivel())
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
    aut.stripData(cad)
    aut.validar(aut.getInicial(), cad, aut.getRaiz())
    aut.resetNivel()
