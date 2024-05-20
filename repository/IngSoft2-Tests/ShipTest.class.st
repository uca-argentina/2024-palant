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
ShipTest >> testPassesWhenShipCanRollMultipleDice [
	
	|aShip dice |
	dice:= OrderedCollection new.
	dice add: (LoadedDie of: 4).
	dice add: (LoadedDie of: 5).
	aShip := Ship named: 'Nave1'.
	aShip rollDice: dice.
	self assert: ((aShip rollDice: dice) = 9).
]

{ #category : #tests }
ShipTest >> testShipCannotBeCreatedWithEmptyName [
	self should:[Ship named: ''] raise: Error withMessage: 'Ship must have a name'
]

{ #category : #tests }
ShipTest >> testValidWhenShipIsCreated [

	|aShip|
	aShip := Ship new.
	self assert: aShip isNamed.
]
