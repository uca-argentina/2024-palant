Class {
	#name : #FuelTank,
	#superclass : #Object,
	#instVars : [
		'maxFuel',
		'currentFuel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
FuelTank class >> withMax: someFuelAmmount [
	^(self new) initializeWithFuel: someFuelAmmount.
]

{ #category : #initialization }
FuelTank >> consumeFuel: fuelToBeConsumed [
	|fuelAmountModule|
	fuelAmountModule := fuelToBeConsumed abs.
	currentFuel := currentFuel  - fuelAmountModule.
	(currentFuel < 0) ifTrue: [currentFuel := 0. ^false].
	^true.
]

{ #category : #initialization }
FuelTank >> initializeWithFuel: someFuelAmmount [
	currentFuel := someFuelAmmount.
	maxFuel := someFuelAmmount.
]

{ #category : #initialization }
FuelTank >> reset [
	currentFuel := maxFuel.
]

{ #category : #initialization }
FuelTank >> status [
	^currentFuel.
]
