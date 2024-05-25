"
Board is made of squares, has the responsability of moving a ship and the initializers of particular squares.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize [ 
	^((self new) initializeSize: aSize).
]

{ #category : #'instance creation' }
Board class >> withSize: aSize withWorms: hasWorms [
	|boardToReturn|
	boardToReturn := ((self new) initializeSize: aSize).
	(hasWorms) ifTrue: [boardToReturn initializeWormSquares].
	^boardToReturn 
]

{ #category : #accessing }
Board >> boardSize [
	^(squares size).
]

{ #category : #accessing }
Board >> findShip: aShip [

	1 to: (self boardSize) do: [:x | ((squares at: x) getDockedShips includes: aShip)  ifTrue: [ ^x ] ].
	^-1.

]

{ #category : #accessing }
Board >> findWormSquares [
	|positions|
	positions := OrderedCollection new.
	1 to: (self boardSize) do: [ :x | ((squares at: x) class == WormSquare) ifTrue:[ positions add: x ] ].
	^positions.
	
	
]

{ #category : #initialization }
Board >> initializeSize: aSize [ 
	squares := OrderedCollection new.
	1 to: (aSize - 1) do: [:x | squares add: Square createEmptySquare ].
	squares add: EndSquare createEmptySquare.
]

{ #category : #initialization }
Board >> initializeWormSquares [ 
	|worm1Position worm1 worm2Position worm2|
	
	worm1Position := (self boardSize - 1) atRandom.
	worm2Position := (self boardSize - 1) atRandom.
	[ worm1Position = worm2Position ] whileTrue: [ 
		worm2Position := (self boardSize - 1) atRandom.
	 ].
	
	worm1 := WormSquare createEmptySquare.
	worm2 := WormSquare createEmptySquare.
	
	worm1 initializeLink: worm2.
	worm2 initializeLink: worm1.
	
	squares at: worm1Position put: worm1.
	squares at: worm2Position put: worm2.
	
]

{ #category : #action }
Board >> move: aShip distance: aDistance [

	| shipPosition |
	shipPosition := self findShip: aShip.
	(aShip consumeFuel: aDistance)
		ifTrue: [
			(self takeOut: aShip) and:
				(self place: aShip at: shipPosition + aDistance) ]
		ifFalse: [ self resetToStart: aShip.
					  aShip tank reset.
					 ]
]

{ #category : #accessing }
Board >> place: aShip at: aPosition [ 
	|moveTo|
	moveTo := aPosition.
	[moveTo > self boardSize] whileTrue: [	
			aShip addLap.
			moveTo := (moveTo - self boardSize)
			].
	[moveTo < 0] whileTrue: [	
			aShip subtractLap.
			moveTo := (moveTo + self boardSize)
			].
	(squares at: moveTo) dockShip: aShip.
	^true.
]

{ #category : #'modifier state' }
Board >> resetToStart: aShip [
	self takeOut: aShip.
	self place: aShip at: 1.
]

{ #category : #action }
Board >> showBoard [
	|dockedHere|
	squares do: [ :square | 
			((square getDockedShips) isEmpty)
			ifTrue: [ 
				Transcript show: '#'
			]
			ifFalse: [ 
				(square getDockedShips) do: [ :thisShip | Transcript show: (thisShip getName). ]. 
				Transcript show:'.'.
			]
		 ].
	Transcript show: '';cr.
]

{ #category : #'modifier state' }
Board >> takeOut: aShip [
	|shipPosition|
	shipPosition := (self findShip: aShip).
	^(squares at: shipPosition) undockShip: aShip. 
	
]
