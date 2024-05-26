Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectFuel [
	|aShip aBoard shipList|
	aShip := Ship named: 'Pepe' withTank: (FuelTank withMax: 100).
	shipList := OrderedCollection new.
	shipList add: aShip.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 6.
	(aBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aBoard .
	self assert:((aShip tank status) = 99). 
]

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectLaps [
	|aShip aBoard shipList|
	aShip := Ship named: 'Pepe'.
	shipList := OrderedCollection new.
	shipList add: aShip.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 6.
	(aBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aBoard .
	self assert:(aShip getLaps = 0). 
]

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

{ #category : #tests }
EffectTest >> testMoonWalkEffectMovesAllOtherShipBackwards [
	|aShip bShip aBoard allShips|
	aShip := Ship named: 'Pepe'.
	bShip := Ship named: 'Pedro'.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 4.
	aBoard place: bShip at: 8.
	(aBoard move: bShip distance: 1) applyEffect: bShip withShips: allShips inBoard: aBoard.
	self assert:(((aBoard findShip: aShip) = 1)). 
]

{ #category : #tests }
EffectTest >> testMoonWalkResetsShipPositionIfItDoesNotHaveEnoughFuelToMoveAndSkipsTwoTurns [
	|someDice aShip bShip aBoard allShips|
	someDice := OrderedCollection with: (Die of: 4).
	aShip := Ship named: 'Pepe' withTank: (FuelTank withMax: 1).
	bShip := Ship named: 'Pedro'.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aBoard := Board withSize: 20.
	aBoard initializeEffects.
	aBoard place: aShip at: 19.
	aBoard place: bShip at: 8.
	(aBoard move: bShip distance: 1) applyEffect: bShip withShips: allShips inBoard: aBoard.
	aBoard move: aShip distance: (aShip play: someDice).
	aBoard move: aShip distance: (aShip play: someDice).
	self assert:((aBoard findShip: aShip) = 1). 
]
