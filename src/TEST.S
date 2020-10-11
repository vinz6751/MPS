; Test des fonctions de la librairie

; Bidouilles avec la m‚moire vid‚o
	output	f:\bitmap.tos

	SECTION TEXT

	pea	main
	move.w	#$26,-(sp)	;Supexec
	trap	#14
	addq.l	#6,sp

	pea	msg_fin
	move.w	#9,-(sp)
	trap	#1		; Cconws
	addq.l	#6,sp

	clr.w	-(sp)
	trap	#1		; Pterm0


main:	bsr	ScnInit
	bsr	BmpInit
	bsr	InstallePalette
		
	moveq	#0,d0
	bsr	ScnSet
	move.l	ScnFb,BmpFb

X	SET 0
COULEUR	SET	7
	REPT	16
;	REPT	16
	move.l	point,.tmp
	add.w	#X,.tmp
	add.w	#X,.tmp+2
	lea	.tmp,a0
	move.w	#COULEUR,d0
	bsr	BmpPixelPutMono
;COULEUR	SET	COULEUR+1
;	ENDR
X	SET	X+1
	ENDR
	bra.s	.c
.tmp	ds.w	2
.c

;	lea	points,a0
;	move.l	#199,d7
;.loop	move.l	#319,d6
;.fill	move.w	d6,(a0)+
;	move.w	d7,(a0)+
;	dbra	d6,.fill
;	dbra	d7,.loop
;	move.l	#$FFFFFFFF,(a0)
	
;	lea	dessin,a0
;	moveq	#6,d0
;	bsr	BmpPixelPutMono

	lea	dessin,a0
	moveq	#15,d0
	move.w	(a0),d1
	move.w	2(a0),d2
	move.w	4(a0),d3
	move.w	6(a0),d4
	bsr	BmpLine

	
;	moveq	#23,d1
;	moveq	#12,d2
;	move.l	#200,d3
;	moveq	#40,d4
;	moveq	#5,d0	; couleur
;	bsr	BmpLine

	move.l	#20,d7
	move.w	#20,d1
	move.w	#20,d2
	move.w	#15,d3
	move.w	#3,d0
.lo	movem.l	d0-a6,-(sp)	
	bsr	BmpCircle
	movem.l	(sp)+,d0-a6
	add.w	#20,d1
	add.w	#20,d2
	add.w	#5,d3
	dbra	d7,.lo


	move.w	#1,-(sp)	; Cnecin
	trap	#1
	addq.l	#2,sp
	
	bsr	BmpDeinit
	bsr	ScnRestore
	bsr	ScnDeinit
	rts


cls	pea	msg_cls
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	rts

SET_COULEUR	MACRO
	moveq.w	#\1,d0
	moveq.w	#\2,d1
	moveq.w	#\3,d2
	moveq.w	#\4,d3
	bsr	ScnPaletteSetColorRGB3
	ENDM

InstallePalette
	SET_COULEUR	0,6,6,5	; gris clair
	SET_COULEUR	1,0,0,0 ; noir
	SET_COULEUR	2,7,0,0 ; rouge
	SET_COULEUR	3,0,0,7 ; bleu
	SET_COULEUR	4,0,7,0 ; vert
	SET_COULEUR	5,7,7,0 ; jaune 
	SET_COULEUR	6,7,0,7 ; violet
	SET_COULEUR	7,0,5,7 ; 
	SET_COULEUR	8,3,3,3 ; gris moyen
	SET_COULEUR	9,2,0,0 ; rouge sombre
	SET_COULEUR	10,0,2,0 : vert fonc‚
	SET_COULEUR	11,0,0,2 : bleu marine
	rts

	; Librairies
	include	scn.s	; Ecran
	include	bitmap.s	; Dessins bitmap

	SECTION DATA
	EVEN
msg_fin	dc.b	"Termin‚.",0
msg_cls	dc.b	27,'E',0
	EVEN
dessin	dc.w	319,27,50,190,-1
point	dc.w	160,100,-1,160,101,161,100,161,101,-1
	; Donn‚es de test
;points	ds.w	320*200*2+2
