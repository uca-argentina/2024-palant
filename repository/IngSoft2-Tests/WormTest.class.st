Class {
	#name : #WormTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTest >> testWormHolesAreInitialized [
	|aBoard wormPositions|
	aBoard := Board withSize: 20.
	wormPositions := aBoard findWormSquares.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
WormTest >> testWormHolesTeleportShips [
	|aBoard aShip wormPositions|
	aBoard := Board withSize: 20.
	aShip := Ship named: 'TestShip'.
	wormPositions := aBoard findWormSquares.
	aBoard place: aShip at: (wormPositions at: 1).
	self assert: (aBoard findShip: aShip) equals: (wormPositions at: 2).
]
