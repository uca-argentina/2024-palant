Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Deck class >> withCardTypes: someCardTypes [

	^(self new) initializeCardTypes: someCardTypes.
]

{ #category : #initialization }
Deck >> getCardTypes [
	^cardTypes.
]

{ #category : #initialization }
Deck >> initializeCardTypes: someCardTypes [
	cardTypes := someCardTypes
]
