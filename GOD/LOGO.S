	SECTION TEXT
LogoInit:
LogoDeinit:
	rts
logoNext	dc.l logos

	
LogoAnimation:
	tst.w	logoRun ; si pas d'animation on sort
	beq.s	.rts
	
	subi.w	#1,logoSlow ; ralentisseur d'animation
	beq.s	.do
	rts

.do:	move.w	#7,logoSlow

	movea.l	logoNext(pc),a2
	movea.l	(a2)+,a1
	movea.l	a1,a3 ; a3: logo que l'on dessine
	
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

	; regarde s'il y a une demande d'arr�t
	tst.w	LogoOnOff ; si le logo est off, on continue quand m�me
	bne.s	.rts ; le cycle en cours
	cmpa.l	#logo1,a3 ; on est � la position de d�part ?
	bne.s	.rts
	clr.w	logoRun ; oui -> on arr�te l'animation

.rts	rts


	SECTION DATA
logoRun   dc.w   -1 ; si on anime ou pas
LogoOnOff dc.w   -1 ; demande de marche -1 ou d'arr�t 0
logoZ	dc.w   1
logoSlow:	dc.w   50
logos:	dc.l   logo1,logo2,logo3,logo4,logo3,logo2,0
logoWrap:
logo1:	INCBIN "elite\logo1.bmp"
logo2:	INCBIN "elite\logo2.bmp"
logo3:	INCBIN "elite\logo3.bmp"
logo4:	INCBIN "elite\logo4.bmp"

