"
Loaded Die is a specific die to force certain results and test code out.
"
Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
LoadedDie class >> isValid: anAmountOfFaces [ 
	anAmountOfFaces < 3 ifTrue: [
		Error signal: 'Faces should be more than 2' ]

]

{ #category : #testing }
LoadedDie class >> of: anAmountOfFaces [ 
	self isValid: anAmountOfFaces.
	^ self new initializeOf: anAmountOfFaces

]

{ #category : #initialization }
LoadedDie >> initializeOf: anAmountOfFaces [
	faces:= anAmountOfFaces
]

{ #category : #initialization }
LoadedDie >> throw [ 
	^faces.
]
