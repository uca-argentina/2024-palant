Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
NullCard class >> canBeUsedAnytime [
	^true.
]

{ #category : #initialization }
NullCard >> applyCardEffect [
	^true.
]
