Class {
	#name : #WormTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTest >> test01WormHolesAreInitialized [

	|aBoard testingBoard wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	testingBoard := LoadedBoard clone: aBoard.
	wormPositions := testingBoard findWormSquares.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
WormTest >> test02WormHolesTeleportShips [
	|aBoard testingBoard aShip aPlayer wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	testingBoard := LoadedBoard clone: aBoard.
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	wormPositions := testingBoard findWormSquares.
	aBoard place: aPlayer at: (wormPositions at: 1).
	(aBoard move: aPlayer distance: -1).
	(aBoard move: aPlayer distance: 1) applyEffect: aPlayer withPlayers: (OrderedCollection with: aPlayer) inBoard: aBoard .
	self assert: (aPlayer ship getShipPosition ) equals: (wormPositions at: 2)
]
