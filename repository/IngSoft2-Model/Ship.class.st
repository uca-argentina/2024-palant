Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'name',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> named: aName [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName.
]

{ #category : #testing }
Ship >> getName [
	^name.
]

{ #category : #testing }
Ship >> initializeName: aName [
	winner := false.
	name := aName.
]

{ #category : #testing }
Ship >> isNamed [
	^true.
]

{ #category : #testing }
Ship >> isWinner [
	^winner.
]

{ #category : #'as yet unclassified' }
Ship >> rollDice: someDice [ 
	|result|
	result := 0.
	someDice do: [ :die | result:= result  + die throw ].
	^result.
]

{ #category : #testing }
Ship >> setWinner [
	winner := true.
]
