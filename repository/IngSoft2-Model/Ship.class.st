"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'name',
		'laps',
		'penalization',
		'gravityLevel',
		'position',
		'fuel',
		'maxFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> named: aName withFuel: someFuel [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName initializeFuel: someFuel.
]

{ #category : #accessing }
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

{ #category : #accessing }
Ship >> decideToPlay [
	^true.
	
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
Ship >> getName [
	^name.
]

{ #category : #getsAndSets }
Ship >> getPenalization [
	^penalization.
]

{ #category : #getsAndSets }
Ship >> getShipPosition [
	^position 
]

{ #category : #'class initialization' }
Ship >> initializeName: aName initializeFuel: someFuel [

	penalization := 0.
	gravityLevel := 0.
	position := 1.
	laps := 0.
	name := aName.
	fuel := someFuel.
	maxFuel := someFuel
]

{ #category : #accessing }
Ship >> penalize: penalizationAmount [

	penalization := penalization + penalizationAmount
]

{ #category : #accessing }
Ship >> play: someDice [

	| rollResult |
	rollResult := self rollDice: someDice.
	(self canMove: rollResult) ifTrue: [ ^ rollResult ].
	^ 0
]

{ #category : #accessing }
Ship >> resetFuelTank [

	fuel := maxFuel.
]

{ #category : #accessing }
Ship >> rollDice: someDice [

	| result |
	result := 0.
	someDice do: [ :die | result := result + die throw ].
	^ result
]

{ #category : #getsAndSets }
Ship >> setGravity: someLevel [

	gravityLevel := someLevel
]

{ #category : #getsAndSets }
Ship >> setShipPosition:  someSquare [

	position := someSquare
]
