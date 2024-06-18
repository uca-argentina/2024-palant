Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'penalization',
		'ship',
		'cards',
		'ally',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: aName withShip: aShip [
	(aName isEmpty) ifTrue: [ Error signal: 'Ship must have a name' ].
	^(self new) initializeName: aName initializeShip: aShip.
]

{ #category : #accessing }
Player >> activateCard: aCard [
	activeCards add: aCard.
]

{ #category : #accessing }
Player >> addCards: someCards [

	someCards do: [ :card | cards add: card ]
]

{ #category : #accessing }
Player >> deactivateCard: aCard [
	aCard removeCardEffect.
	activeCards remove: aCard.
]

{ #category : #accessing }
Player >> getActiveCards [
	^activeCards.
]

{ #category : #accessing }
Player >> getAlly [ 
	^ally.
]

{ #category : #accessing }
Player >> getCards [
	^cards.
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
	cards := OrderedCollection new.
	activeCards := OrderedCollection new.
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
Player >> removeCard: aCard [
	| cardIndex |
	1 to: cards size do: [ :x |
	(cards at: x) = aCard ifTrue: [ cardIndex := x ] ].
	cards removeAt: cardIndex
]

{ #category : #accessing }
Player >> rollDice: someDice [
	| result |
	result := 0.
	someDice do: [ :die | result := result + die throw ].
	activeCards do: [ :card | result := result + card affectRollResult ].
	^ result
]

{ #category : #accessing }
Player >> setAlly: aPlayer [
	ally := aPlayer.
]

{ #category : #accessing }
Player >> ship [
^ship
]

{ #category : #accessing }
Player >> useCard: aCard [
	aCard applyCardEffect.
]
