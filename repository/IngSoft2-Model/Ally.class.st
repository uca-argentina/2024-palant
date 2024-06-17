Class {
	#name : #Ally,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ally >> applyCardEffect [
	(thisContext sender receiver) setAlly: myTarget.
]
