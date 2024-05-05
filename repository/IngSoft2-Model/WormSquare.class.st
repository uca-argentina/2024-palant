Class {
	#name : #WormSquare,
	#superclass : #Square,
	#instVars : [
		'linkedSquare'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
WormSquare >> dockShip: aShip [
	linkedSquare landShip: aShip.
	^true.
]

{ #category : #initialization }
WormSquare >> initializeLink: aWormSquare [
	linkedSquare := aWormSquare.
]

{ #category : #initialization }
WormSquare >> landShip: aShip [
	dockedShips add: aShip.
	^true.
]
