Intro	
;	move.w	#20000,d7
;.waiter	nop
;	dbra	d7,.waiter
	
	move.w	.rayon(pc),d3
	addi.w	#1,d3
	cmp.b	#99,d3
	ble.s	.cont
	rts
.cont	move.w	d3,.rayon
	move.w	#160,d1 ; x
	move.w	#100,d2 ; y
	move.w	.couleur(pc),d0
	addq.w	#1,d0
	cmpi.w	#11,d0 ; on a 10 couleurs
	bne.s	.noclrwrp
	moveq	#1,d0
.noclrwrp move.w	d0,.couleur
	jsr	BmpCircle
	
	; efface un cercle int‚rieur
	move.w	.rayon(pc),d3
	subi.w	#20,d3
	bmi.s	.pasassezgrand
	move.w	#160,d1
	move.w	#100,d2
	clr.w	d0
	jsr	BmpCircle	
.pasassezgrand
	
	bsr.s	.palcopie
	bra.s	Intro
.rayon	dc.w	0
.couleur	dc.w	0
.palette	dc.w	$101,$202,$313,$414,$525,$626,$737,$747,$757,$767,$777
.palfin
.paldeb	dc.l	.palette+2 ; addresse de d‚but de copie de la palette

.palcopie	; copie la palette vers palrot en commen‡ant par l'index paldeb
	movea.l	.paldeb(pc),a3
	movea.l	a3,a4 ; calcule d‚but de palette pour le prochain coup
	adda.w	#2,a4
	cmpa.l	#.palfin,a4
	bne.s	.nodebwrp
	lea	.palette+2,a4
.nodebwrp	move.l	a4,.paldeb
	; copie la palette vers les registres de couleur du shifter
	moveq     #10-1,d4 ; nombre de couleurs dans la palette
	lea	$ffff8242.w,a5
.palcopy	move.w	(a3)+,(a5)+
	cmpa.l	#.palfin,a3
	bne.s	.nopalwrp
	lea	.palette+2,a3
.nopalwrp	dbra	d4,.palcopy
	rts
	
.finintro