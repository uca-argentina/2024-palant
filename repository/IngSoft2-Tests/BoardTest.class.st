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
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'TestShip' withFuel: 1000.
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 4.
	self assert: (aShip getShipPosition = 5).
]

{ #category : #tests }
BoardTest >> testBoardCanMoveShipBackwards [
	|aShip aBoard|
	aBoard := Board withSize: 10 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'PEPE' withFuel: 1000.
	aBoard place: aShip at: 5.
	aBoard move: aShip distance: -3.
	self assert: (aShip getShipPosition = 2).  
]

{ #category : #tests }
BoardTest >> testBoardCanPlaceShip [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aShip := Ship named: 'TestShip' withFuel: 1000.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aBoard place: aShip at: 3.
	self assert: (aShip getShipPosition = 3).
]

{ #category : #tests }
BoardTest >> testBoardIsCreatedWithNSquares [
	|aBoard aBoardSize|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
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
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'testShip' withFuel: 1000.
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: -3.
	self assert: (aShip getShipPosition = 8).
]

{ #category : #tests }
BoardTest >> testTakeOutReturnsTrueWhenShipGetsRemoved [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aShip := Ship named: 'testShip' withFuel: 1000.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aBoard place: aShip at: 3.
	aBoard takeOut: aShip.
	self assert: (aShip getShipPosition = -1).
]

{ #category : #tests }
BoardTest >> testValidWhenShipGetsResetToStart [

	|aShip aBoard|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	aBoard := Board withSize: 100 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aBoard place: aShip at: 5.
	aBoard resetToStart: aShip.
	self assert: (aShip getShipPosition = 1).  
]
