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

{ #category : #application }
HyperJump >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [

	aBoard
		move: affectedShip
		distance:
		(self cycleParsec * (aBoard boardSize / aBoard getParsecs))
			truncated
]

{ #category : #utility }
HyperJump >> cycleParsec [

	| temp |
	temp := parsecList at: parsecList size.
	parsecList removeLast.
	parsecList addFirst: temp.
	^ temp
]

{ #category : #initialization }
HyperJump >> initializeParsecs: aParsecList [
	parsecList := aParsecList.
	parsecList sort.
]
