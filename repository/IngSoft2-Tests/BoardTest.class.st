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
	aBoard := Board withSize: aBoardSize.
	aShip := Ship named: 'testShip'.
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 20.
	self assert: ((aBoard findShip: aShip) == (aBoard boardSize)).
]

{ #category : #tests }
BoardTest >> testMoveReturnsTrueWhenValidMovement [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize.
	aShip := Ship named: 'TestShip'.
	aBoard place: aShip at: 1. 
	self assert: (aBoard move: aShip distance: 4).
]

{ #category : #tests }
BoardTest >> testPlaceReturnsTrueWhenValidPlacement [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize .
	self assert: (aBoard place: aShip at: 3).
]

{ #category : #tests }
BoardTest >> testTakeOutReturnsTrueWhenShipGetsRemoved [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize .
	aBoard place: aShip at: 3.
	self assert: (aBoard takeOut: aShip).
]
