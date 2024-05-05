Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
GameTest >> testValidGameCanBePlayed [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 20.
	someDice := OrderedCollection with: (Die of: 6) with: (Die of: 5).
	game:= Game new.
	game initializeShips: someShips.
	game initializeBoard: aBoard.
	game initializeDice: someDice.
	game begin.
	self assert: (game getStatus) = 'Playing'.
]

{ #category : #tests }
GameTest >> testValidGameCanBeginWhenInitialized [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 20.
	someDice := OrderedCollection with: (Die of: 6) with: (Die of: 5).
	game:= Game new.
	game initializeShips: someShips.
	game initializeBoard: aBoard.
	game initializeDice: someDice.
	game begin.
	self assert: (game getStatus) = 'Launching'.
]

{ #category : #tests }
GameTest >> testValidGameCanFinish [
	|game someShips aBoard someDice|
	
	someShips := OrderedCollection with: (Ship named: 'Pepe').	
	aBoard := Board withSize: 20.
	someDice := OrderedCollection with: (Die of: 6) with: (Die of: 5).
	game:= Game new.
	game initializeShips: someShips.
	game initializeBoard: aBoard.
	game initializeDice: someDice.
	game begin.
	self assert: (game getStatus) = 'Over'.
]
