Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
GameTest >> testGameCanGetRankingAndOrdersShipsCorrectly [
	|aGame aBoard someDice ships|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	aBoard := Board withSize: 30 withWorms: false withParsecs: 0 withDice: someDice.
	aGame := Game withBoard: aBoard withDice: someDice  withShips: 3 withMaxLaps: 10.
	ships := aGame getShips.
	aBoard place: (ships at: 1) at: 3.
	aBoard place: (ships at: 2) at: 19.
	aBoard place: (ships at: 3) at: 29.
	self assert: (aGame getRanking at: 1) equals: (ships at: 3).
]

{ #category : #tests }
GameTest >> testValidGameCanFinish [
	|game aBoard someDice someShips myShip|
	aBoard := Board withSize: 10 withWorms: false withParsecs: 0.
	someDice := OrderedCollection with: (LoadedDie of: 11).
	aBoard initializeRandomEffects: someDice. 
	
	game := Game withBoard: aBoard withDice: someDice withShips: 1 withMaxLaps: 2.
	someShips := game getShips. 
	myShip := someShips at: 1.
	game giveTurn: (myShip).
	game skipTurn: myShip.
	game giveTurn: (myShip).
	game skipTurn: myShip.
	game giveTurn: (myShip).
	game skipTurn: myShip.
	game giveTurn: (myShip).
	game skipTurn: myShip.
	game giveTurn: (myShip).
	game skipTurn: myShip.
	self assert: (game hasWinner) equals: true.
]
