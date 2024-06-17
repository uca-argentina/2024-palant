Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
	aGame player: aPlayer throwsCard: Ally for: bPlayer in: aLoadedBoard.
	self deny: (aPlayer getAlly) equals: bPlayer.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally for: bPlayer in: aLoadedBoard.
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
	aGame player: aPlayer throwsCard: Repeat for: bPlayer in: aLoadedBoard.
	self assert: (bPlayer ship getShipPosition) equals: 1.
















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
	aGame player: aPlayer throwsCard: Repeat for: bPlayer in: aLoadedBoard.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]
