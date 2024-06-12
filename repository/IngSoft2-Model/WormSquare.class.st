"
Worm Square consists of a pair that teleports a ship to the according 'linked' square instead of docking it in itself.
"
Class {
	#name : #WormSquare,
	#superclass : #Square,
	#instVars : [
		'linkedSquare',
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
WormSquare >> dockShip: aShip [

	aShip setShipPosition: linkPosition.
	linkedSquare landShip: aShip.
	^ NullEffect new
]

{ #category : #initialization }
WormSquare >> initializeLink: aWormSquare withPosition: aPosition [

	linkedSquare := aWormSquare.
	linkPosition := aPosition.
]

{ #category : #modifying }
WormSquare >> landShip: aShip [

	dockedShips add: aShip.
	^ NullEffect new
]
