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
	^(self new) initializeNecesaryRolledResult.
]

{ #category : #initialization }
HyperG >> initializeNecesaryRolledResult [
	^(necessaryRolledResult).
]
