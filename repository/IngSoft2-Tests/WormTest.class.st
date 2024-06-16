Class {
	#name : #WormTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTest >> testWormHolesAreInitialized [

	|aBoard testingBoard wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	testingBoard := LoadedBoard clone: aBoard.
	wormPositions := testingBoard findWormSquares.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
WormTest >> testWormHolesTeleportShips [
	|aBoard testingBoard aShip wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	testingBoard := LoadedBoard clone: aBoard.
	aShip := Ship named: 'TestShip' withFuel: 1000.
	wormPositions := testingBoard findWormSquares.
	aBoard place: aShip at: (wormPositions at: 1).
	(aBoard move: aShip distance: -1).
	(aBoard move: aShip distance: 1) applyEffect: aShip withShips: (OrderedCollection with: aShip) inBoard: aBoard .
	self assert: (aShip getShipPosition ) equals: (wormPositions at: 2)
]
