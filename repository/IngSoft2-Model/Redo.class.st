Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo class >> canBeUsedAnytime [
	(thisContext sender receiver getLastCard isNil) ifFalse:[
	^ (thisContext sender receiver) getLastCard canBeUsedAnytime.
	].
	^true.
]

{ #category : #initialization }
Redo >> applyCardEffect [
	lastEffect applyEffect: targetPlayer
]
