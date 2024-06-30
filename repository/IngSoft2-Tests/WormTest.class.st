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
	| aPlayer someDice aLoadedBoard aGame worms|
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aLoadedBoard := LoadedBoard clone: (Board
			                 withSize: 20
			                 withWorms: true
			                 withParsecs: 1
			                 withDice: someDice).
	aGame := Game
		         withBoard: aLoadedBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.

	worms := aLoadedBoard findWormSquares.
	aLoadedBoard place: aPlayer at: (worms at: 1) - 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: (worms at: 2)
	
]
