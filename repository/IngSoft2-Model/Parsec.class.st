Class {
	#name : #Parsec,
	#superclass : #MeasureUnit,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Parsec >> parseToSquares: aSize parsecAmount: anAmount [
	^(distanceUnits * (aSize/anAmount )) truncated.
]
