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
Overload class >> removeCardEffect: aCard from: someCardList [
	someCardList remove: aCard.
]

{ #category : #initialization }
Overload >> applyCardEffect [
	targetPlayer activateCard: Overload.
]
