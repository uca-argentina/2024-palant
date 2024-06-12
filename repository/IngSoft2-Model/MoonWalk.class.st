Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'myDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withDistance: aDistance [
 ^(self new) initializeDistance: aDistance.
]

{ #category : #application }
MoonWalk >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [

	someShips do: [ :aShip |
		affectedShip = aShip ifFalse: [
			aShip getGravity > 0 ifFalse: [
				aBoard move: aShip distance: myDistance * -1 ] ] ]
]

{ #category : #initialization }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
