; Effet de flash. Appeler FlashNow pour d‚clencer le flash.
; FlashAnimation doit ˆtre appel‚ depuis la routine VBL.
; Vinz/MPS

	SECTION TEXT
FlashNow
	move.w	#$0777,flashClr ; couleur flash (blanc)
	rts
	
FlashAnimation
	; Animation du flash. 
	; Pourrie d1.w
	tst.w	flashClr
	bmi.s	.rts
	move.w	flashClr,d1
	move.w	d1,$ffff8240.w
	subi.w	#$777/2,d1
	move.w	d1,flashClr
	bpl.s	.done
	move.w	FlashBg,$ffff8240.w ; flash fini, on restaure le fond
.done
.rts	rts

	SECTION BSS
flashClr	ds.w	1 ; prochaine couleur du flash
FlashBg	ds.w	1 ; sauvegarde du couleur du fond