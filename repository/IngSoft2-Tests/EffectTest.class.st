Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAtomicBombResetsAllShip [
	|aShip bShip aBoard allShips|
	aShip := Ship named: 'Pepe'.
	bShip := Ship named: 'Pedro'.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 4.
	aBoard place: bShip at: 6.
	(aBoard move: bShip distance: 1) applyEffect: aShip withShips: allShips inBoard: aBoard.
	self assert:(((aBoard findShip: aShip) = 1) and: ((aBoard findShip: bShip) = 1)). 
]

{ #category : #tests }
EffectTest >> testBlackHoleEffectMovesShipBackwards [
	|aShip aBoard|
	aShip := Ship named: 'Pepe'.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 4.
	(aBoard move: aShip distance: 1) applyEffect: aShip withShips: aShip inBoard: aBoard .
	self assert:((aBoard findShip: aShip) = 1). 
]
