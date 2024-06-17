Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerCanReceiveCards [
	|aPlayer aCard|
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	aCard := Card new.
	aPlayer addCards: (OrderedCollection with: aCard).
	self assert: (aPlayer getCards ) equals: (OrderedCollection with: aCard). 
	 
]

{ #category : #tests }
PlayerTest >> testPlayerCardsCanBeRemoved [
	|aPlayer aCard|
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 10).
	aCard := Card new.
	aPlayer addCards: (OrderedCollection with: aCard).
	aPlayer removeCard: (aCard).
	self assert: (aPlayer getCards ) equals: (OrderedCollection new). 
	 
]

{ #category : #tests }
PlayerTest >> testPlayersFuelCapacityChangesWhenRollsMaxRoll [
|aPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self deny: (aPlayer ship getFuel) equals: 10. 

]
