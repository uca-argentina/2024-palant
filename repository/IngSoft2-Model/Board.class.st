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
	^(self new) initializeSize: aSize.
]

{ #category : #initialization }
Board >> boardSize [
	^(squares size).
]

{ #category : #initialization }
Board >> findShip: aShip [

	1 to: (self boardSize) do: [:x | ((squares at: x) getDockedShips includes: aShip)  ifTrue: [ ^x ] ].

]

{ #category : #initialization }
Board >> initializeSize: aSize [ 
	squares := OrderedCollection new.
	1 to: (aSize - 1) do: [:x | squares add: Square createEmptySquare ].
	squares add: EndSquare createEmptySquare.
]

{ #category : #'as yet unclassified' }
Board >> move: aShip distance: aDistance [ 
	|shipPosition|
	shipPosition := self findShip: aShip.
	^((self takeOut: aShip) and: (self place: aShip at: (shipPosition + aDistance)))
]

{ #category : #accessing }
Board >> place: aShip at: aPosition [ 
	(aPosition > squares size) ifTrue: [ (squares at: (self boardSize)) dockShip: aShip ]
	ifFalse: [ 
	(squares at: aPosition) dockShip: aShip.
	].
	^true.
]

{ #category : #'as yet unclassified' }
Board >> takeOut: aShip [
	|shipPosition|
	shipPosition := (self findShip: aShip).
	^(squares at: shipPosition) undockShip: aShip. 
	
]
