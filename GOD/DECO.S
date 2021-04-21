; D‚coration de d‚mo avec les "bidules" de STS

DECO_DEBUG EQU 0

	IFNE DECO_DEBUG
	OPT	O+
	OPT	OW+
	ENDC

	SECTION TEXT
DecoInit:	
	lea    decoBidules,a0
	bsr.s  .initDeco
	
	lea    decoPacmanO,a0
	bsr.s  .initDeco
	
	lea    decoFantomes,a0
	bsr.s  .initDeco

	lea    decoPacgommes,a0
	bsr.s  .initDeco

	IFNE DECO_DEBUG
.quit	bsr.s DecoDeinit
 	clr.w -(sp)
	trap #1	
	ENDC
	rts
.initDeco	move.w deco_w(a0),d0
	mulu.w deco_h(a0),d0
	move.w d0,deco_dcnt(a0)
	rts

	
DecoDeinit:
	rts

	
DecoAnimation:	
	REPT 4
	lea   decoBidules,a0
	bsr.s decoRender
	ENDR
	
	REPT 1
	lea   decoPacmanO,a0
	bsr.s decoRender
	ENDR
	
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
	bsr.s	deco_affiche
	ELSE
	jsr	BmpPixelPutMono
	ENDC

.fin	rts

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
	
; decoPacmanF:	INCBIN "elite\pacmanf.bmp"
	EVEN

decoFantomes:
	dc.w 262,189,0,0	
	INCBIN "elite\pfantome.bmp"
	EVEN

decoBidules:
	dc.w 6,2,0,0
	INCBIN "elite\bidules.bmp"
	EVEN

decoPacgommes:
	dc.w 13,193,0,0
	INCBIN "elite\pacgomme.bmp"
	EVEN

	SECTION BSS
	EVEN
	 rsreset
deco_x     rs.w 1 ; endroit ou rendre le bitmap
deco_y	 rs.w 1
deco_i	 rs.w 1 ; index du point … afficher
deco_dcnt  rs.w 1 ; d‚compteur de points … dessiner
deco_w	 rs.w 1 ; l… commence le fichier inclus 
deco_h	 rs.w 1
deco_data	 rs.b 1
