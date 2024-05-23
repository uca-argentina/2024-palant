"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'name',
		'fuelTank',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> named: aName [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName initializeTank: (FuelTank withMax: 10000000000).
]

{ #category : #'instance creation' }
Ship class >> named: aName withTank: aTank [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName initializeTank: aTank.
]

{ #category : #testing }
Ship >> addLap [
	laps:= laps +1.
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [
	^(fuelTank consumeFuel: someFuel).
]

{ #category : #testing }
Ship >> getLaps [
	^laps.
]

{ #category : #testing }
Ship >> getName [
	^name.
]

{ #category : #'class initialization' }
Ship >> initializeName: aName [
	laps := 0.
	name := aName.
]

{ #category : #'class initialization' }
Ship >> initializeName: aName initializeTank: aTank [
	laps := 0.
	name := aName.
	fuelTank := aTank.
]

{ #category : #accessing }
Ship >> rollDice: someDice [ 
	|result|
	result := 0.
	someDice do: [ :die | result:= result  + die throw ].
	^result.
]

{ #category : #testing }
Ship >> subtractLap [
	laps := laps - 1.
]

{ #category : #accessing }
Ship >> tank [
	^fuelTank.
]
