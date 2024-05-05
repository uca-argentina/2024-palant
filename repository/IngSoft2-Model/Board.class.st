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
Board >> initializeSize: aSize [ 
	squares := OrderedCollection new.
	1 to: aSize do: [:x | squares add: Square createEmptySquare ]
]

{ #category : #accessing }
Board >> place: aShip at: aPosition [ 
	(aPosition > squares size) ifTrue: [ Error signal: 'Cannot place ship outside the board.'].
	(squares at: aPosition) dockShip: aShip.
	^true.
]
