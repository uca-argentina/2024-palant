Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
Effect >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [
	self subclassResponsibility.
]
