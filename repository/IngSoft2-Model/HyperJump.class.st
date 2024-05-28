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
	aBoard move: affectedShip distance: ( self cycleParsec * ( aBoard boardSize / aBoard getParsecs ) ) truncated .
]

{ #category : #'as yet unclassified' }
HyperJump >> cycleParsec [

	| temp |
	temp := parsecList at: parsecList size.
	parsecList removeLast.
	parsecList addFirst: temp.
	^ temp
]

{ #category : #'as yet unclassified' }
HyperJump >> initializeParsecs: aParsecList [
	parsecList := aParsecList.
	parsecList sort.
]
