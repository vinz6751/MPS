	SECTION TEXT
INTRO_GRADS	EQU 10 ; nombre de couleurs du gradient


Intro	
	bsr	ScnEfface
	jsr	IntroAlienInit

.lpintro	

	tst.w	cercle_fin
	bne.s	.skipcercle
	bsr.s	cercleAnimation
.skipcercle

	tst.w	AlienFin
	bne.s	.skipAlien
	bsr	IntroAlienAnimation
.skipAlien

	move.w	cercle_fin,d0
	add.w	AlienFin,d0
	cmp.w	#-2,d0
	beq.s	.flash

.cont
	move.w	#10000,d7
.waiter	nop
;	dbra	d7,.waiter
	
	bra.s	.lpintro

.flash	lea	$ffff8240.w,a0
	move.w	#$777,(a0)
.flashlp	move.w	#5000,d7
.flashwt	divs	#1234,d0
	dbra	d7,.flashwt
	subi.w	#$777/7,(a0)
	bgt.s	.flashlp
	
	
;	bsr	pause
	rts	
cercle_fin dc.w	0 ; signale la fin de l'animation du cercle
	

cercleAnimation
	; Calcule le rayon … dessiner
	move.w	.rayon(pc),d3
	addi.w	#1,d3
	cmp.b	#99,d3
	ble.s	.cont
	move.w	#-1,cercle_fin ; signale la fin de l'animation
	rts

.cont	move.w	d3,.rayon

	; Dessine le cercle exterieur
	move.w	#160,d1 ; x
	move.w	#100,d2 ; y
	move.w	.blanc(pc),d0
	jsr	BmpCircle
	
	; Efface un cercle int‚rieur pour que ‡a fasse un anneau
	move.w	.rayon(pc),d3
	subi.w	#INTRO_GRADS,d3
	bmi.s	.pasassezgrand
	move.w	#160,d1
	move.w	#100,d2
	clr.w	d0
	jsr	BmpCircle	
.pasassezgrand

	bsr.s	.palcopie
	rts
.rayon	dc.w	0
.couleur	dc.w	0
.palette  dc.w      $101,$777,$767,$757,$747,$737,$626,$525,$414,$313,$202
.palfin
.paldeb	dc.l	.palette+2 ; addresse de d‚but de copie de la palette
.blanc	dc.w	1 ; num‚ro de couleur repr‚sentant le blanc
.palcopie	; copie la palette vers palrot en commen‡ant par l'index paldeb
	movea.l	.paldeb(pc),a3
	; calcule d‚but de palette pour le prochain coup
	movea.l	a3,a4
	adda.w	#2,a4
	cmpa.l	#.palfin,a4
	bne.s	.nodebwrp
	lea	.palette+2,a4
.nodebwrp	move.l	a4,.paldeb
	; calcule prochaine couleur r‚pr‚sentant le blanc (d‚but du gradient)
	move.w	.blanc(pc),d4
	subq.w	#1,d4
	bgt.s	.noblcwrp
	move.w	#INTRO_GRADS,d4	
.noblcwrp	move.w	d4,.blanc
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

	INCLUDE	alien2.s
