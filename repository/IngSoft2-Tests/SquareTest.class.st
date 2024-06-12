Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> testSquareCanDockAShip [
	|aSquare aShip|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: ((aSquare getDockedShips) includes: aShip)
]

{ #category : #tests }
SquareTest >> testSquareCanUndockAShip [
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
