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
		'maxLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Game class >> withBoard: aBoard withDice: someDice withShips: someShips  withMaxLaps: someLaps [
^(self new) initializeBoard: aBoard initializeDice: someDice initializeShips: someShips  initializeMaxLaps: someLaps.
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
Game >> canPlay: aShip [
|penalization|
	penalization := aShip getPenalization.
	penalization = 0 ifFalse: [
		penalization := penalization - 1.
		penalization = 0 ifTrue: [ aShip resetFuelTank ].
		^ false ].
	^ true
]

{ #category : #action }
Game >> getRanking [

    | sortedShips |

    sortedShips := ships.

    ^ sortedShips asSortedCollection: [ :shipA :shipB |
          ((shipA getLaps ) * board boardSize + shipA getShipPosition)
          >=
          ((shipB getLaps ) * board boardSize + shipB getShipPosition) ]
]

{ #category : #action }
Game >> getShips [
	^ships.
]

{ #category : #action }
Game >> giveTurn: aShip [

	(self canPlay: aShip) ifTrue: [
		aShip decideToPlay
			ifTrue: [ self playTurn: aShip ]
			ifFalse: [ self skipTurn: aShip ] ]
]

{ #category : #action }
Game >> hasWinner [

	^ ships anySatisfy: [ :x | x getLaps >= maxLaps ]
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializeShips: shipsAmount initializeMaxLaps: someLaps [

	maxLaps := someLaps.
	board := aBoard.
	dice := someDice.
	ships := OrderedCollection new.
	(1 to: shipsAmount) do: [ :x | ships add: (Ship named: (x asString) withFuel: self calculateMaxFuel ) ].
]

{ #category : #action }
Game >> playTurn: aShip [

	(board move: aShip distance: (aShip play: dice))
		applyEffect: aShip
		withShips: ships
		inBoard: board
]

{ #category : #action }
Game >> skipTurn: aShip [
	aShip resetFuelTank.
]
