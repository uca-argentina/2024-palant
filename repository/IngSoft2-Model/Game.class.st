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

{ #category : #action }
Game >> begin [
	status := 'Launching'.
	(self hasBeenInitialized) ifTrue: [ 
		ships do: [ :ship | board place: ship at: 1 ].
		self gameplay.
	] ifFalse: [ 
		Error signal: 'Cannot begin an uninitialized game.'.
	 ]
		
	
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
					board move: ship distance: (ship play: dice). 
				].
			].
	 ].
	self endGame.
		
	
]

{ #category : #'accessing - attributes' }
Game >> getStatus [
	^status.
		
	
]

{ #category : #accessing }
Game >> hasBeenInitialized [
	^(((board isNotNil) and: (dice isNotNil))) and: (ships isNotNil).
]

{ #category : #action }
Game >> hasWinner [
	^(ships anySatisfy: [:x | x getLaps = maxLaps]).
]

{ #category : #initialization }
Game >> initializeBoard: aBoard [ 
	board := aBoard.
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializeShips: someShips [ 
	board := aBoard.
	ships := someShips.
	dice := someDice.
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializeShips: someShips  initializeMaxLaps: someLaps [
	maxLaps := someLaps.
	board := aBoard.
	ships := someShips.
	dice := someDice.
]

{ #category : #initialization }
Game >> initializeDice: someDice [ 
	dice := someDice.
]

{ #category : #initialization }
Game >> initializeShips: someShips [
	ships := someShips.
]
