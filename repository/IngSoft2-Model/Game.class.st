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
		'status'
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
	[ships anySatisfy: [:aShip | aShip isWinner]] whileFalse: [ 
			ships do: [ :ship | 
				(ships anySatisfy: [:aShip | aShip isWinner]) ifFalse: [ 
					board move: ship distance: (ship rollDice: dice). 
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

{ #category : #initialization }
Game >> initializeBoard: aBoard [ 
	board := aBoard.
]

{ #category : #initialization }
Game >> initializeDice: someDice [ 
	dice := someDice.
]

{ #category : #initialization }
Game >> initializeShips: someShips [
	ships := someShips.
]
