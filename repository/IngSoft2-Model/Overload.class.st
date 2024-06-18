Class {
	#name : #Overload,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload class >> affectRollResult [
	^-2.
]

{ #category : #'as yet unclassified' }
Overload class >> removeCardEffect [
 ^true.
]

{ #category : #initialization }
Overload >> applyCardEffect [
	(myTarget at: 1) activateCard: Overload.
]
