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
GameTest >> testAllyCardSetsAnAlly [

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
	aGame player: aPlayer throwsCard: Ally for: bPlayer in: aLoadedBoard.	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: aPlayer ship getShipPosition equals: 20.
	self assert: bPlayer ship getFuel equals: 5.
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

	| game aBoard someDice myPlayer |
	someDice := OrderedCollection with: (LoadedDie of: 11).
	aBoard := LoadedBoard clone: (Board
			           withSize: 10
			           withWorms: false
			           withParsecs: 0
			           withDice: someDice).
	aBoard removeEffects.
	game := Game
		        withBoard: aBoard
		        withDice: someDice
		        withPlayers: 1
		        withMaxLaps: 2.
	myPlayer := game getPlayers at: 1.
	aBoard place: myPlayer at: 1.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	self assert: game hasWinner equals: true
]
