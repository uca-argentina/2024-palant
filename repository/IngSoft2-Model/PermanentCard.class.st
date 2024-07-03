Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
PermanentCard class >> affectRollResult [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PermanentCard class >> canBeUsedAnytime [
	^false.
]

{ #category : #'as yet unclassified' }
PermanentCard class >> removeCardEffect: aCard from: aCardList [
	self subclassResponsibility.
]
