; Routines sonores

SndSilence
	; Coupe le sifflet au PSG
	lea	$ff8800,a0
	move.l	#$08000000,(a0)
	move.l	#$09000000,(a0)
	move.l	#$0a000000,(a0)
	rts
