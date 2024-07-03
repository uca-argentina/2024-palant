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
Ally class >> removeCardEffect: aCard fromCards: someCardList fromPlayer: aPlayer [
   someCardList remove: aCard.
	aPlayer setAlly: nil
]

{ #category : #initialization }
Ally >> applyCardEffect [
	usedBy setAlly: targetPlayer.
	usedBy activateCard: Ally.
]

{ #category : #initialization }
Ally >> applyCardEffect: cardUser [
	cardUser setAlly: targetPlayer.
	cardUser activateCard: Ally.
]
