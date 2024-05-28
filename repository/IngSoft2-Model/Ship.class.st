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
		'penalization',
		'gravityLevel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> named: aName [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName.
]

{ #category : #testing }
Ship >> addLap [
	laps:= laps +1.
]

{ #category : #accessing }
Ship >> canMove: aDistance [
	(aDistance = gravityLevel) ifTrue:[
			gravityLevel := 0.
		].
	^(gravityLevel = 0).
]

{ #category : #accessing }
Ship >> canPlay [
	(penalization = 0) ifFalse: [ 
		penalization := penalization - 1.
		(penalization = 0) ifTrue: [ 
				fuelTank reset.
			].
		^false.
		 ].
	^true.
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [
	^(fuelTank consumeFuel: someFuel).
]

{ #category : #testing }
Ship >> decideToPlay [
	^true.
	
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
	penalization := 0.
	gravityLevel := 0.
	laps := 0.
	name := aName.
]

{ #category : #'class initialization' }
Ship >> initializeTank: aTank [
	fuelTank := aTank.
]

{ #category : #accessing }
Ship >> penalize: penalizationAmount [
	penalization := penalization + penalizationAmount.
]

{ #category : #accessing }
Ship >> play: someDice [
	|rollResult|
	(self canPlay) ifTrue:[
		(self decideToPlay) ifTrue: [ 
				rollResult := self rollDice: someDice.
				(self canMove: rollResult) ifTrue:[
				^rollResult.
				].
			 ] ifFalse: [ self skipTurn ].
		].
		^0.
]

{ #category : #accessing }
Ship >> rollDice: someDice [ 
	|result|
	result := 0.
	someDice do: [ :die | result:= result  + die throw ].
	^result.
]

{ #category : #testing }
Ship >> setGravity: someLevel [
	gravityLevel := someLevel.
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
