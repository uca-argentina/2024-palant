Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Deck class >> getDeck [
	^(#(Cancellation Repeat Acceleration Ally Overload Redo) asOrderedCollection).
	
]

{ #category : #'as yet unclassified' }
Deck class >> getRandomCards: cardAmount [
	|deck hand|
	hand := OrderedCollection new.
	deck := self getDeck.
	(1 to: cardAmount) do: [:x | hand add: (deck at: ((1 to: deck size) atRandom))] .
	^hand.
]
