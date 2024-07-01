Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cancellation >> applyCardEffect [
	targetPlayer deactivateCard: targetCard.
]
