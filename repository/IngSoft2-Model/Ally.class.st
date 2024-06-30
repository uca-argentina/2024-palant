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
Ally class >> removeCardEffect: aCard from: someCardList [
   someCardList remove: aCard.
	thisContext sender receiver setAlly: nil
]

{ #category : #initialization }
Ally >> applyCardEffect [
	(thisContext sender receiver) setAlly: targetPlayer.
	(thisContext sender receiver) activateCard: Ally.
]
