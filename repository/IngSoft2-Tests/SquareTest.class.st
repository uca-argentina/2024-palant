Class {
	#name : #SquareTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SquareTest >> test01SquareReturnsEmptyCollectionWhenNoDockedShips [ 
	|aSquare|
	aSquare := Square createEmptySquare.
	self assert: (aSquare getDockedShips) isEmpty.
]

{ #category : #tests }
SquareTest >> test02SquareCanDockAShip [
	|aSquare aShip|
	aShip := Ship withFuel: 1000.
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: ((aSquare getDockedShips) includes: aShip)
]

{ #category : #tests }
SquareTest >> test03SquareCanUndockAShip [
	|aSquare aShip|
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: (aSquare undockShip: aShip).
]

{ #category : #tests }
SquareTest >> test04SquareReturnsShipWhenDockedShip [ 
	|aSquare aShip|
	aSquare := Square createEmptySquare.
	aSquare dockShip: aShip.
	self assert: ((aSquare getDockedShips) at: 1) equals: aShip.
]
