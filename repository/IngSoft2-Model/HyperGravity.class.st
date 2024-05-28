Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'necessaryRolledResult'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperGravity class >> withNecessaryRolledResult: someResult [
	^(self new) initializeNecesaryRolledResult: someResult.
]

{ #category : #'as yet unclassified' }
HyperGravity >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [

	affectedShip setGravity: necessaryRolledResult
]

{ #category : #'as yet unclassified' }
HyperGravity >> initializeNecesaryRolledResult: aResult [
necessaryRolledResult := aResult.
]
