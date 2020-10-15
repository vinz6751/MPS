; Scroll

; Ca va fonctionner de la maniŠre suivante:
; A chaque it‚ration, on lit la colonne de pixel suivante du caractŠre
; courant en train d'apparaŒtre en base … droite, et on la blitte en bas
; … droite. Puis on d‚cale tout la r‚gion scrolltext d'un cran

FONT_W	EQU	16
FONT_H	EQU	10

	SECTION TEXT

ScrollInit	
	bsr	scrollPrepCar	
	movea.l	BmpFb,a4
	lea	scrollBuf,a3
	moveq	#9,d3
.lp	move.l	(a3)+,(a4)
	move.l	(a3)+,4(a4)
	adda.l	#160,a4
	dbra	d3,.lp
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
	
	; D‚compteur de pixel et chargement du prochain caractŠre
	subi.w	#1,scrollPix
	bne.s	.scroll
	; Charge nouveau caractŠre dans scrollBuf
	move.w	#FONT_W-1,scrollPix
	bsr	scrollPrepCar
	
.scroll	lea	scrollBuf,a1
	movea.l	BmpFb,a3
	adda.l	#160*(Y_RES-1-FONT_H),a3
	moveq	#FONT_H-1,d3
.boucle	;movea.l	a2,a3
	; plan 0
	lsl.w	(a1)+	; r‚cupŠre bit du plan 0
sxo	SET	152 ; scroll x offset
	REPT	20
	roxl	sxo(a3)	; insŠre en pixel 15 plan0 dernier chunk de ligne et d‚cale toute la ligne
sxo	SET	sxo-8	; chunk pr‚c‚dent
	ENDR
	; plan 1
	lsl.w	(a1)+	; r‚cupŠre bit du plan 1
sxo	SET	154 ; scroll x offset
	REPT	20
	roxl	sxo(a3)	; insŠre en pixel 15 plan0 dernier chunk de ligne et d‚cale toute la ligne
sxo	SET	sxo-8	; chunk pr‚c‚dent
	ENDR
	; plan 2
	lsl.w	(a1)+	; r‚cupŠre bit du plan 2
sxo	SET	156 ; scroll x offset
	REPT	20
	roxl	sxo(a3)	; insŠre en pixel 15 plan0 dernier chunk de ligne et d‚cale toute la ligne
sxo	SET	sxo-8	; chunk pr‚c‚dent
	ENDR
	; plan 4
	lsl.w	(a1)+	; r‚cupŠre bit du plan 0
sxo	SET	158 ; scroll x offset
	REPT	20
	roxl	sxo(a3)	; insŠre en pixel 15 plan0 dernier chunk de ligne et d‚cale toute la ligne
sxo	SET	sxo-8	; chunk pr‚c‚dent
	ENDR

	lea	160(a3),a3
	dbra	d3,.boucle

	rts
.ralentisseur	dc.w	$32


scrollPrepCar
	; Pr‚pare le prochain caractŠre du scrolltext
	movea.l	scrollCar,a0
	move.b	(a0)+,d2 	; caractŠre … afficher
	bne.s	.carOk
	movea.l	#scrollMessage,a0 ; reset du message
.carOk	move.l	a0,scrollCar
	cmpi.b	#'A',d2
	blt.s	.pasAlpha
	cmpi.b	#'Z',d2
	bgt.s	.pasAlpha
	lea	scrollFont+34,a0
	; Trouve l'adresse de la cellule
	andi.w	#$00ff,d2
	subi.w	#'A',d2
	cmpi.w	#20,d2	; on a 20 caractŠres sur la premiŠre ligne de fonte
	blt.s	.ligne1
	adda.w	#FONT_H*160,a0 ; pointe sur 2Šme ligne
.ligne1	lsl.w	#3,d2	; cellules font  de large
	add.w	d2,a0
	bra.s	.blitc

.pasAlpha	lea	scrollFont+34+FONT_H*160*3,a0 ; pointe sur du vide
	
.blitc	; Copie le caractŠre dans le buffer
	lea.l	scrollBuf,a1
offset	SET	0
	REPT	FONT_H
	move.l	offset(a0),(a1)+
	move.l	offset+4(a0),(a1)+
offset	SET	offset+160	
	ENDR
	rts	

ScrollGetCarBitmap
	; Trouve la bitmap pour le caractŠre pass‚ en d6.w
	; et retourne en a6
	; Affecte d6,a6
	lea	scrollFont+160,a6 ; skip ligne rouge. D‚faut=premier caractŠre
	cmpi.b	#'A',d6	
	blt.s	.fin
	cmpi.b	#'Z',d6
	bgt.s	.fin
	lsr.w	#4,d6	; num‚ro de caractŠre -> offset dans table (chaque car fait 4mots)
	lea	(a6,d6.w),a6
	move.l	a6,scrollCarBmp
.fin	rts


Scroller
	; 8pixels par it‚ration
	movea	BmpFb,a4
	adda.l	#FBSIZE+FONT_H*160,a4
	moveq	#FONT_H-1,d4
sx	SET	152	; les 8 derniers sont l… ou on insŠre
.bcl	REPT	20	; 
	roxl	sx(a4)
sx	SET	sx-8
	ENDR
	lea	160(a4),a4	; ligne suivante
	dbra	d4,.bcl
	rts
	
	
	SECTION DATA
scrollMessage	dc.b 	"CECI EST UN MESSAGE A SCROLLER OK CE N EST PAS TOP MAIS C EST MON PREMIER ECRAN      MPS POWER     ",0
	EVEN
scrollFont	INCBIN	font\font2bis.pi1

	EVEN
scrollCar	dc.l scrollMessage 	; pointeur vers caractŠre courant
scrollPix	dc.w FONT_W-1	; d‚compteur de colonne de cellule … afficher
	
	SECTION BSS
scrollCarBmp	ds.l 1 	; Pointeur vers l'image du caractŠre … afficher

scrollBuf		ds.b	FONT_W*FONT_H ; buffer ou on d‚cale les bits du caractŠre … afficher
	SECTION TEXT

