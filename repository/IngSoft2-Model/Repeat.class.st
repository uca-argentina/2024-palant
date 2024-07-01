Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Repeat >> applyCardEffect [
	lastEffect applyEffect: targetPlayer. 
]
