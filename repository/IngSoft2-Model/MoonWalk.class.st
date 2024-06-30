Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'myDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withDistance: aDistance [
 ^(self new) initializeDistance: aDistance.
]

{ #category : #application }
MoonWalk >> applyEffect: affectedPlayer [

	players do: [ :aPlayer |
		affectedPlayer = aPlayer ifFalse: [
			aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: myDistance * -1 ] ] ]
]

{ #category : #initialization }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
