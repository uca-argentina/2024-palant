Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
Effect >> applyEffect: affectedPlayer withPlayers: somePlayers inBoard: aBoard [

	self subclassResponsibility
]
