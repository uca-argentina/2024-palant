Class {
	#name : #EndSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
EndSquare >> dockShip: aShip [
	dockedShips add: aShip.
	aShip setWinner.
	^true.
]
