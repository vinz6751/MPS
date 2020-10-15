; Scroll text pour fonte de 16 pixels de large
; On stocke le caractäre Ö afficher dans un array de words.
; Ensuite Ö chaque itÇration on dÇcale chaque plan d'un bit et on
; l'insäre avec un rol sur le plan du dernier chunk de la ligne
; puis on roll tout le reste de proche en proche.
; Vinz / MPS Octobre 2020

FONT_W	EQU	16
FONT_H	EQU	10
FONTL2	EQU	(FONT_H-2)*160 ; 2äme ligne de la fonte
FONTL3	EQU	(FONT_H-1)*160*2 ; 3äme ligne de la fonte

	SECTION TEXT

ScrollInit	
ScrollDeinit
	rts

ScrollAnimation
	; Ralentisseur
	move.w	.ralentisseur,d7
	bne.s	.attend
	move.w	#2,.ralentisseur
	bra.s	.do	
		
.attend	subi.w	#1,.ralentisseur
	rts
.do
	
	; DÇcompteur de pixel et chargement du prochain caractäre
	subi.w	#1,scrollPix
	bne.s	.scroll
	; Charge nouveau caractäre dans scrollBuf
	move.w	#FONT_W-1,scrollPix
	bsr	scrollPrepCar
	
.scroll	lea	scrollBuf,a1
	movea.l	BmpFb,a3
	adda.l	#160*(Y_RES-1-FONT_H),a3
	moveq	#FONT_H-1,d3
.boucle	;movea.l	a2,a3
	; plan 0
	lsl.w	(a1)+	; rÇcupäre bit du plan 0
sxo	SET	152 ; scroll x offset
	REPT	20
	roxl	sxo(a3)	; insäre en pixel 15 plan0 dernier chunk de ligne et dÇcale toute la ligne
sxo	SET	sxo-8	; chunk prÇcÇdent
	ENDR
	; plan 1
	lsl.w	(a1)+	; meme chose plan 1
sxo	SET	154
	REPT	20
	roxl	sxo(a3)
sxo	SET	sxo-8
	ENDR
	; plan 2
	lsl.w	(a1)+	; meme chose plan 2
sxo	SET	156
	REPT	20
	roxl	sxo(a3)
sxo	SET	sxo-8
	ENDR
	; plan 4
	lsl.w	(a1)+	; meme chose plan 3
sxo	SET	158
	REPT	20
	roxl	sxo(a3)
sxo	SET	sxo-8
	ENDR

	lea	160(a3),a3 ; ligne suivante
	dbra	d3,.boucle

	rts
.ralentisseur	dc.w	$32


scrollPrepCar
	; PrÇpare le prochain caractäre du scrolltext
	movea.l	scrollCar,a0
	move.b	(a0)+,d2 	; caractäre Ö afficher
	bne.s	.carOk
	movea.l	#scrollMessage,a0 ; reset du message
.carOk	move.l	a0,scrollCar
	lea	scrollFont+34,a0
	cmpi.b	#'A',d2
	blt.s	.pasAlpha
	cmpi.b	#'Z',d2
	bgt.s	.pasAlpha
.alpha	; Trouve l'adresse de la cellule
	andi.w	#$00ff,d2
	subi.w	#'A',d2
	cmpi.w	#19,d2	; on a 20 caractäres sur la premiäre ligne de fonte
	ble.s	.ligne1
	adda.w	#FONTL2,a0 ; pointe sur 2äme ligne
.ligne1	lsl.w	#3,d2	; cellules font 2longs de large
	add.w	d2,a0
	bra.s	.blitc

.pasAlpha	
.point	cmpi.b	#'.',d2
	bne.s	.virgule
	lea.l	FONTL2+160+16*8(a0),a0	
	bra.s	.blitc
.virgule	cmpi.b	#',',d2
	bne.s	.tiret
	lea.l	FONTL2+160+17*8(a0),a0
	bra.s	.blitc
.tiret	cmpi.b	#'-',d2
	bne.s	.exclam
	lea.l	FONTL2+160+18*8(a0),a0
	bra.s	.blitc
.exclam	cmpi.b	#'!',d2
	bne.s	.apostrof
	lea.l	FONTL2+160+19*8(a0),a0
	bra.s	.blitc
.apostrof	cmpi.b	#$27,d2
	bne.s	.interrog
	lea.l	FONTL3(a0),a0
	bra.s	.blitc
.interrog	cmpi.b	#'?',d2
	bne.s	.inconnu
	lea.l	FONTL3+8(a0),a0
	bra.s	.blitc
.inconnu
	lea	scrollFont+34+FONT_H*160*3,a0 ; pointe sur du vide
	
.blitc	; Copie le caractäre dans le buffer
	lea.l	scrollBuf,a1
offset	SET	0
	REPT	FONT_H
	move.l	offset(a0),(a1)+
	move.l	offset+4(a0),(a1)+
offset	SET	offset+160	
	ENDR
	rts		
	
	SECTION DATA
scrollMessage	dc.b "ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-!'? CECI EST UN MESSAGE A SCROLLER ! BON C'EST PAS TOP MAIS C'EST MON PREMIER ECRAN !! MPS POWER !!   ",0
	EVEN
scrollFont	INCBIN	font\font3.pi1

	EVEN
scrollCar	dc.l scrollMessage 	; pointeur vers caractäre courant
scrollPix	dc.w FONT_W-1	; dÇcompteur de colonne de cellule Ö afficher
	
	SECTION BSS
scrollCarBmp	ds.l 1 		; pointeur vers l'image du caractäre Ö afficher
scrollBuf		ds.b FONT_W*FONT_H 	; buffer ou on dÇcale les bits du caractäre Ö afficher
	SECTION TEXT

