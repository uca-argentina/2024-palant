Class {
	#name : #TotalTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
TotalTest >> testRandomGameFinishes [
	|ships board dice game|
	
	ships := OrderedCollection new.
	1 to: 5 do: [ :x | ships add: (Ship named: x asString withFuel: 1000)].
		
	dice := OrderedCollection new.
	1 to: 5 do: [ :x | dice add: 
		(
			Die of: (35 to: 60) atRandom
		).
		].
	
	board := Board withSize: ((5 to: 15) atRandom) withWorms: true withParsecs: 0.
	
	game := Game withBoard: board withDice: dice withShips: ships withMaxLaps: 1.
	game begin.
	game gameplay.
	self assert:(game getStatus) equals: 'Over'.
	
	
]
