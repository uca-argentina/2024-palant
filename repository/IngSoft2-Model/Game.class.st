"
Game has all the other classes initializers, a status in order to check whether the game is over or not and has a function for playing out the turns.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'ships',
		'maxLaps',
		'players',
		'turnHolder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Game class >> withBoard: aBoard withDice: someDice withPlayers: somePlayers  withMaxLaps: someLaps [
^(self new) initializeBoard: aBoard initializeDice: someDice initializePlayers: somePlayers  initializeMaxLaps: someLaps.
]

{ #category : #'modifier state' }
Game >> calculateMaxFuel [

	| maxFuel |
	maxFuel := 0.
	dice do: [ :x | maxFuel := maxFuel + x getMax ].
	maxFuel := maxFuel * 2.
	^ maxFuel
]

{ #category : #action }
Game >> canPlay: aPlayer [
|penalization|
	penalization := aPlayer getPenalization.
	penalization = 0 ifFalse: [
		penalization := penalization - 1.
		penalization = 0 ifTrue: [ aPlayer ship resetFuelTank ].
		^ false ].
	^ true
]

{ #category : #action }
Game >> checkBounty: rollRes for: player [
	| prob |
	(rollRes = (self calculateMaxFuel / 2)) ifTrue: [
		prob := 100 atRandom.
		prob > 20
			ifTrue: [ player ship addFuelCapacity: 1 ]
			ifFalse: [ player ship addFuelCapacity: -1 ] ]
]

{ #category : #action }
Game >> getLeaderboard [
   | sortedPlayers |
	sortedPlayers := OrderedCollection new.
	(self getRanking) do: [ :player | sortedPlayers add: (player getName)]	.
	^sortedPlayers.
]

{ #category : #action }
Game >> getPlayers [
 ^players.
]

{ #category : #action }
Game >> getRanking [

    | sortedPlayers |

    sortedPlayers := players.

    ^ sortedPlayers asSortedCollection: [ :playerA :playerB |
          ((playerA ship getLaps ) * board boardSize + playerA ship getShipPosition)
          >=
          ((playerB ship getLaps ) * board boardSize + playerB ship getShipPosition) ]
]

{ #category : #action }
Game >> giveTurn: aPlayer [

	(self canPlay: aPlayer) ifTrue: [ turnHolder := aPlayer ]
]

{ #category : #action }
Game >> hasWinner [

	^ players anySatisfy: [ :x | x ship getLaps >= maxLaps ]
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializePlayers: playerAmount initializeMaxLaps: someLaps [

	maxLaps := someLaps.
	board := aBoard.
	dice := someDice.
	players := OrderedCollection new.
	(1 to: playerAmount) do: [ :x | players add: (Player named: (x asString) withShip: (Ship withFuel: self calculateMaxFuel)) ].
]

{ #category : #action }
Game >> playTurn: player [

	turnHolder = player ifTrue: [
		| rollRes |
		rollRes := player play: dice.
		self checkBounty: rollRes for: player.
		(board move: player distance: rollRes)
			applyEffect: player
			withPlayers: players
			inBoard: board ]
]

{ #category : #action }
Game >> skipTurn: player [

	turnHolder = player ifTrue: [ player ship resetFuelTank ]
]
