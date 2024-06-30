Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> test01PlayerCanUseInstantCardsAnytime [
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
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer targetCard: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1.
















]

{ #category : #tests }
CardTest >> test02PlayerCanOnlyUsePermanentCardOnHisTurn [
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
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	self deny: (aPlayer getAlly) equals: bPlayer.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	self assert: (aPlayer getAlly) equals: bPlayer.
	
















]

{ #category : #tests }
CardTest >> test03RepeatCardMovesTargetShipBackwarsWhenLastEffectIsBlackHole [
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
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer targetCard: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
CardTest >> test04AccelerationIncreasesAllPlayersThrow [
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
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) targetCard: nil.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 11.
	self assert: (bPlayer ship getShipPosition) equals: 11.



]

{ #category : #tests }
CardTest >> test05OverloadReducesPlayersThrow [
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
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer targetCard: nil.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 8.



]

{ #category : #tests }
CardTest >> test06AllyCardSetsAnAlly [

	| aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aLoadedBoard := LoadedBoard clone: (Board
			                 withSize: 20
			                 withWorms: false
			                 withParsecs: 1
			                 withDice: someDice).
	aLoadedBoard removeEffects.
	aGame := Game
		         withBoard: aLoadedBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.

	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aPlayer addCards: (OrderedCollection with: (Ally)).	
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: aPlayer ship getShipPosition equals: 20.
	self assert: bPlayer ship getFuel equals: 5.
]

{ #category : #tests }
CardTest >> test07AllyCardLeavesActiveCardInPlayer [
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
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	self assert: (aPlayer getActiveCards size) equals: 1.



]

{ #category : #tests }
CardTest >> test08AllyCardAndItsEffectCanBeRemovedFromPlayer [
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
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	aPlayer deactivateCard: Ally.
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> test09CancellationCanRemoveAccelerationCard [
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
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) targetCard: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: bPlayer targetCard: Acceleration.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test10CancellationCanRemoveOverloadCard [
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
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer targetCard: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: bPlayer targetCard: Overload.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test11CancellationCardCanRemoveAllyEfect [
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
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer targetCard: nil.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: aPlayer targetCard: Ally.
	
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> test12RedoCardCopiesLastCard [
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
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer targetCard: nil.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer targetCard: nil.
	self assert: (aPlayer ship getShipPosition) equals: 2.



]

{ #category : #tests }
CardTest >> test13RedoCardDoesNothingIfNoCardsWereUsed [
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
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer targetCard: nil.
	self assert: (aPlayer ship getShipPosition) equals: 10.
	self assert: (bPlayer ship getShipPosition) equals: 5.


]
