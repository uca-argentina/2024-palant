Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectFuel [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getFuel) equals: 5. 
	
	 
]

{ #category : #tests }
EffectTest >> testAtomicBombDoesNotAffectLaps [
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
EffectTest >> testAtomicBombResetsAllShip [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 2.
	aGame playTurn: aPlayer.
	
	self assert: (aPlayer ship getShipPosition) equals: 1. 
	self assert: (bPlayer ship getShipPosition) equals: 1. 
	
	 
]

{ #category : #tests }
EffectTest >> testBlackHoleEffectMovesShipBackwards [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6. 
]

{ #category : #tests }
EffectTest >> testHyperJumpMovesShipCorrectSquareAmountAccordingToParsecs [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 10).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (HyperJump withParsecs:(#(2 4) asOrderedCollection)) initializeAt: 15.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 3. 
]

{ #category : #tests }
EffectTest >> testHyperJumpParsecListResets [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (HyperJump withParsecs:(#(2 4) asOrderedCollection)) initializeAt: 15.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer ship initializeFuel: 100101012.
	aLoadedBoard place: aPlayer at: 10.
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
EffectTest >> testMoonWalkEffectMovesAllOtherShipBackwards [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame playTurn: aPlayer.
	
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 4. 
	
]

{ #category : #tests }
EffectTest >> testMoonWalkResetsShipPositionIfItDoesNotHaveEnoughFuelToMoveAndSkipsTwoTurns [

	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 100) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	
	
]

{ #category : #tests }
EffectTest >> testOnlyOneEffectIsAppliedPerTurn [
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
	
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 4.
]

{ #category : #tests }
EffectTest >> testShipDoesNotGetAffectedByEffectsIfInHyperGravity [
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
	
	aGame playTurn: aPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6.
	
]

{ #category : #tests }
EffectTest >> testShipDoesNotMoveWhenRollsDifferentThanHyperGravityNecessaryRolledResult [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 1) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	
]

{ #category : #tests }
EffectTest >> testShipMovesWhenRollsHyperGravityNecessaryRolledResult [
	|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 5) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame playTurn: aPlayer.
	aGame skipTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 15. 
]
