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
	
	dice := OrderedCollection with: (LoadedDie of: 4).
	aShip := Ship named: 'Pepe'.
	bShip := Ship named: 'Pedro'.
	cShip := Ship named: 'Juan'.
	ships := OrderedCollection with: aShip with: bShip with: cShip.
	board := Board withSize: 100.
	
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
GameTest >> testValidGameCanBeInitialized [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 20.
	someDice := OrderedCollection with: (Die of: 6) with: (Die of: 5).
	game:= Game new.
	game initializeBoard: aBoard initializeDice: someDice initializeShips: someShips.

	self assert: (game hasBeenInitialized).
]

{ #category : #tests }
GameTest >> testValidGameCanFinish [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 40.
	someDice := OrderedCollection with: (Die of: 3) with: (Die of: 4).
	game:= Game new.
	game initializeBoard: aBoard initializeDice: someDice initializeShips: someShips initializeMaxLaps: 3.
	game begin.
	self assert: (game getStatus) = 'Over'.
]

{ #category : #tests }
GameTest >> testValidGameCannotBeginWhenUninitialized [
	self should:[(Game new) begin.] raise: Error withMessage: 'Cannot begin an uninitialized game.'.
]
