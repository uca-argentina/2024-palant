Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
CardDealer class >> withTypes: someCardTypes [
 ^(self new) initializeTypes: someCardTypes.
]

{ #category : #application }
CardDealer >> applyEffect: affectedPlayer withPlayers: somePlayers inBoard: aBoard [

	affectedPlayer addCards: (self randomCard: 1)
]

{ #category : #application }
CardDealer >> initializeTypes: someCardTypes [
	cardTypes := someCardTypes.
]

{ #category : #application }
CardDealer >> randomCard: someAmount [
	|cardsChosenIndex|
	cardsChosenIndex := (1 to: (cardTypes size)) atRandom.
	^ OrderedCollection with: (cardTypes at: cardsChosenIndex)
]
