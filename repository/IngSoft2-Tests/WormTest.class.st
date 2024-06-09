Class {
	#name : #WormTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTest >> testWormHolesAreInitialized [
	|aBoard wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 0.
	wormPositions := aBoard findWormSquares.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
WormTest >> testWormHolesTeleportShips [
	|aBoard aShip wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 0.
	aShip := Ship named: 'TestShip' withFuel: 1000.
	wormPositions := aBoard findWormSquares.
	aBoard place: aShip at: (wormPositions at: 1).
	self assert: (aBoard findShip: aShip) equals: (wormPositions at: 2).
]
