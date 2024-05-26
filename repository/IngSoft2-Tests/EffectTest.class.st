Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testBlackHoleEffectMovesShipBackwards [
	|aShip aBoard|
	aShip := Ship named: 'Pepe'.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 4.
	(aBoard move: aShip distance: 1) applyEffect: aShip inBoard: aBoard .
	self assert:((aBoard findShip: aShip) = 1). 
]
