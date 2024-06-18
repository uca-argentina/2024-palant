Class {
	#name : #Acceleration,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration class >> affectRollResult [
	^1.
]

{ #category : #'as yet unclassified' }
Acceleration class >> removeCardEffect [
 ^true.
]

{ #category : #initialization }
Acceleration >> applyCardEffect [
	players do: [ :player | player activateCard: Acceleration].
]
