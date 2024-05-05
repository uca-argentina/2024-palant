Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> named: aName [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName.
]

{ #category : #testing }
Ship >> initializeName: aName [

	name := aName.
]

{ #category : #testing }
Ship >> isNamed [
	^true.
]

{ #category : #'as yet unclassified' }
Ship >> rollDice: someDice [ 
	|result|
	result := 0.
	someDice do: [ :die | result:= result  + die throw ].
	^result.
]
