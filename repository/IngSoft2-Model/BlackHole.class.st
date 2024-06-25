Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
BlackHole >> applyEffect: affectedPlayer withPlayers: somePlayers inBoard: aBoard [

	aBoard move: (affectedPlayer) distance: -4
]
