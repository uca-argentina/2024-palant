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
Overload class >> removeCardEffect: aCard fromCards: someCardList fromPlayer: aPlayer [
	someCardList remove: aCard.
]

{ #category : #initialization }
Overload >> applyCardEffect: cardUser [
	targetPlayer activateCard: Overload.
]
