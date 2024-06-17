Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'players',
		'myTarget',
		'lastEffect',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> withPlayers: allPlayers withTarget: aTarget withLast: lastEffect withBoard: aBoard [
	^(self new) initializePlayers: allPlayers initializeTarget: aTarget initializeLast: lastEffect initializeBoard: aBoard.
]

{ #category : #initialization }
Card >> applyCardEffect [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializePlayers: allPlayers initializeTarget: aTarget initializeLast: effect initializeBoard: aBoard [
	players := allPlayers.
	myTarget := aTarget.
	lastEffect := effect.
	board := aBoard.
]
