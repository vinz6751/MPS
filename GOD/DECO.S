; D‚coration de d‚mo avec les "bidules" de STS

DECO_DEBUG EQU 1

	IFNE DECO_DEBUG
	OPT	O+
	OPT	OW+

	move.w	#$2,-(sp)
	trap	#14; Physbase
	addq.l	#2,sp
	move.l	d0,BmpFb

	move.w	#4,-(sp)
	trap	#14; Getrez
	addq.l	#2,sp
	move.w	d0,Rez

	move.w	#0,-(sp) ; ST-basse
	move.l	#-1,-(sp)
	move.l	#-1,-(sp)
	move.	#5,-(sp)
	trap	#14 ; Setscreen
	lea	$c(sp),sp

	pea	start
	move.w	#38,-(sp)
	trap	#14 ; Supexec
	addq.l	#6,sp

	bsr	DecoDeinit

	move.w	Rez,-(sp) ; Restaure r‚solution
	move.l	#-1,-(sp)
	move.l	#-1,-(sp)
	move.	#5,-(sp)
	trap	#14 ; Setscreen
	lea	$c(sp),sp

	clr.w	-(sp)
	trap	#1 ; Pterm0
	
BmpFb	dc.l	0
Rez	dc.w	0
start	bsr.s	DecoInit
	movea.l	BmpFb,a0
	move.l	#55555555,(a0)+
	move.l	#55555555,(a0)
	
.loop	
	move.w	#$0b,-(sp)
	trap	#1 ; Cconis
	addq.l	#2,sp
	tst.w	d0
	beq.s	.cont
	rts

.cont	
	bsr	deco_fantR1
	;bsr.s	DecoAnimation
	bra.s	.loop
	ENDC
	

	SECTION TEXT
DecoInit:		
	lea    decoBidules,a0
	bsr.s  DecoInitListPts
	
	lea    decoPacmanO,a0
	bsr.s  DecoInitListPts
	
	lea    decoPacmanF,a0
	bsr.s  DecoInitListPts
	
	lea    decoFantomes,a0
	bsr.s  DecoInitListPts

	lea    decoPacgommes,a0
	bsr.s  DecoInitListPts

	move.w #20,deco_ralentisseur
	rts

DecoInitListPts
	move.w deco_w(a0),d0
	mulu.w deco_h(a0),d0
	move.w d0,deco_dcnt(a0)
	rts

	
DecoDeinit:
	rts

	
DecoAnimation:
	;bsr.s	deco_fantR1
	
	REPT 1
	lea   decoBidules,a0
	bsr.s decoRender
	ENDR

	move.w deco_ralentisseur,d4
	subq.w #1,d4
	bne.s  .noslow
	move.w #50,d4
	lea   decoPacmanF,a0
	bsr.s DecoInitListPts
	lea   decoPacmanO,a0
	bsr.s DecoInitListPts
.noslow   move.w d4,deco_ralentisseur
	cmpi.w #10,deco_ralentisseur
	bge.s .pacmanO
	lea   decoPacmanF,a0
	bra.s .pacmanset
.pacmanO	lea   decoPacmanO,a0
.pacmanset
	bsr.s decoRender
	
	REPT 1
	lea   decoFantomes,a0
	bsr.s decoRender
	ENDR
	
	REPT 1
	lea   decoPacgommes,a0
	bsr.s decoRender
	ENDR
	
	rts


decoRender; Affiche point par point le truc pass‚ en a0 aux coordonn‚es
	; d0.w,d1.w
	; lit un octet
	; affiche le prochain point
	tst.w  deco_dcnt(a0)
	beq.s  .fin

	move.w deco_i(a0),d3
	move.b deco_data(a0,d3.w),d0
	ext.w  d0
	; ignore les pixels, noirs
	bne.s  .pasnoir
	addq.l #1,d3
	move.w d3,deco_i(a0)
	subi.w #1,deco_dcnt(a0)
	bra.s  decoRender

.pasnoir	move.w deco_x(a0),d1 ; calcule le x et y … ajouter
	move.w deco_y(a0),d2
	move.w d3,d4
	ext.l  d4
	divu.w deco_w(a0),d4
	add.w  d4,d2 ; quotient -> nombre de lignes
	swap   d4
	add.w  d4,d1; reste -> nombre de colonnes

	move.w d1,decoBuf ; rempli buffer pour BmpPixelPutMono
	move.w d2,decoBuf+2; la couleur est d‚j… dans d0
	
	; enregistre le progrŠs
	addq.w #1,d3
	move.w d3,deco_i(a0)
	subi.w #1,deco_dcnt(a0)
	
	; affiche
	lea    decoBuf(pc),a0
	IFNE DECO_DEBUG
	bsr	deco_affiche
	ELSE
	jsr	BmpPixelPutMono
	ENDC

.fin	rts

FANTOME_H	EQU	11 ; hauteur d'un fant“me
deco_fantR1:
	lea 	decoFantR1,a0
	lea	16*FANTOME_H*7(a0),a0 ; taille d'un preshift
	move.l	BmpFb,a1 ; destination
	
	adda.w	#160*179+8*4,a1 ; qqpart sur l'‚cran
	
	lea	16(a1),a1
	REPT	FANTOME_H
	movem.l	(a0)+,d0-d3
	movem.l	d0-d3,-(a1)
	lea	160+16(a1),a1
	ENDR
	rts

	IFNE DECO_DEBUG
deco_affiche
	rts
	ENDC	
decoBuf:	; Buffer pour appel de BmpPixelPutMono
	dc.w 0
	dc.w 0
	dc.w -1
		
	SECTION DATA	
decoPacmanO:
	dc.w 0,189,0,0	
	INCBIN "elite\ppacmano.bmp"
	EVEN
	
decoPacmanF:
	dc.w 0,189,0,0	
	INCBIN "elite\pacmanf.bmp"
	EVEN

decoFantomes:
	dc.w 262,189,0,0	
	INCBIN "elite\pfantome.bmp"
	EVEN

decoBidules:
	dc.w 0,0,0,0
	INCBIN "elite\bidules.bmp"
	EVEN

decoPacgommes:
	dc.w 13,193,0,0
	INCBIN "elite\pacgomme.bmp"
	EVEN

decoFantR1:
	INCBIN "elite\fantomr1.bmp"

	SECTION BSS
	EVEN
deco_ralentisseur ds.w 1
	 rsreset
deco_x     rs.w 1 ; endroit ou rendre le bitmap
deco_y	 rs.w 1
deco_i	 rs.w 1 ; index du point … afficher
deco_dcnt  rs.w 1 ; d‚compteur de points … dessiner
deco_w	 rs.w 1 ; l… commence le fichier inclus 
deco_h	 rs.w 1
deco_data	 rs.b 1
