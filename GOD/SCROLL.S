; Scroll

; Ca va fonctionner de la maniŠre suivante:
; A chaque it‚ration, on lit la colonne de pixel suivante du caractŠre
; courant en train d'apparaŒtre en base … droite, et on la blitte en bas
; … droite. Puis on d‚cale tout la r‚gion scrolltext d'un cran

FONTE_W	EQU	16
FONT_H	EQU	10

	SECTION TEXT

ScrollInit
	rts

ScrollDeinit
	rts

ScrollAnimation
	bsr	Scroller
	rts

	move.b	ScrollPix,d5

	addq.b	#1,d5	; Colonne suivante dans le bitmap du caractŠre
	andi.b	#$f,d5	; Fonte fait 16px de large
	bne.s	.pasNouveauCar
.nouveauCar	; Nouveau caractŠre, r‚cupŠre les infos pour prochaine it‚ration
	movea.l	ScrollCar,a6
	addq.l	#1,a6		; addresse caractŠre suivant
	move.l	a6,ScrollCar
	clr.l	d6
	move.b	(a6),d6		; d6: caractŠre … afficher
	bsr	ScrollGetCarBitmap ; r‚cup bitmap char … afficher dns a6
	;bsr	ScrollBlitCar
	
.pasNouveauCar
	move.b	d5,ScrollPix

	rts


ScrollGetCarBitmap
	; Trouve la bitmap pour le caractŠre pass‚ en d6.w
	; et retourne en a6
	; Affecte d6,a6
	lea	ScrollFont+160,a6 ; skip ligne rouge. D‚faut=premier caractŠre
	cmpi.b	#'A',d6	
	blt.s	.fin
	cmpi.b	#'Z',d6
	bgt.s	.fin
	lsr.w	#4,d6	; num‚ro de caractŠre -> offset dans table (chaque car fait 4mots)
	lea	(a6,d6.w),a6
	move.l	a6,ScrollCarBmp
.fin	rts


Scroller
	; 8pixels par it‚ration
	movea	BmpFb,a4
	adda.l	#(199-FONT_H)*160,a4
	moveq	#FONT_H-1,d4
sx	SET	152	; les 8 derniers sont l… ou on insŠre
.bcl	REPT	20	; 
	roxl	sx(a4)
sx	SET	sx-8
	ENDR
	lea	160(a4),a4	; ligne suivante
	dbra	d4,.bcl
	rts


ScrollBlitCar
	; Blitte la colonne d5 du caractŠre 16x10 point‚ par a6 
	; au point d'insertion du scrolltext (c…d bord bas droit-hauteur fonte)
	movea	BmpFb,a4
	moveq	#FONT_H-1,d3
	adda.l	#320*200-160*FONT_H-16,a4
.bcllin	
.bpl0	btst	d5,(a6)	; Plan 0
	beq.s	.blc0
	bset	#0,-8(a4)
	bra.s	.bpl1
.blc0	bclr	#0,-8(a4)

.bpl1	btst	d5,2(a6)	; Plan 1
	beq.s	.blc1
	bset	#0,-6(a4)
	bra.s	.bpl1
.blc1	bclr	#0,-6(a4)

.bpl2	btst	d5,4(a6)	; Plan 2
	beq.s	.blc2
	bset	#0,-4(a4)
	bra.s	.bpl1
.blc2	bclr	#0,-4(a4)

.bpl3	btst	d5,(a6)		; Plan 3
	beq.s	.blc3
	bset	#0,-2(a4)
	bra.s	.finbcl
.blc3	bclr	#0,-2(a4)

.finbcl	lea	160(a6),a6	; Ligne suivante
	dbra	d3,.bcllin

.fin	rts		

	
	
	SECTION DATA
ScrollMessage	dc.b 	"CECI EST UN MESSAGE A SCROLLER",0
	EVEN
ScrollFont	;INCBIN	grenier\font.pi1

	EVEN
ScrollCar	dc.l	ScrollMessage ; pointeur vers caractŠre courant
ScrollPix	dc.l 0 	; colonne … afficher
	
	SECTION BSS
ScrollCarBmp	ds.l 1 	; Pointeur vers l'image du caractŠre … afficher

	SECTION TEXT

