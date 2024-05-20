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
GameTest >> testValidGameCanBeInitialized [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 20.
	someDice := OrderedCollection with: (Die of: 6) with: (Die of: 5).
	game:= Game new.
	game initializeShips: someShips.
	game initializeBoard: aBoard.
	game initializeDice: someDice.

	self assert: (game hasBeenInitialized).
]

{ #category : #tests }
GameTest >> testValidGameCanFinish [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 40.
	someDice := OrderedCollection with: (Die of: 3) with: (Die of: 4).
	game:= Game new.
	game initializeShips: someShips.
	game initializeBoard: aBoard.
	game initializeDice: someDice.
	game begin.
	self assert: (game getStatus) = 'Over'.
]

{ #category : #tests }
GameTest >> testValidGameCannotBeginWhenUninitialized [
	self should:[(Game new) begin.] raise: Error withMessage: 'Cannot begin an uninitialized game.'.
]
