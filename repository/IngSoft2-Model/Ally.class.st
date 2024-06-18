Class {
	#name : #Ally,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ally >> applyCardEffect [
	(thisContext sender receiver) setAlly: (myTarget at: 1).
	(thisContext sender receiver) activateCard: Ally.
	(myTarget at: 1) activateCard: Ally. 
]
