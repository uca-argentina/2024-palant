Class {
	#name : #MoveCondition,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
MoveCondition >> canMove: aDistance [
	self subclassResponsibility.
]