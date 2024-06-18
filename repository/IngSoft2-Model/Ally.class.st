Class {
	#name : #Ally,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Ally class >> affectRollResult [
	^0.
]

{ #category : #'as yet unclassified' }
Ally class >> removeCardEffect [
	(thisContext sender receiver) setAlly: nil.
]

{ #category : #initialization }
Ally >> applyCardEffect [
	(thisContext sender receiver) setAlly: (myTarget at: 1).
	(thisContext sender receiver) activateCard: Ally.
]
