Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cancellation >> applyCardEffect [
	(myTarget at: 1) deactivateCard: (myTarget at: 2).
]
