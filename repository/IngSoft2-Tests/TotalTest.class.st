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
			Die of: (30 to: 40) atRandom
		).
		].
	
	board := Board withSize: ((5 to: 30) atRandom).
	
	game := Game withBoard: board withDice: dice withShips: ships withMaxLaps: 3.
	game begin.
	game gameplay.
	self assert:(game getStatus) equals: 'Over'.
	
	
]
