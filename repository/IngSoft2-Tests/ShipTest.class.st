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

	| aShip aBoard |
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'Pepe' withFuel: 10.
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: 5.
	self assert: aShip getFuel equals: 5
]

{ #category : #tests }
ShipTest >> testPassesWhenShipCanRollMultipleDice [
	
	|aShip dice |
	dice:= OrderedCollection new.
	dice add: (LoadedDie of: 4).
	dice add: (LoadedDie of: 5).
	aShip := Ship named: 'Nave1' withFuel: 1000.
	aShip rollDice: dice.
	self assert: ((aShip rollDice: dice) = 9).
]

{ #category : #tests }
ShipTest >> testShipDoesntMoveWhenSkipsTurn [
	|aShip aBoard aGame|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withShips: 1  withMaxLaps: 1.
	aShip := (aGame getShips) at: 1.
	aBoard place: aShip at: 1.
	aGame skipTurn: aShip.
	self assert: aShip getShipPosition equals: 1. 
]

{ #category : #tests }
ShipTest >> testShipGetsRefueledWhenSkipsTurn [
	|aShip aBoard aGame|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withShips: 1  withMaxLaps: 1.
	aShip := (aGame getShips) at: 1.
	aBoard place: aShip at: 1.
	aGame playTurn: aShip.
	aGame skipTurn: aShip.
	self assert: (aShip getFuel) equals: 6. 
]

{ #category : #tests }
ShipTest >> testShipsLapsIncreseWhenItGoesPastEndSquare [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'testShip' withFuel: 1000.
	aBoard place: aShip at: 1. 
	aBoard move: aShip distance: 14.
	self assert: (aShip getLaps ) equals: 1.
]

{ #category : #tests }
ShipTest >> testShipsLapsReduceWhenExceedsBoardGoingBackwards [
	|aBoard aBoardSize aShip|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'testShip' withFuel: 1000.
	aBoard place: aShip at: 1.
	aShip addLaps: 5. 
	aBoard move: aShip distance: -3.
	self assert: (aShip getLaps = 4).
]

{ #category : #tests }
ShipTest >> testShipsPositionIsResetWhenShipDoesNotHaveEnoughFuelToMove [
	|aShip aBoard|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship named: 'Pepe' withFuel: 3.
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: 10.
	self assert: aShip getShipPosition equals: 1. 
]

{ #category : #tests }
ShipTest >> testWhenCreatingShipCannotHaveEmptyNameButStoresNameIfValid [
	self should:[Ship named: '' withFuel: 1010] raise: Error withMessage: 'Ship must have a name'.
	self assert: ((Ship named: 'Pepe' withFuel: 1010) getName = 'Pepe').
]
