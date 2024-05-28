"
Worm Square consists of a pair that teleports a ship to the according 'linked' square instead of docking it in itself.
"
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

{ #category : #modifying }
WormSquare >> landShip: aShip [
	dockedShips add: aShip.
	^true.
]
