; Affichage de texte de la fonte 16x10
TEXTE_DEBUG EQU 1

	SECTION TEXT
	
TexteInit:
	clr.w	TxtFini
	move.w	ElitePalette,FlashBg
	move.l 	BmpFb,a0
	move.w	#0,txtC
	move.w	#5,txtL
	moveq 	#1,d0
	lea	texte,a4
	bsr.s	putString

.wait	; attend TxtFini
	IFNE TEXTE_DEBUG
	Cconis
	tst.w	d0
	beq.s	.wait
	Cnecin
	bsr	MusiqueZKey
	ENDC

	bsr	MusiqueZ
	tst.w	TxtFini
	beq.s	.wait
	bsr	ScnEfface

	rts

putString ; affiche la chaŒne (num‚ros de cellule) en a4
	move.b	(a4)+,d0
	cmpa.l	#textefin,a4
	beq.s	.fin
	cmp.b	#-2,d0; LF
	bne.s	.paslf
	clr.w	txtC
	addq.w	#1,txtL
.paslf	cmp.b	#-3,d0 ; CR
	beq.s	putString ; ignore
	bsr.s	putChar
	move.l	#5,d0
	; n'attend pas aprŠs les espaces
	move.b	-1(a4),d0
	cmpi.b	#$2a,d0
	beq.s	.nowait
	moveq	#50,d0
	bsr	Attend
	
.nowait	bra.s	putString
.fin	rts

	
putChar	; affiche le num‚ro de cellule d0 aux coordonn‚es txtL,txtC
	move.w	txtC,d1
	lsl.w	#3,d1 ; cellules font 16 de large
	move.w	txtL,d2
	mulu.w	#10*160,d2 ; on pourrait utiliser aussi bmpLineYOffsets mais bon...
	move.l	BmpFb,a0
	adda.w	d1,a0
	adda.w	d2,a0
	addq.w	#1,txtC
	cmpi.w	#20,txtC
	blo.s	.nowrap
	clr.w	txtC
	addq.w	#1,txtL
.nowrap


blitChar: ; blitte la cellule d0 de la fonte … l'adresse ‚cran a0
	lea scrollFont,a1
	move.w	d0,d2
	add.w	d2,d2
	add.w	d2,d2
	lea	scrollFntIndex,a2
	movea.l	(a2,d2.w),a1

	REPT	10
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	lea	160-8(a0),a0
	ENDR	

	rts	


Attend	; Attend
	mulu.w	#1000,d0
.wait	subq.l	#1,d0
	bne	.wait
	rts

	SECTION DATA	
; la police s'appelle scrollFont
texte	INCBIN introtxt.bin
textefin
		
	SECTION BSS
txtL	ds.w	1 ; num‚ro de ligne
txtC	ds.w	1 ; num‚ro de colonne
TxtFini	ds.w	1 ; mis … 1 par Z