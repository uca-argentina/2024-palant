Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
GameTest >> testGameCanGetRankingAndOrdersShipsCorrectly [
	|aGame aBoard someDice players|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	aBoard := Board withSize: 30 withWorms: false withParsecs: 0 withDice: someDice.
	aGame := Game withBoard: aBoard withDice: someDice  withPlayers: 3 withMaxLaps: 10.
	players := aGame getPlayers.
	aBoard place: (players at: 1) at: 3.
	aBoard place: (players at: 2) at: 19.
	aBoard place: (players at: 3) at: 29.
	self assert: (aGame getRanking at: 1) equals: (players at: 3).
	self assert: (aGame getLeaderboard at: 1) equals: '3'.
]

{ #category : #tests }
GameTest >> testValidGameCanFinish [
	|game aBoard someDice myPlayer|
	someDice := OrderedCollection with: (LoadedDie of: 11).
	aBoard := LoadedBoard clone: (Board withSize: 10 withWorms: false withParsecs: 0 withDice: someDice).
	aBoard removeEffects.
	game := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 2.
	myPlayer := (game getPlayers) at: 1.
	aBoard place: myPlayer at: 1. 
	game giveTurn: (myPlayer).
	game skipTurn: myPlayer.
	game giveTurn: (myPlayer).
	game skipTurn: myPlayer.
	game giveTurn: (myPlayer).
	game skipTurn: myPlayer.
	game giveTurn: (myPlayer).
	game skipTurn: myPlayer.
	game giveTurn: (myPlayer).
	game skipTurn: myPlayer.
	self assert: (game hasWinner) equals: true.
]
