Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
AtomicBomb >> applyEffect: affectedPlayer withPlayers: somePlayers inBoard: aBoard [

	somePlayers do: [ :aPlayer |
		aPlayer ship getGravity > 0 ifFalse: [ aBoard resetToStart: aPlayer ] ]
]
