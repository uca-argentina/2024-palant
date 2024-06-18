Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testAccelerationIncreasesAllPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration for: (OrderedCollection with: 'Pepe' with: NullCard) in: aLoadedBoard.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 11.
	self assert: (bPlayer ship getShipPosition) equals: 11.



]

{ #category : #tests }
CardTest >> testAllyCardAndItsEffectCanBeRemovedFromPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aPlayer deactivateCard: Ally.
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> testAllyCardLeavesActiveCardInPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	self assert: (aPlayer getActiveCards size) equals: 1.



]

{ #category : #tests }
CardTest >> testCancellationCanRemoveAccelerationCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation for: (OrderedCollection with: bPlayer with: Acceleration) in: aLoadedBoard.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> testCancellationCanRemoveOverloadCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation for: (OrderedCollection with: bPlayer with: Overload) in: aLoadedBoard.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> testCancellationCardCanRemoveAllyEfect [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aGame player: bPlayer throwsCard: Cancellation for: (OrderedCollection with: aPlayer with: Ally) in: aLoadedBoard.
	
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> testOverloadReducesPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 8.



]

{ #category : #tests }
CardTest >> testPlayerCanOnlyUsePermanentCardOnHisTurn [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Ally for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	self deny: (aPlayer getAlly) equals: bPlayer.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	self assert: (aPlayer getAlly) equals: bPlayer.
	
















]

{ #category : #tests }
CardTest >> testPlayerCanUseInstantCardsAnytime [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Repeat for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	self assert: (bPlayer ship getShipPosition) equals: 1.
















]

{ #category : #tests }
CardTest >> testRedoCardCopiesLastCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Repeat for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo for: (OrderedCollection with: aPlayer with: NullCard) in: aLoadedBoard.
	self assert: (aPlayer ship getShipPosition) equals: 2.



]

{ #category : #tests }
CardTest >> testRedoCardDoesNothingIfNoCardsWereUsed [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: bPlayer throwsCard: Redo for: (OrderedCollection with: aPlayer with: NullCard) in: aLoadedBoard.
	self assert: (aPlayer ship getShipPosition) equals: 10.
	self assert: (bPlayer ship getShipPosition) equals: 5.


]

{ #category : #tests }
CardTest >> testRepeatCardMovesTargetShipBackwarsWhenLastEffectIsBlackHole [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat for: (OrderedCollection with: bPlayer with: NullCard) in: aLoadedBoard.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]
