Class {
	#name : #MovePenalization,
	#superclass : #MoveCondition,
	#instVars : [
		'cooldown'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MovePenalization class >> withCooldown [
	^(self new) initializeCooldown.
]

{ #category : #initialization }
MovePenalization >> initializeCooldown [
	^cooldown.
]
