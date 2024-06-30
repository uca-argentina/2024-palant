Class {
	#name : #MeasureUnit,
	#superclass : #Object,
	#instVars : [
		'distanceUnits'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MeasureUnit class >> withUnits: someUnits [ 
 ^(self new) initializeUnits: someUnits 
]

{ #category : #initialization }
MeasureUnit >> initializeUnits: someUnits [
	distanceUnits:=someUnits 
]
