Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
BlackHole >> applyEffect: affectedPlayer [

	board move: (affectedPlayer) distance: -4
]
