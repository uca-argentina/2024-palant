Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'parsecList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperJump class >> withParsecs: parsecs [
	^(self new) initializeParsecs: parsecs.
]

{ #category : #'as yet unclassified' }
HyperJump >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [
	aBoard move: affectedShip distance: ((aBoard boardSize) // (self cycleParsec)). 
	
]

{ #category : #'as yet unclassified' }
HyperJump >> cycleParsec [
	|temp|
	temp := (parsecList at: (parsecList size)).
	parsecList removeLast.
	parsecList addFirst: temp.
	Transcript show: temp.
	Transcript show: '\n'.
	Transcript show: parsecList.
	^temp.
]

{ #category : #'as yet unclassified' }
HyperJump >> initializeParsecs: aParsecList [
	parsecList := aParsecList.
	parsecList sort.
]
