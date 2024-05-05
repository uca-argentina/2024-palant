Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testIsTrueWhenShipDocks [
	|aSquare aShip|
	aSquare := Square createEmptySquare.
	self assert: (aSquare dockShip: aShip).
]

{ #category : #tests }
SquareTest >> testIsTrueWhenShipUndocks [
	|aSquare aShip|
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: (aSquare undockShip: aShip).
]

{ #category : #tests }
SquareTest >> testSquareReturnsEmptyCollectionWhenNoDockedShips [ 
	|aSquare|
	aSquare := Square createEmptySquare.
	self assert: (aSquare getDockedShips) isEmpty.
]

{ #category : #tests }
SquareTest >> testSquareReturnsShipWhenDockedShip [ 
	|aSquare aShip|
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: ((aSquare getDockedShips) at: 1) equals: aShip.
]
