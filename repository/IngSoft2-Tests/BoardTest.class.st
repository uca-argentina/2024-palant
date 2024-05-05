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
BoardTest >> testPlaceAndTakeOutInInvalidPositionThrowsError [
	|aBoard aBoardSize aShip|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize .
	self should: [aBoard place: aShip at: 6] raise: Error withMessage: 'Cannot place ship outside the board.'.
	aBoard place: aShip at: 4.
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
