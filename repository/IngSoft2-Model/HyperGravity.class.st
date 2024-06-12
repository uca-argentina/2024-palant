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

{ #category : #application }
HyperGravity >> applyEffect: affectedShip withShips: someShips inBoard: aBoard [

	affectedShip setGravity: necessaryRolledResult
]

{ #category : #initialization }
HyperGravity >> initializeNecesaryRolledResult: aResult [
necessaryRolledResult := aResult.
]
