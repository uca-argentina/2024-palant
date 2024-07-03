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
Acceleration class >> removeCardEffect: aCard fromCards: someCardList fromPlayer: aPlayer [
 someCardList remove: aCard.
]

{ #category : #action }
Acceleration >> applyCardEffect: cardUser [
	targetPlayer do: [ :player | player activateCard: Acceleration].
]
