Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
BoardTest >> testBoardCanMoveShip [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip. 
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: 4.
	self assert: (aShip getShipPosition = 5).
]

{ #category : #tests }
BoardTest >> testBoardCanMoveShipBackwards [
	|aShip aBoard aPlayer|
	aBoard := Board withSize: 10 withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 5.
	aBoard move: aPlayer distance: -3.
	self assert: (aShip getShipPosition = 2).  
]

{ #category : #tests }
BoardTest >> testBoardCanPlaceShip [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 4.
	aShip := Ship withFuel: 1000.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 3.
	self assert: (aShip getShipPosition = 3).
]

{ #category : #tests }
BoardTest >> testBoardIsCreatedWithNSquares [
	|aBoard aBoardSize|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	self assert: aBoard boardSize equals: aBoardSize.
]

{ #category : #tests }
BoardTest >> testBoardSizeCanBeExpressedWithParsecs [

	|aBoard|
	aBoard := Board withSize: 10 withWorms: false withParsecs: 5 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	self assert: aBoard getParsecs equals: 5.
]

{ #category : #tests }
BoardTest >> testShipsCanExceedBoardGoingBackwards [ 
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: -3.
	self assert: (aShip getShipPosition = 8).
]

{ #category : #tests }
BoardTest >> testTakeOutReturnsTrueWhenShipGetsRemoved [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 4.

	aShip := Ship withFuel: 1000.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 3.
	aBoard takeOut: aPlayer.
	self assert: (aShip getShipPosition = -1).
]

{ #category : #tests }
BoardTest >> testValidWhenShipGetsResetToStart [

	|aShip aBoard aPlayer|
	aShip := Ship withFuel: 1000.
	aBoard := Board withSize: 100 withWorms: false withParsecs: 3 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 5.
	aBoard resetToStart: aPlayer.
	self assert: (aShip getShipPosition = 1).  
]
