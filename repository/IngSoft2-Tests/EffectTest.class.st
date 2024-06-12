Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectFuel [
	|aShip aLoadedBoard shipList|
	aShip := Ship named: 'Pepe' withFuel: 100.
	shipList := OrderedCollection new.
	shipList add: aShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 6.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard .
	self assert: aShip getFuel equals: 99. 
]

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectLaps [
	|aShip aLoadedBoard shipList|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	shipList := OrderedCollection new.
	shipList add: aShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 6.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard .
	self assert:(aShip getLaps = 0). 
]

{ #category : #tests }
EffectTest >> testAtomicBombResetsAllShip [
	|aShip bShip aLoadedBoard allShips|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	bShip := Ship named: 'Pedro' withFuel: 1000.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 4.
	aLoadedBoard place: bShip at: 6.
	(aLoadedBoard move: bShip distance: 1) applyEffect: aShip withShips: allShips inBoard: aLoadedBoard.
	self assert: aShip getShipPosition equals: 1.
	self assert: bShip getShipPosition equals: 1. 
]

{ #category : #tests }
EffectTest >> testBlackHoleEffectMovesShipBackwards [
	|aShip aLoadedBoard|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 4.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: aShip inBoard: aLoadedBoard .
	self assert: aShip getShipPosition equals: 1. 
]

{ #category : #tests }
EffectTest >> testHyperJumpMovesShipCorrectSquareAmountAccordingToParsecs [
	|aShip bShip aLoadedBoard shipList|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	bShip := Ship named: 'Pedro' withFuel: 1000.
	shipList := OrderedCollection with: aShip with: bShip.
	aLoadedBoard := LoadedBoard withSize: 80 withWorms: false withParsecs: 20.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 10.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard.
	aLoadedBoard place: bShip at: 10.
	(aLoadedBoard move: bShip distance: 1) applyEffect: bShip withShips: shipList inBoard: aLoadedBoard.
	self assert: aShip getShipPosition equals: 43. 
	self assert: bShip getShipPosition equals: 27.
]

{ #category : #tests }
EffectTest >> testHyperJumpParsecListResets [
	|aShip aLoadedBoard shipList|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	shipList := OrderedCollection new.
	shipList add: aShip.
	aLoadedBoard := LoadedBoard withSize: 30 withWorms: false withParsecs: 23.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 10.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard .
	aLoadedBoard takeOut: aShip.
	aLoadedBoard place: aShip at: 10.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard .
	aLoadedBoard takeOut: aShip.
	aLoadedBoard place: aShip at: 10.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: shipList inBoard: aLoadedBoard .
	self assert: aShip getShipPosition equals: 21.
]

{ #category : #tests }
EffectTest >> testMoonWalkEffectMovesAllOtherShipBackwards [
	|aShip bShip aLoadedBoard allShips|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	bShip := Ship named: 'Pedro' withFuel: 1000.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 4.
	aLoadedBoard place: bShip at: 8.
	(aLoadedBoard move: bShip distance: 1) applyEffect: bShip withShips: allShips inBoard: aLoadedBoard.
	self assert: aShip getShipPosition equals: 1. 
]

{ #category : #tests }
EffectTest >> testMoonWalkResetsShipPositionIfItDoesNotHaveEnoughFuelToMoveAndSkipsTwoTurns [
	|someDice aShip bShip aLoadedBoard allShips|
	someDice := OrderedCollection with: (Die of: 4).
	aShip := Ship named: 'Pepe' withFuel: 1.
	bShip := Ship named: 'Pedro' withFuel: 1000.
	allShips := OrderedCollection new.
	allShips add: aShip.
	allShips add: bShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 19.
	aLoadedBoard place: bShip at: 8.
	(aLoadedBoard move: bShip distance: 1) applyEffect: bShip withShips: allShips inBoard: aLoadedBoard.
	aLoadedBoard move: aShip distance: (aShip play: someDice).
	aLoadedBoard move: aShip distance: (aShip play: someDice).
	self assert: aShip getShipPosition equals: 1. 
]

{ #category : #tests }
EffectTest >> testOnlyOneEffectIsAppliedPerTurn [
	|aShip downedShip aLoadedBoard|
	aShip := Ship named: 'Pepe' withFuel: 1000.
	downedShip := Ship named: 'Mati' withFuel: 1000.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 1. 
	aLoadedBoard place: downedShip  at: 4. 
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: aShip inBoard: aLoadedBoard.
	self deny: aShip getShipPosition equals: 1.
	self assert: downedShip getShipPosition equals: 4. 
]

{ #category : #tests }
EffectTest >> testShipDoesNotGetAffectedByEffectsIfInHyperGravity [
	|aShip bShip aLoadedBoard someShips someDice|
	aShip := Ship named: '1' withFuel: 1000.
	bShip := Ship named: '2' withFuel: 1000.
	someShips := OrderedCollection with: aShip with: bShip. 
	someDice := OrderedCollection with: (LoadedDie of: 4).
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffect: AtomicBomb new initializeAt: 3.
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 3) initializeAt: 6.
	aLoadedBoard place: aShip at: 1.
	aLoadedBoard place: bShip at: 1.
	(aLoadedBoard move: bShip distance: 5) applyEffect: bShip withShips: someShips inBoard: aLoadedBoard.
	(aLoadedBoard move: aShip distance: 2) applyEffect: aShip withShips: someShips inBoard: aLoadedBoard.
	self assert: aShip getShipPosition equals: 1.
	self assert: bShip getShipPosition equals: 6.
]

{ #category : #tests }
EffectTest >> testShipDoesNotMoveWhenRollsDifferentThanHyperGravityNecessaryRolledResult [

	| someDice aShip aLoadedBoard allShips |
	someDice := OrderedCollection with: (LoadedDie of: 4).
	aShip := Ship named: 'Pepe' withFuel: 1000.
	allShips := OrderedCollection new.
	allShips add: aShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 12.
	(aLoadedBoard move: aShip distance: 1)
		applyEffect: aShip
		withShips: allShips
		inBoard: aLoadedBoard.
	aLoadedBoard move: aShip distance: (aShip play: someDice).
	self assert: aShip getShipPosition equals: 13.
]

{ #category : #tests }
EffectTest >> testShipMovesWhenRollsHyperGravityNecessaryRolledResult [
	|someDice aShip aLoadedBoard allShips|
	someDice := OrderedCollection with: (LoadedDie of: 3).
	aShip := Ship named: 'Pepe' withFuel: 1000.
	allShips := OrderedCollection new.
	allShips add: aShip.
	aLoadedBoard := LoadedBoard withSize: 20 withWorms: false withParsecs: 0.
	aLoadedBoard initializeEffects.
	aLoadedBoard place: aShip at: 12.
	(aLoadedBoard move: aShip distance: 1) applyEffect: aShip withShips: allShips inBoard: aLoadedBoard.
	aLoadedBoard move: aShip distance: (aShip play: someDice).
	self assert: aShip getShipPosition equals: 16. 
]
