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
	|aShip bShip cShip ships board dice game results|
	
	dice := OrderedCollection with: (LoadedDie of: 3).
	aShip := Ship named: 'Pepe' withFuel: 1000.
	bShip := Ship named: 'Pedro' withFuel: 1000.
	cShip := Ship named: 'Juan' withFuel: 1000.
	ships := OrderedCollection with: aShip with: bShip with: cShip.
	
	board := Board withSize: 100 withWorms: false withParsecs: 0.
	
	game := Game new.
	game initializeBoard: board initializeDice: dice initializeShips: ships initializeMaxLaps: 3.
	board place: aShip at: 10.
	board place: bShip at: 50.
	board place: cShip at: 1.
	board move: cShip distance: 120.
	results := game getRanking.
	self assert:((results first key) asString = cShip getName ).
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
	game playTurn: (myShip).
	myShip resetFuelTank.
	game playTurn: (myShip).
	myShip resetFuelTank.
	game playTurn: (myShip).
	myShip resetFuelTank.
	game playTurn: (myShip).
	myShip resetFuelTank.
	game playTurn: (myShip).
	myShip resetFuelTank.
	self assert: (game hasWinner) equals: true.
]
