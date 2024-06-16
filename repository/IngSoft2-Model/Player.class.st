Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'penalization',
		'ship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: aName withShip: aShip [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName initializeShip: aShip.
]

{ #category : #accessing }
Player >> decideToPlay [
	^true.
	
]

{ #category : #accessing }
Player >> getName [
	^name.

]

{ #category : #accessing }
Player >> getPenalization [
	^penalization.
]

{ #category : #accessing }
Player >> initializeName: aName initializeShip: aShip [
	penalization := 0.
	name:=aName.
	ship := aShip.
]

{ #category : #accessing }
Player >> penalize: penalizationAmount [

	penalization := penalization + penalizationAmount
]

{ #category : #accessing }
Player >> play: someDice [
	| rollResult |
	rollResult := self rollDice: someDice.
	(ship canMove: rollResult) ifTrue: [ ^ rollResult ].
	^ 0
]

{ #category : #accessing }
Player >> rollDice: someDice [
	| result |
	result := 0.
	someDice do: [ :die | result := result + die throw ].
	^ result
]

{ #category : #accessing }
Player >> ship [
^ship
]
