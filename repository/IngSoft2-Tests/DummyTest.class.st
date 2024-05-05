Class {
	#name : #DummyTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DummyTest >> testDummy [

	self assert: Dummy new isDummy
]

{ #category : #tests }
DummyTest >> testPrueba [

	self assert: Dummy new isDummy
]

{ #category : #tests }
DummyTest >> testPrueba2 [

self assert: true
]
