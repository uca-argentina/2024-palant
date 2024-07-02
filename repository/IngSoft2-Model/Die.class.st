"
Die returns the random number according to the faces it has been initialized with.
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Die class >> isValid: anAmountOfFaces [
	anAmountOfFaces < 3 ifTrue: [
		Error signal: 'Faces should be more than 2' ]

]

{ #category : #testing }
Die class >> of: anAmountOfFaces [ 
	self isValid: anAmountOfFaces.
	^ self new initializeOf: anAmountOfFaces

]

{ #category : #getsAndSets }
Die >> getMax [
^faces.
]

{ #category : #initialization }
Die >> initializeOf: anAmountOfFaces [
	faces:=anAmountOfFaces

]

{ #category : #action }
Die >> throw [
	^(1 to: faces) atRandom.

]
