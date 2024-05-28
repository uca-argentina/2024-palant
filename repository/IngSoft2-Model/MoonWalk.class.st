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

{ #category : #'as yet unclassified' }
MoonWalk >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [
	someShips do: [ :aShip | 
			(affectedShip = aShip) ifFalse: [ 
					aBoard move: aShip distance: (myDistance)*(-1). 
				 ]
		 ].
]

{ #category : #'as yet unclassified' }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
