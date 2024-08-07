Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
PlayerTest >> test01PlayersFuelCapacityChangesWhenRollsMaxRoll [
|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self deny: (aPlayer ship getFuel) equals: 10. 

]

{ #category : #tests }
PlayerTest >> test02PlayerCanReceiveCards [
	|aPlayer aCard|
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	aCard := Card new.
	aPlayer addCards: (OrderedCollection with: aCard).
	self assert: (aPlayer getCards ) equals: (OrderedCollection with: aCard). 
	 
]

{ #category : #tests }
PlayerTest >> test03PlayerCardsCanBeRemoved [
	|aPlayer aCard|
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	aCard := Card new.
	aPlayer addCards: (OrderedCollection with: aCard).
	aPlayer removeCard: (aCard).
	self assert: (aPlayer getCards ) equals: (OrderedCollection new). 
	 
]

{ #category : #tests }
PlayerTest >> test04PlayerCanUseAllysFuelWhenHeDoesntHaveEnough [
	|aPlayer bPlayer aBoard|
	aBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false withParsecs: 10 withDice: (OrderedCollection with: (LoadedDie of: 10))).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	bPlayer := Player named: 'Peter' withShip: (Ship withFuel: 10).	
	aPlayer setAlly: bPlayer.
	aBoard place: aPlayer at: 1. 
	aBoard place: bPlayer at: 1.
	aBoard move: aPlayer distance: 14.
	self assert: (aPlayer ship getShipPosition) equals: 15.
	 
]

{ #category : #tests }
PlayerTest >> test05AlliedPlayersFuelReducesWhenUsedByItsAlly [
	|aPlayer bPlayer aBoard|
	aBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false withParsecs: 10 withDice: (OrderedCollection with: (LoadedDie of: 10))).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	bPlayer := Player named: 'Peter' withShip: (Ship withFuel: 10).	
	aPlayer setAlly: bPlayer.
	aBoard place: aPlayer at: 1. 
	aBoard place: bPlayer at: 1.
	aBoard move: aPlayer distance: 14.
	self assert: (bPlayer ship getFuel) equals: 6.
	 
]

{ #category : #tests }
PlayerTest >> test06BothAlliesGetResetWhenTheyDontHaveEnoughCombinedFuel [
	|aPlayer bPlayer aBoard|
	aBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false withParsecs: 10 withDice: (OrderedCollection with: (LoadedDie of: 10))).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 2).
	bPlayer := Player named: 'Peter' withShip: (Ship withFuel: 2).	
	aPlayer setAlly: bPlayer.
	aBoard place: aPlayer at: 5. 
	aBoard place: bPlayer at: 5.
	aBoard move: aPlayer distance: 14.
	self assert: (aPlayer ship getShipPosition) equals: 1.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	 
]

{ #category : #tests }
PlayerTest >> test07CantRemoveCardsThatThePlayerDoesNotHave [
	|aPlayer aCard|
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	aCard := Card new.
	self should: [ aPlayer removeCard: aCard ] raise: Error withMessage: 'Player does not have such card.'. 
	 
]

{ #category : #tests }
PlayerTest >> test08PlayerCantUseCardThatHeDoesNotHave [
	| aPlayer someDice aLoadedBoard aGame |
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

	aLoadedBoard place: aPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	self should: [ aGame player: aPlayer throwsCard: Ally targetPlayer: aPlayer targetCard: nil ] raise: Error withMessage: 'Player does not have such card.'. 
	 
]
