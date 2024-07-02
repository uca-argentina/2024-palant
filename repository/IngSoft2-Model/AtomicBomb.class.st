Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
AtomicBomb >> applyEffect: affectedPlayer [

	players do: [ :aPlayer |
		aPlayer ship getGravity > 0 ifFalse: [ board resetToStart: aPlayer ] ]
]
