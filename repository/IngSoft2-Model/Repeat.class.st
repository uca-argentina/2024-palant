Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Repeat >> applyCardEffect [
	(lastEffect at: 1) applyEffect: (myTarget at: 1) withPlayers: players inBoard: board. 
]
