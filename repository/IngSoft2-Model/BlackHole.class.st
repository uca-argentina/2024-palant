Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BlackHole >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [
	aBoard move: affectedShip  distance: -4.
]
