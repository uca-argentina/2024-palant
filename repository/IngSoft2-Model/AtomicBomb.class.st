Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBomb >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [

	someShips do: [ :aShip | (aShip getGravity > 0) ifFalse: [aBoard resetToStart: aShip] ]
]
