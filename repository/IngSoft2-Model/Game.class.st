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
		'status',
		'maxLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Game class >> withBoard: aBoard withDice: someDice withShips: someShips  withMaxLaps: someLaps [
^(self new) initializeBoard: aBoard initializeDice: someDice initializeShips: someShips  initializeMaxLaps: someLaps.
]

{ #category : #action }
Game >> begin [
	status := 'Launching'.
	(self hasBeenInitialized) ifTrue: [ 
		ships do: [ :ship |
			ship initializeTank: (FuelTank withMax: self calculateMaxFuel).
			board place: ship at: 1 ].
		self gameplay.
	] ifFalse: [ 
		Error signal: 'Cannot begin an uninitialized game.'.
	 ]
		
	
]

{ #category : #'modifier state' }
Game >> calculateMaxFuel [
	|maxFuel|
	maxFuel:= 0.
	dice do: [ :x | maxFuel := maxFuel + x getMax ].
	maxFuel := maxFuel * 2.
	^maxFuel.
]

{ #category : #'modifier state' }
Game >> endGame [
	status := 'Over'.
	board showBoard.
		
	
]

{ #category : #action }
Game >> gameplay [
	status := 'Playing'.
	[self hasWinner] whileFalse: [ 
			ships do: [ :ship | 
				(self hasWinner) ifFalse: [ 
					(board move: ship distance: (ship play: dice)) applyEffect: ship withShips: ships inBoard: board. 
				].
			].
	 ].
	self endGame.
		
]

{ #category : #action }
Game >> getRanking [
	|shipDict sortedShips index|
	shipDict := Dictionary new.
	ships do: [ :ship | shipDict at: ship getName put: ((ship getLaps) * (board  boardSize) + (board findShip: ship)) ].
	sortedShips := shipDict associations asSortedCollection: [ :a :b | a value < b value ].
	sortedShips := sortedShips reversed.
	^sortedShips.
]

{ #category : #'accessing - attributes' }
Game >> getStatus [
	^status.
		
	
]

{ #category : #accessing }
Game >> hasBeenInitialized [
	^((((board isNotNil) and: (dice isNotNil))) and: (ships isNotNil)) and: (maxLaps isNotNil).
]

{ #category : #action }
Game >> hasWinner [
	^(ships anySatisfy: [:x | x getLaps = maxLaps]).
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializeShips: someShips  initializeMaxLaps: someLaps [
	maxLaps := someLaps.
	board := aBoard.
	ships := someShips.
	dice := someDice.
]
