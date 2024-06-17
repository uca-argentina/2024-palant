Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
