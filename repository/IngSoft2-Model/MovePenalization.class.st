Class {
	#name : #MovePenalization,
	#superclass : #MoveCondition,
	#instVars : [
		'cooldown'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MovePenalization class >> withCooldown: aCooldown [
	^(self new) initializeCooldown: aCooldown.
]

{ #category : #initialization }
MovePenalization >> canMove: aDistance [
	(cooldown <= 0) ifFalse:[
		cooldown := cooldown - 1.
		^false.
		].
	^true.
]

{ #category : #initialization }
MovePenalization >> initializeCooldown: aCooldown [
	cooldown := aCooldown.
]
