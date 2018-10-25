#!/usr/bin/env python
# -*- coding: utf-8 -*-
from anytree import Node, RenderTree

class NodoAutomata(Node):
    separator = ' -> '

class NodoError(Node):
    separator = ','

class Automata:
    def __init__(self, ):
        self.estados = list()
        self.sigma = list()
        self.inicial = 0
        self.finales = list()
        self.transiciones = list()
        self.raiz = NodoAutomata('')
        self.errores = NodoError('')
        self.errores = list()

    def setEstados(self, estados):
        for estado in estados.split(','):
            self.estados.append(int(estado))

    def getEstados(self,):
        return self.estados

    def setSigma(self, alfabeto):
        for caracter in alfabeto[:-1].split(','):
            self.sigma.append(str(caracter))

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

    def validar(self, estado, cad, nodoAut, nodoError):
        if cad == '':
            epsilon = self.epsilon(estado)
            for sig in epsilon:
                text = "{}({})".format(estado, 'E')
                hijo = NodoAutomata(text, parent=nodoAut)
                self.validar(sig, cad, hijo, nodoError)
            if estado in self.finales:
                if str(nodoError) != "NodoError(',')":
                    print("Cadena valida con error:\n{} -> {}".format(str(nodoAut).strip('NodoAutomata(')[10:-2],estado))
                    print("Errores:\n{}\n".format(str(nodoError).strip('NodoError()')[3:-1]))
                else:
                    print("Cadena valida sin error:\n{} -> {}\n".format(str(nodoAut).strip('NodoAutomata(')[10:-2], estado))
            else:
                print("!Cadena invalida!")
        elif cad[0] == 'E':
            self.validar(estado, cad[1:], nodoAut, nodoError)
        elif cad[0] in self.sigma:
            siguientes = self.siguientes(estado, cad[0])
            for sig in siguientes:
                text = "{}({})".format(estado, cad[0])
                hijo = NodoAutomata(text, parent=nodoAut)
                self.validar(sig, cad[1:], hijo, nodoError)
            epsilon = self.epsilon(estado)
            for sig in epsilon:
                text = "{}({})".format(estado, 'E')
                hijo = NodoAutomata(text, parent=nodoAut)
                self.validar(sig, cad, hijo, nodoError)
        else:
            text = "{}({})".format(estado, cad[0])
            error = NodoError(text, parent=nodoError)
            self.validar(estado, cad[1:], nodoAut, error)

    def siguientes(self, estado, caracter):
        out = list()
        for transicion in self.transiciones:
            if transicion[0] == estado and transicion[1] == caracter:
                out.append(transicion[2])
        return out

    def epsilon(self, estado):
        out = list()
        for transicion in self.transiciones:
            if transicion[0] == estado and transicion[1] == 'E':
                out.append(transicion[2])
        return out

    def getRaiz(self,):
        return self.raiz

    def reset(self, char):
        del self.raiz, self.errores
        cad = "{}({})".format(self.inicial, char)
        self.raiz = NodoAutomata(cad)
        self.errores = NodoError('')

    def getError(self,):
        return self.errores

    def printTree(self,):
        print(RenderTree(self.raiz))
        print(RenderTree(self.errores))
