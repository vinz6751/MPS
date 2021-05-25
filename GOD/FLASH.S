; Effet de flash. Appeler FlashNow pour d‚clencer le flash.
; FlashAnimation doit ˆtre appel‚ depuis la routine VBL.
; Vinz/MPS

	SECTION TEXT
FlashNow
	move.w	#$0777,flashClr ; couleur flash (blanc)
	rts
	
FlashAnimation
	tst.w	flashClr
	bmi.s	.rts
	move.w	d4,-(sp)
	move.w	flashClr,d4
	move.w	d4,$ffff8240.w
	subi.w	#$777/2,d4
	move.w	d4,flashClr
	bpl.s	.done
	move.w	FlashBg,$ffff8240.w ; flash fini, on restaure le fond
.done	move.w	(sp)+,d4	
.rts	rts

	SECTION BSS
flashClr	ds.w	1 ; prochaine couleur du flash
FlashBg	ds.w	1 ; sauvegarde du couleur du fond