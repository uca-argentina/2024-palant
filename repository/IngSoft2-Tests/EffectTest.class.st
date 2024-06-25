Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> test01AtomicBombResetsAllShip [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 2.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (aPlayer ship getShipPosition) equals: 1. 
	self assert: (bPlayer ship getShipPosition) equals: 1. 
	
	 
]

{ #category : #tests }
EffectTest >> test02AtomicBombDoesNotAffectFuel [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getFuel) equals: 5. 
	
	 
]

{ #category : #tests }
EffectTest >> test03AtomicBombDoesNotAffectLaps [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aPlayer ship addLaps: 2.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getLaps) equals: 2. 
	
	 
]

{ #category : #tests }
EffectTest >> test04MoonWalkEffectMovesAllOtherShipBackwards [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 4. 
	
]

{ #category : #tests }
EffectTest >> test05MoonWalkResetsShipPositionIfItDoesNotHaveEnoughFuelToMoveAndSkipsTwoTurns [

	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 100) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	
	
]

{ #category : #tests }
EffectTest >> test06BlackHoleEffectMovesShipBackwards [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6. 
]

{ #category : #tests }
EffectTest >> test07HyperJumpMovesShipCorrectSquareAmountAccordingToParsecs [
	|aPlayer someDice aLoadedBoard aGame myUnits|
	someDice := OrderedCollection with: (LoadedDie of: 10).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice ).
	aLoadedBoard removeEffects.
	
	
	myUnits := OrderedCollection with: (Parsec withUnits: 2) with: (Parsec withUnits: 4).
	aLoadedBoard initializeEffect: (HyperJump withUnits: myUnits withBoard: aLoadedBoard) initializeAt: 15.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 3. 
]

{ #category : #tests }
EffectTest >> test08HyperJumpParsecListResets [
	|aPlayer someDice aLoadedBoard aGame myUnits |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice ).
	aLoadedBoard removeEffects.
	myUnits := OrderedCollection with: (Parsec withUnits: 2) with: (Parsec withUnits: 4).
	aLoadedBoard initializeEffect: (HyperJump withUnits: myUnits withBoard: aLoadedBoard) initializeAt: 15.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer ship initializeFuel: 100101012.
	aLoadedBoard place: aPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aLoadedBoard takeOut: aPlayer.
		aLoadedBoard place: aPlayer at: 10.
	aGame playTurn: aPlayer.
	aLoadedBoard takeOut: aPlayer.
		aLoadedBoard place: aPlayer at: 10.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 3. 
]

{ #category : #tests }
EffectTest >> test09ShipDoesNotMoveWhenRollsDifferentThanHyperGravityNecessaryRolledResult [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 1) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	
]

{ #category : #tests }
EffectTest >> test10ShipMovesWhenRollsHyperGravityNecessaryRolledResult [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 5) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame skipTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 15. 
]

{ #category : #tests }
EffectTest >> test11ShipDoesNotGetAffectedByEffectsIfInHyperGravity [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 10) initializeAt: 6.
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 1.
	aLoadedBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6.
	
]

{ #category : #tests }
EffectTest >> test12OnlyOneEffectIsAppliedPerTurn [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10.
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 4.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 4.
]

{ #category : #tests }
EffectTest >> test13HyperJumpMovesShipCorrectSquareAmountAccordingToLightYears [
	|aPlayer someDice aLoadedBoard aGame myUnits|
	someDice := OrderedCollection with: (LoadedDie of: 10).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 30 withWorms: false  withParsecs: 10  withDice: someDice ).
	aLoadedBoard removeEffects.
	
	
	myUnits := OrderedCollection with: (LightYear withUnits: 1).
	aLoadedBoard initializeEffect: (HyperJump withUnits: myUnits withBoard: aLoadedBoard) initializeAt: 15.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 16. 
]

{ #category : #tests }
EffectTest >> test14PlayerGetsACardWhenItLandsOnCardDealer [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (CardDealer new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer getCards size) equals: 3.
]
