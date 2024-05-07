Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'dockedShips'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Square class >> createEmptySquare [
	^(self new) initializeEmptySquare.
]

{ #category : #initialization }
Square >> dockShip: aShip [
	dockedShips add: aShip.
	^true.
]

{ #category : #initialization }
Square >> getDockedShips [
	^dockedShips.
]

{ #category : #initialization }
Square >> initializeEmptySquare [
	dockedShips := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Square >> undockShip: aShip [ 
	dockedShips remove: aShip ifAbsent: [ ^false ]. 
	^true.
]
