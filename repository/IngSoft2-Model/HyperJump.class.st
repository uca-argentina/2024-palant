Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distanceList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperJump class >> withUnits: aUnitList withBoard: aBoard [
	^(self new) initializeDistances: aUnitList initializeBoard: aBoard
]

{ #category : #application }
HyperJump >> applyEffect: affectedPlayer [

	board
		move: affectedPlayer
		distance:
		(self cycleDistance)
]

{ #category : #utility }
HyperJump >> cycleDistance [
	| temp |
	temp := distanceList at: distanceList size.
	distanceList removeLast.
	distanceList addFirst: temp.
	^ temp
]

{ #category : #utility }
HyperJump >> initializeDistances: aUnitList initializeBoard: aBoard [
	distanceList := OrderedCollection new.
	aUnitList do: [ :someUnit | distanceList add: (someUnit parseToSquares: (aBoard boardSize) parsecAmount: (aBoard getParsecs) )].
	distanceList sort.
]
