; Routines de blittage

BlitL32
	; Blitte une image de 32 pixels de large
	; d0.w: x (mod 8 = 0)  d1.w: y  d2.w: nombre de lignes -1
	; a0: adresse
	; Affecte d1-d2/a0-a1
	lea	bmpLineYOffsets,a1
	add.w	d1,d1		; tableau de mots
	move.w	(a1,d1.w),a1	; offset ligne
	adda.l	BmpFb,a1		; frame buffer
	add.w	d0,a1		; ajout x
.lpy	move.l	(a0)+,(a1)+ 
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)	
	lea	160-12(a1),a1
	dbra	d2,.lpy
	rts

BlitShiftUp32_1px
	; D‚place de 1 pixel vers le haut un bloc de 32 de large
	; point‚ par a0, d2.w nombre de lignes-1
	; Attention, ne pas appeler si ‡a fait sortir de l'‚cran !
	; Recopie les 32 pixels dans la ligne du dessus
	; Affecte d0,d2,a0
.lpy	move.l	(a0),-160(a0)
	move.l	4(a0),-156(a0)
	move.l	8(a0),-152(a0)
	move.l	12(a0),-148(a0)
	lea	160(a0),a0
	dbra	d2,.lpy
	; Efface la derniŠre ligne
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	rts

BlitShiftDown32_1px
	; D‚place de 1 pixel en bas un bloc de 32 de large
	; point‚ par a0, d2.w nombre de lignes-1
	; Attention, ne pas appeler si ‡a fait sortir de l'‚cran !
	; Recopie les 32 pixels dans la ligne du dessus
	; Affecte d0,d2
	; Trouve la derniŠre ligne
	lea	bmpLineYOffsets,a2
	move.w	d2,d1
	addq.w	#1,d1		; d2 est nb lignes -1	
	add.w	d1,d1		; tableau de mots
	adda.w	(a2,d1.w),a0	
.lpy	move.l	(a0),160(a0)	; Recopie sur la ligne suivante
	move.l	4(a0),164(a0)
	move.l	8(a0),168(a0)
	move.l	12(a0),172(a0)
	lea	-160(a0),a0
	dbra	d2,.lpy
	; Efface la derniŠre ligne
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
	rts


BlitCalcOffset
	; Calcule l'offset dans la m‚morie ‚cran x,y
	; x doit ˆtre un multiple de 8
	; d0.l: x d1.w: y
	; Affecte d0-d1/a1
	lea	bmpLineYOffsets,a1
	add.w	d1,d1
	add.w	(a1,d1.w),d0
	add.l	BmpFb,d0
	rts
	
Blit16x10	; Blitte le bloc de 16x10 pixels point‚ par a0 vers l'adresse
	; point‚e par a1
	; N'affecte rien
b1610l	SET	0	; Offset de ligne
	REPT	10
	move.l	b1610l(a0),b1610l(a1)
	move.l	b1610l+4(a0),b1610l+4(a1)
b1610l	SET	b1610l+160
	ENDR
	rts
