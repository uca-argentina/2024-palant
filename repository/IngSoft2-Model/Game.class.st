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

{ #category : #'as yet unclassified' }
Game >> begin [
	status := 'Launching'.
	(self hasBeenInitialized) ifTrue: [ 
		self gameplay.
	] ifFalse: [ 
		Error signal: 'Cannot begin an uninitialized game.'.
	 ]
		
	
]

{ #category : #'as yet unclassified' }
Game >> endGame [
	status := 'Over'.
		
	
]

{ #category : #'as yet unclassified' }
Game >> gameplay [
	status := 'Playing'.
	[ships anySatisfy: [:aShip | aShip isWinner]] whileTrue: [ 
			ships do: [ :ship | 
				board move: ship distance: (ship rollDice: dice). 
				]
	 ].
	self endGame.
		
	
]

{ #category : #'as yet unclassified' }
Game >> getStatus [
	^status.
		
	
]

{ #category : #'as yet unclassified' }
Game >> hasBeenInitialized [
	^((board ~= nil) and: (dice ~= nil)) and: (ships ~= nil).
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
