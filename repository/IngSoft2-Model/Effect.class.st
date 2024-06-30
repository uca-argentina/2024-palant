Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'players',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #application }
Effect >> applyEffect: affectedPlayer [

	self subclassResponsibility
]

{ #category : #application }
Effect >> initializePlayers: somePlayers initializeBoard: aBoard [
players := somePlayers.
board := aBoard.
]
