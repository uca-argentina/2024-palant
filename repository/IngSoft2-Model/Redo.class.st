Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo class >> canBeUsedConsidering: lastCard [
	(lastCard isNil) ifFalse:[
	^ lastCard canBeUsedConsidering: self.
	].
	^true.
]

{ #category : #initialization }
Redo >> applyCardEffect: cardUser [

	lastCard isNil ifFalse: [
		(lastCard
			 withTargetPlayer: targetPlayer
			 withTargetCard: targetCard
			 withLastEffect: lastEffect
			 withLastCard: lastCard
			 withBoard: board) applyCardEffect: cardUser ]
]
