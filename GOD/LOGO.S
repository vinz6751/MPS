	SECTION TEXT
LogoInit:
LogoDeinit:
	rts
logoNext	dc.l logos

	
LogoAnimation:
	subi.w	#1,logoSlow
	beq.s	.do
	rts

.do:	move.w	#7,logoSlow
	move.l	logoNext(pc),a2
	move.l	(a2)+,a1
	
	movea.l	BmpFb,a0
	lea.l	160-8*3(a0),a0
	moveq	#48-1,d1
.boucle:	move.l	(a1)+,(a0)
	move.l	(a1)+,4(a0)
	move.l	(a1)+,8(a0)
	move.l	(a1)+,12(a0)
	move.l	(a1)+,16(a0)
	move.l	(a1)+,20(a0)
	lea	160(a0),a0
	dbra	d1,.boucle

	tst.l	(a2)
	bne.s	.stocke
	lea	logos,a2	
.stocke	move.l	a2,logoNext
	rts


	SECTION DATA
logoSlow:	dc.w   50
logos:	dc.l   logo1,logo2,logo3,logo4,logo3,logo2,0
logoWrap:
logo1:	INCBIN "elite\logo1.bmp"
logo2:	INCBIN "elite\logo2.bmp"
logo3:	INCBIN "elite\logo3.bmp"
logo4:	INCBIN "elite\logo4.bmp"

