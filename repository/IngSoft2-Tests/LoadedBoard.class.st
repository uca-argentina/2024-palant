Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedBoard class >> clone: aBoard [
	^(self new) copyBoard: aBoard.
]

{ #category : #initialization }
LoadedBoard >> boardSize [
	^(squares size).
]

{ #category : #initialization }
LoadedBoard >> copyBoard: aBoard [
	squares := aBoard getSquares.
	parsecs := aBoard getParsecs.
]

{ #category : #accessing }
LoadedBoard >> findSquareWithEffect: anEffect [
	1 to: self boardSize do: [ :x | (((squares at: x) getEffect) class = anEffect) ifTrue:[ ^x] ].
	^-1.
]

{ #category : #accessing }
LoadedBoard >> findWormSquares [

	| positions |
	positions := OrderedCollection new.
	1 to: (self boardSize) do: [ :x | (((squares at: x) getEffect) class = WormEffect)ifTrue:[ positions add: x ] ].
	^positions.
]

{ #category : #initialization }
LoadedBoard >> findWormSquares [

	| positions |
	positions := OrderedCollection new.
	1 to: self boardSize do: [ :x |
		(squares at: x) class == WormSquare ifTrue: [ positions add: x ] ].
	^ positions
]

{ #category : #initialization }
LoadedBoard >> getParsecs [
	^parsecs.
]

{ #category : #initialization }
LoadedBoard >> initializeEffect: anEffect initializeAt: aSquare [
	(squares at: aSquare) initializeWithEffect: anEffect.
	
]

{ #category : #initialization }
LoadedBoard >> initializeEffects [
	(squares at: 5) initializeWithEffect: BlackHole new.
	(squares at: 7) initializeWithEffect: AtomicBomb new.
	(squares at: 9) initializeWithEffect: (MoonWalk withDistance: 3).
	(squares at: 11) initializeWithEffect: (HyperJump withParsecs: (#(4 8) asOrderedCollection)).
	(squares at: 13) initializeWithEffect: (HyperGravity withNecessaryRolledResult: 3).
	

	(squares at: 2) initializeWithEffect: BlackHole new.
	(squares at: 3) initializeWithEffect: (AtomicBomb new).
	
]

{ #category : #initialization }
LoadedBoard >> initializeWormSquares [

	| worm1Position worm1 worm2Position worm2 |
	worm1Position := (self boardSize) atRandom.
	worm2Position := (self boardSize) atRandom.
	[ worm1Position = worm2Position ] whileTrue: [
		worm2Position := (self boardSize) atRandom ].
	worm1 := WormEffect withLink: worm2Position.
	worm2 := WormEffect withLink: worm1Position.
	(squares at: worm1Position) initializeWithEffect: worm1. 
	(squares at: worm2Position) initializeWithEffect: worm2.
]

{ #category : #initialization }
LoadedBoard >> initializeWormSquares [

	| worm1Position worm1 worm2Position worm2 |
	worm1Position := (self boardSize - 1) atRandom.
	worm2Position := (self boardSize - 1) atRandom.
	[ worm1Position = worm2Position ] whileTrue: [
		worm2Position := (self boardSize - 1) atRandom ].

	worm1 := WormSquare createEmptySquare.
	worm2 := WormSquare createEmptySquare.

	worm1 initializeLink: worm2.
	worm2 initializeLink: worm1.

	squares at: worm1Position put: worm1.
	squares at: worm2Position put: worm2
]

{ #category : #initialization }
LoadedBoard >> move: aShip distance: aDistance [

	| shipPosition |
	shipPosition := aShip getShipPosition.
	(aShip consumeFuel: aDistance)
		ifTrue: [
			(self takeOut: aShip).
			aShip setShipPosition: shipPosition + aDistance.
			^(self place: aShip at: shipPosition + aDistance)
			 ]
		ifFalse: [ self resetToStart: aShip.
					  aShip penalize: 2.
					  ^NullEffect new.
					 ].
	
]

{ #category : #initialization }
LoadedBoard >> place: aShip at: aPosition [

	| moveTo |
	moveTo := aPosition.
	[ moveTo > self boardSize ] whileTrue: [
		aShip addLaps: 1.
		moveTo := moveTo - self boardSize ].
	[ moveTo < 0 ] whileTrue: [
		aShip addLaps: -1.
		moveTo := moveTo + self boardSize ].
	aShip setShipPosition: moveTo.
	^ (squares at: moveTo) dockShip: aShip
]

{ #category : #initialization }
LoadedBoard >> removeEffects [
	squares do: [ :square | square initializeWithEffect: NullEffect new ]
]

{ #category : #initialization }
LoadedBoard >> resetToStart: aShip [
	self takeOut: aShip.
	self place: aShip at: 1.
]

{ #category : #initialization }
LoadedBoard >> showBoard [

	| dockedHere |
	squares do: [ :square |
		square getDockedShips isEmpty
			ifTrue: [ Transcript show: '#' ]
			ifFalse: [
				square getDockedShips do: [ :thisShip |
					Transcript show: thisShip getName ].
				Transcript show: '.' ] ].
	Transcript
		show: ''.
]

{ #category : #initialization }
LoadedBoard >> takeOut: aShip [

	| shipPosition |
	shipPosition := aShip getShipPosition.
	aShip setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aShip
]
