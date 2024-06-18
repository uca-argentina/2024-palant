Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo class >> canBeUsedAnytime [
	^(thisContext sender receiver) getLastCard canBeUsedAnytime.
]

{ #category : #'as yet unclassified' }
Redo class >> withPlayers: allPlayers withTarget: aTarget withLast: lastEffect withBoard: aBoard [
	^(self new) initializePlayers: allPlayers initializeTarget: aTarget initializeLast: lastEffect initializeBoard: aBoard.
]

{ #category : #initialization }
Redo >> applyCardEffect [
	((lastEffect at: 2) withPlayers: players withTarget: myTarget withLast: lastEffect withBoard: board) applyCardEffect.  
]
