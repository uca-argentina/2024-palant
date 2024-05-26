Class {
	#name : #HyperG,
	#superclass : #MoveCondition,
	#instVars : [
		'necessaryRolledResult'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperG class >> withNecessaryRolledResult: aRolledResult [
	^(self new) initializeNecesaryRolledResult: aRolledResult.
]

{ #category : #initialization }
HyperG >> canMove: aDistance [
	^(aDistance = necessaryRolledResult)
]

{ #category : #initialization }
HyperG >> initializeNecesaryRolledResult: someRollResult [
	necessaryRolledResult := someRollResult.
]
