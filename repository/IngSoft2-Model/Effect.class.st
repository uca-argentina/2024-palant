Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [
	self subclassResponsibility.
]
