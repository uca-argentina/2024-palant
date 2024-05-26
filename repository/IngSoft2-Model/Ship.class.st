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
		'moveConditions'
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
Ship >> canPlay: distance [
	(moveConditions anySatisfy: [ :aCondition | ((aCondition canMove: distance) = false) ]) ifFalse: [ ^true ].
	^false. 
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
	moveConditions := OrderedCollection new.
	laps := 0.
	name := aName.
]

{ #category : #'class initialization' }
Ship >> initializeName: aName initializeTank: aTank [
	moveConditions := OrderedCollection new.
	laps := 0.
	name := aName.
	fuelTank := aTank.
]

{ #category : #accessing }
Ship >> penalize: newCondition [.
	moveConditions add: newCondition.
]

{ #category : #accessing }
Ship >> play: someDice [
	|rollResult|
	(self decideToPlay) ifTrue:[
			rollResult := self rollDice: someDice.
			(self canPlay: rollResult) ifTrue:[
				^rollResult.
				] ifFalse:[
				^0
				]
		] ifFalse: [ 
		 self canPlay: 0.
		 ^self skipTurn.
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
