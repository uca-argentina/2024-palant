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
LoadedBoard class >> withSize: aSize withWorms: hasWorms withParsecs: someParsecs [
	|boardToReturn|
	boardToReturn := ((self new) initializeSize: aSize initializeParsecs: someParsecs).
	(hasWorms) ifTrue: [boardToReturn initializeWormSquares].
	^boardToReturn.
]

{ #category : #initialization }
LoadedBoard >> boardSize [
	^(squares size).
]

{ #category : #initialization }
LoadedBoard >> findShip: aShip [

	1 to: (self boardSize) do: [:x | ((squares at: x) getDockedShips includes: aShip)  ifTrue: [ ^x ] ].
	^-1.
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
LoadedBoard >> initializeSize: aSize initializeParsecs: someParsecs [
	squares := OrderedCollection new.
	1 to: aSize do: [:x | squares add: Square createEmptySquare ].
	parsecs := someParsecs.
	
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
		aShip addLap.
		moveTo := moveTo - self boardSize ].
	[ moveTo < 0 ] whileTrue: [
		aShip subtractLap.
		moveTo := moveTo + self boardSize ].
	aShip setShipPosition: moveTo.
	^ (squares at: moveTo) dockShip: aShip
]

{ #category : #initialization }
LoadedBoard >> resetToStart: aShip [
	self takeOut: aShip.
	self place: aShip at: 1.
]

{ #category : #initialization }
LoadedBoard >> takeOut: aShip [

	| shipPosition |
	shipPosition := aShip getShipPosition.
	aShip setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aShip
]