Class {
	#name : #TotalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
TotalTest >> testRandomGameFinishes [
	|ships board dice game|
	
	ships := OrderedCollection new.
	1 to: 5 do: [ :x | ships add: (Ship named: x asString)].
		
	dice := OrderedCollection new.
	1 to: 2 do: [ :x | dice add: 
		(
			Die of: (3 to: 4) atRandom
		).
		].
	
	board := Board withSize: ((5 to: 50) atRandom).
	
	game := Game new.
	game initializeBoard: board initializeDice: dice initializeShips: ships initializeMaxLaps: 3.
	game begin.
	self assert:((game getStatus) = 'Over').
	
	
]
