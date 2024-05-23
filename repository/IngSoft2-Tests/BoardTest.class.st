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
BoardTest >> testBoardIsCreatedWithNSquares [
	|aBoard aBoardSize|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize .
	self assert: aBoard boardSize equals: aBoardSize.
]

{ #category : #tests }
BoardTest >> testMoveDoesntExceedBoard [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false.
	aShip := Ship named: 'testShip' withTank: (FuelTank withMax: 10000).
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 14.
	self assert: ((aBoard findShip: aShip) = 5).
]

{ #category : #tests }
BoardTest >> testMoveReturnsTrueWhenValidMovement [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false.
	aShip := Ship named: 'TestShip' withTank: (FuelTank withMax: 10000).
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 4.
	self assert: ((aBoard findShip: aShip) = 5)
]

{ #category : #tests }
BoardTest >> testPlaceReturnsTrueWhenValidPlacement [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize withWorms: false .
	aBoard place: aShip at: 3.
	self assert: ((aBoard findShip: aShip) = 3).
]

{ #category : #tests }
BoardTest >> testShipCanMoveBackwards [
	|aShip aBoard|
	aBoard := Board withSize: 10 withWorms: false.
	aShip := Ship named: 'PEPE'.
	aBoard place: aShip at: 5.
	aBoard move: aShip distance: -3.
	self assert: ((aBoard findShip: aShip) = 2).  
]

{ #category : #tests }
BoardTest >> testShipsCanDoBackwardsLaps [ 
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false.
	aShip := Ship named: 'testShip' withTank: (FuelTank withMax: 10000).
	aBoard place: aShip at: 1. 
	aShip addLap.
	aBoard move: aShip distance: -3.
	self assert: ((aBoard findShip: aShip) = 8).
]

{ #category : #tests }
BoardTest >> testShipsLapsIncreseWhenItGoesPastEndSquare [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize.
	aShip := Ship named: 'testShip' withTank: (FuelTank withMax: 10000).
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 14.
	self assert: ((aShip getLaps ) = 1).
]

{ #category : #tests }
BoardTest >> testTakeOutReturnsTrueWhenShipGetsRemoved [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize .
	aBoard place: aShip at: 3.
	aBoard takeOut: aShip.
	self assert: ((aBoard findShip: aShip) = -1).
]
