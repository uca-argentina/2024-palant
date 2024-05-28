"
Square can dock and undock ships from itself and can return which ships are docked there.
"
Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'dockedShips',
		'myEffect'
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
	^myEffect.
]

{ #category : #initialization }
Square >> getDockedShips [
	^dockedShips.
]

{ #category : #initialization }
Square >> initializeEmptySquare [

	myEffect := NullEffect new.
	dockedShips := OrderedCollection new
]

{ #category : #initialization }
Square >> initializeWithEffect: anEffect [

	myEffect := anEffect.
	dockedShips := OrderedCollection new
]

{ #category : #modifying }
Square >> undockShip: aShip [

	dockedShips remove: aShip ifAbsent: [ ^ false ].
	^ true
]
