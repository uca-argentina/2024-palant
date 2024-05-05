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
ShipTest >> testShipCannotBeCreatedWithEmptyName [
	self should:[Ship named: ''] raise: Error withMessage: 'Ship must have a name'
]

{ #category : #tests }
ShipTest >> testValidWhenCanRollDice [
	
	|aShip dice |
	dice:= OrderedCollection new.
	dice add: (Die of: 4).
	aShip := Ship named: 'Nave1'.
	self assert: ((aShip rollDice: dice) > 0).
]

{ #category : #tests }
ShipTest >> testValidWhenShipIsCreated [

	|aShip|
	aShip := Ship new.
	self assert: aShip isNamed.
]
