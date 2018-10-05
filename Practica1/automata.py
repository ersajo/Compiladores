#!/usr/bin/env python
# -*- coding: utf-8 -*-

class Automata:
    def __init__(self, ):
        self.estados = list()
        self.sigma = list()
        self.inicial = ''
        self.finales = list()
        self.transiciones = list()
        self.Nivel = 0

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
        return self.Nivel

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
