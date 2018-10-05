#!/usr/bin/env python
# -*- coding: utf-8 -*-
from anytree import Node, RenderTree
class MyNode(Node):
    separator = '-'

class Automata:
    def __init__(self, ):
        self.estados = list()
        self.sigma = list()
        self.inicial = 0
        self.finales = list()
        self.transiciones = list()
        self.nivel = 0
        self.raiz = MyNode(self.inicial)
        self.errores = list()

    def setEstados(self, estados):
        for estado in estados.split(','):
            self.estados.append(int(estado))

    def getEstados(self,):
        return self.estados

    def setSigma(self, alfabeto):
        for caracter in alfabeto[:-1].split(','):
            self.sigma.append(caracter)

    def getSigma(self,):
        return self.sigma

    def setInicial(self, inicio):
        self.inicial = int(inicio[:-1].split(' ')[0])

    def getInicial(self,):
        return self.inicial

    def setFinales(self, estados):
        for estado in estados[:-1].split(','):
            self.finales.append(int(estado))

    def getFinales(self,):
        return self.finales

    def addTransicion(self, transicion):
        aux = transicion[:-1].split(',')
        self.transiciones.append([int(aux[0]),aux[1],int(aux[2])])

    def getTransiciones(self,):
        return self.transiciones

    def getNivel(self,):
        return self.nivel

    def fillTransicion(self,):
        aux = list()
        for estado in self.estados:
            for caracter in self.sigma:
                aux.append([estado,caracter])
        estado = False
        for row in aux:
            found = False
            for transicion in self.transiciones:
                if transicion[0] == row[0] and transicion[1] == row[1]:
                    found = True
                    break
            if not found:
                if not estado:
                    self.estados.append(self.estados[-1]+1)
                    estado = True
                self.transiciones.append([row[0], row[1], self.estados[-1]])
        if estado:
            for caracter in self.sigma:
                self.transiciones.append([self.estados[-1], caracter, self.estados[-1]])

    def printTransiciones(self,):
        for transicion in self.transiciones:
            print("{}({})={}".format(transicion[0], transicion[1], transicion[2]))

    def validar(self, estado, cad, nodo):
        if cad == '':
            if estado in self.finales:
                print("Cadena valida: {}".format(str(nodo).strip('MyNode(').strip(')')))
            else:
                print("!Cadena invalida!", estado)
        elif cad[0] in self.sigma:
            siguientes = self.siguientes(estado, cad[0])
            for sig in siguientes:
                hijo = MyNode(sig, parent=nodo)
                self.validar(sig, cad[1:], hijo)
        else:
            self.validar(estado, cad[1:], nodo)

    def siguientes(self, estado, caracter):
        out = list()
        for transicion in self.transiciones:
            if transicion[0] == estado and transicion[1] == caracter:
                out.append(transicion[2])
        return out

    def getRaiz(self,):
        return self.raiz

    def resetNivel(self,):
        self.nivel = 0

    def stripData(self, cad):
        for char in cad:
            if char not in self.sigma:
                print("Warning: {} -> {}".format(char, self.nivel))
            else:
                self.nivel += 1
