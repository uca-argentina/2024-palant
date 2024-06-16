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
LoadedBoard >> move: aPlayer distance: aDistance [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	(aPlayer ship consumeFuel: aDistance)
		ifTrue: [
			(self takeOut: aPlayer).
			aPlayer ship setShipPosition: shipPosition + aDistance.
			^(self place: aPlayer at: shipPosition + aDistance)
			 ]
		ifFalse: [ self resetToStart: aPlayer.
					  aPlayer penalize: 2.
					  ^NullEffect new.
					 ].
	
]

{ #category : #initialization }
LoadedBoard >> place: aPlayer at: aPosition [

	| moveTo |
	moveTo := aPosition.
	[ moveTo > self boardSize ] whileTrue: [
		aPlayer ship addLaps: 1.
		moveTo := moveTo - self boardSize ].
	[ moveTo <= 0 ] whileTrue: [
		aPlayer ship addLaps: -1.
		moveTo := moveTo + self boardSize ].
	aPlayer ship setShipPosition: moveTo.
	^ (squares at: moveTo) dockShip: aPlayer ship.
]

{ #category : #initialization }
LoadedBoard >> removeEffects [
	squares do: [ :square | square initializeWithEffect: NullEffect new ]
]

{ #category : #initialization }
LoadedBoard >> resetToStart: aPlayer [
	self takeOut: aPlayer.
	self place: aPlayer at: 1.
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
LoadedBoard >> takeOut: aPlayer [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	aPlayer ship setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aPlayer ship
]
