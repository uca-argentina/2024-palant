"
Board is made of squares, has the responsability of moving a ship and the initializers of particular squares.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize withWorms: hasWorms withParsecs: someParsecs withDice: someDice [
	|boardToReturn|
	boardToReturn := ((self new) initializeSize: aSize initializeParsecs: someParsecs).
	boardToReturn initializeRandomEffects: someDice.
	(hasWorms) ifTrue: [boardToReturn initializeWormSquares].
	^boardToReturn.
]

{ #category : #accessing }
Board >> boardSize [
	^(squares size).
]

{ #category : #accessing }
Board >> canReach: aPlayer distance: aDistance [
	| missingFuel |
	(aPlayer ship consumeFuel: aDistance) ifFalse: [
		(aPlayer getAlly isNil) ifTrue: [^false].
		missingFuel := aDistance - aPlayer getAlly ship getFuel.
		(aPlayer getAlly ship consumeFuel: missingFuel) ifFalse: [
			self resetToStart: aPlayer getAlly.
			aPlayer getAlly penalize: 2.
			^ false ] ].
	^ true
]

{ #category : #'modifier state' }
Board >> getParsecs [
	^parsecs.
]

{ #category : #'modifier state' }
Board >> getSquares [
	^squares.
]

{ #category : #initialization }
Board >> initializeRandomEffects: someDice [

	| probabilityScore |
	squares do: [ :square |
		probabilityScore := 100 atRandom.

		probabilityScore <= 40 ifTrue: [
			square initializeWithEffect: NullEffect new ].

		probabilityScore > 40 ifTrue: [
			square initializeWithEffect: BlackHole new ].

		probabilityScore > 60 ifTrue: [
			| maxRoll |
			maxRoll := 0.
			someDice do: [ :dice | maxRoll := maxRoll + dice getMax ].
			square initializeWithEffect:
				(HyperGravity withNecessaryRolledResult:
					 (someDice size to: maxRoll atRandom)) ].

		probabilityScore > 80 ifTrue: [
			square initializeWithEffect:
				(MoonWalk withDistance: self boardSize atRandom) ].

		probabilityScore > 90 ifTrue: [
			square initializeWithEffect:
				(HyperJump withParsecs: #( 2 4 3 5 9 10 ) asOrderedCollection) ].

		probabilityScore > 98 ifTrue: [
			square initializeWithEffect: AtomicBomb new ] ]
]

{ #category : #initialization }
Board >> initializeSize: aSize initializeParsecs: someParsecs [

	squares := OrderedCollection new.
	1 to: aSize do: [ :x | squares add: Square createEmptySquare ].
	parsecs := someParsecs
]

{ #category : #initialization }
Board >> initializeWormSquares [

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

{ #category : #action }
Board >> move: aPlayer distance: aDistance [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	(self canReach: aPlayer distance: aDistance )
		ifTrue: [
			(self takeOut: aPlayer).
			aPlayer ship setShipPosition: shipPosition + aDistance.
			^(self place: aPlayer at: shipPosition + aDistance)
			 ]
		ifFalse: [
			
			
			 self resetToStart: aPlayer ship.
					  aPlayer ship penalize: 2.
					  ^NullEffect new.
					 ].
	
]

{ #category : #accessing }
Board >> place: aPlayer at: aPosition [

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

{ #category : #'modifier state' }
Board >> resetToStart: aPlayer [
	self takeOut: aPlayer.
	self place: aPlayer at: 1.
]

{ #category : #'modifier state' }
Board >> takeOut: aPlayer [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	aPlayer ship setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aPlayer ship
]
