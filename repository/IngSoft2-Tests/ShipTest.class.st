Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
ShipTest >> testIsValidWhenShipsFuelReducesProportionallyToMovement [

	| aShip aPlayer aBoard |
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 10.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer distance: 5.
	self assert: aShip getFuel equals: 5
]

{ #category : #tests }
ShipTest >> testPassesWhenShipCanRollMultipleDice [
	
	|aPlayer dice |
	dice:= OrderedCollection new.
	dice add: (LoadedDie of: 4).
	dice add: (LoadedDie of: 5).
	aPlayer := Player named: 'Pepe' withShip: 1.
	self assert: ((aPlayer rollDice: dice) = 9).
]

{ #category : #tests }
ShipTest >> testShipDoesntMoveWhenSkipsTurn [
	|aPlayer aBoard aGame|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 1.
	aGame skipTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
ShipTest >> testShipGetsRefueledWhenSkipsTurn [
	|aPlayer aBoard aGame|
	aBoard :=LoadedBoard clone: ( Board withSize: 20 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3))).
	aBoard removeEffects.
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 1.
	aGame playTurn: aPlayer.
	aGame skipTurn: aPlayer.
	self assert: (aPlayer ship getFuel) equals: 6. 
]

{ #category : #tests }
ShipTest >> testShipsLapsIncreseWhenItGoesPastEndSquare [
	|aBoard aBoardSize aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 1000).
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: 14.
	self assert: (aPlayer ship getLaps ) equals: 1.
]

{ #category : #tests }
ShipTest >> testShipsLapsReduceWhenExceedsBoardGoingBackwards [
	|aBoard aBoardSize aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 1000).
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: -5.
	aPlayer ship addLaps: 2.
	self assert: (aPlayer ship getLaps ) equals: 1.
]

{ #category : #tests }
ShipTest >> testShipsPositionIsResetWhenShipDoesNotHaveEnoughFuelToMove [
	|aPlayer aBoard aGame|
	aBoard := LoadedBoard clone: (Board withSize: 100 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3))).
	aBoard removeEffects.
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 5)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 1.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 1. 
]
