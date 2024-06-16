"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'gravityLevel',
		'position',
		'fuel',
		'maxFuel',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> withFuel: someFuel [
	^(self new) initializeFuel: someFuel.
]

{ #category : #getsAndSets }
Ship >> addLaps: lapAmount [ 
	laps:= laps + lapAmount.
]

{ #category : #accessing }
Ship >> canMove: aDistance [

	aDistance = gravityLevel ifTrue: [ gravityLevel := 0 ].
	^ gravityLevel = 0
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [

	| fuelAmountModule |
	fuelAmountModule := someFuel abs.
	fuel := fuel - fuelAmountModule.
	fuel < 0 ifTrue: [
		fuel := 0.
		^ false ].
	^ true
]

{ #category : #getsAndSets }
Ship >> getFuel [
	^fuel 
]

{ #category : #getsAndSets }
Ship >> getGravity [
	^gravityLevel.
]

{ #category : #getsAndSets }
Ship >> getLaps [
	^laps.
]

{ #category : #getsAndSets }
Ship >> getShipPosition [
	^position 
]

{ #category : #getsAndSets }
Ship >> initializeFuel: someFuel [
	maxFuel := someFuel.
	laps := 0.
	gravityLevel := 0.
	fuel := someFuel.
	
]

{ #category : #accessing }
Ship >> resetFuelTank [
	fuel := maxFuel.
]

{ #category : #getsAndSets }
Ship >> setGravity: someLevel [

	gravityLevel := someLevel
]

{ #category : #getsAndSets }
Ship >> setShipPosition:  someSquare [

	position := someSquare
]
