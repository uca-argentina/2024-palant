"
Square can dock and undock ships from itself and can return which ships are docked there.
"
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

{ #category : #modifying }
Square >> undockShip: aShip [ 
	dockedShips remove: aShip ifAbsent: [ ^false ]. 
	^true.
]
