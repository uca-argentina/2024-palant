"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'name',
		'fuelTank',
		'laps',
		'cooldown'
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
Ship >> canPlay [
	(cooldown > 0) ifTrue: [ 
			cooldown := cooldown - 1.
			^false. 
		] ifFalse:[
		^true.
		]
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [
	^(fuelTank consumeFuel: someFuel).
]

{ #category : #testing }
Ship >> decideToPlay [
	((3 atRandom) = 1) ifFalse: [ ^ true].
	^false.
	
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
	cooldown:=0.
	laps := 0.
	name := aName.
]

{ #category : #'class initialization' }
Ship >> initializeName: aName initializeTank: aTank [
	cooldown:=0.
	laps := 0.
	name := aName.
	fuelTank := aTank.
]

{ #category : #accessing }
Ship >> penalize [
	cooldown := 2.
]

{ #category : #accessing }
Ship >> play: someDice [
	(self canPlay) ifTrue:[
		(self decideToPlay) ifTrue:[
			^self rollDice: someDice.
		] ifFalse:[
			^self skipTurn.
		].
	] ifFalse:[
		^0.
	].
]

{ #category : #accessing }
Ship >> rollDice: someDice [ 
	|result|
	result := 0.
	someDice do: [ :die | result:= result  + die throw ].
	^result.
]

{ #category : #accessing }
Ship >> skipTurn [ 
	fuelTank reset.
	^0.
]

{ #category : #testing }
Ship >> subtractLap [
	laps := laps - 1.
]

{ #category : #accessing }
Ship >> tank [
	^fuelTank.
]
