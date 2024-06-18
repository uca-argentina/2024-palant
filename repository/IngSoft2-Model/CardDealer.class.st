Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #application }
CardDealer >> applyEffect: affectedPlayer withPlayers: somePlayers inBoard: aBoard [
	affectedPlayer addCards: (Deck getRandomCards: 1).
]
