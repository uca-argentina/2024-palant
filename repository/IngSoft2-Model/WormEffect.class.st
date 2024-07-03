Class {
	#name : #WormEffect,
	#superclass : #Effect,
	#instVars : [
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormEffect class >> withLink: linkPos [
	^(self new) initializeLink: linkPos.
]

{ #category : #application }
WormEffect >> applyEffect: affectedPlayer [

	board takeOut: affectedPlayer.
	board place: affectedPlayer at: linkPosition
]

{ #category : #initialization }
WormEffect >> initializeLink: linkPos [
	linkPosition := linkPos.
]
