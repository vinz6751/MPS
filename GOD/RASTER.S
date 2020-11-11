RasterInit
	move.w	#16,rasterCouleur
	move.w	#0,rasterLigne
	move.w	#50,rasterDiviseur
	rts
	
RasterDeinit
	rts

RasterAnimation
	subi.w	#1,rasterDiviseur
	bne.s	.fin
	move.w	#50,rasterDiviseur
			

	; Initialisation
	; Efface ligne
	clr.w	d1	; noir
	move.w	rasterLigne,d0
	bsr	LigneHorizontale
	
.boucle	move.w	rasterCouleur,d1
	subq.w	#1,d1
	bne.s	.colOk
.resetCol	moveq.w	#15,d1
.colOk	move.w	d1,rasterCouleur

	move.w	rasterLigne,d0
	addq.w	#1,d0
	cmpi.w	#10,d0
	bne.s	.wrapl
	clr.w	d0
.wrapl	move.w	d0,rasterLigne

	bsr	LigneHorizontale
.fin	rts	
	SECTION DATA
rasterCouleur	ds.w	1	
rasterLigne	ds.w	1
rasterDiviseur	ds.w	1
	SECTION TEXT	
LigneHorizontale
	; Ligne horizontale traversant tout l'‚cran. On charge un chunk
	; dans un registre et aprŠs on copie dans plusieurs registres
	; pour utiliser movem
	; d0.w: y, d1.w: couleur
	lea	bmpLineYOffsets,a3 ; Obtient adresse de la ligne
	addq.w	#1,d0	; Ligne suivante (… cause pr‚d‚cr‚mentation du movem)
	add.w	d0,d0	; Offsets sont des mots
	movea.w	(a3,d0.w),a3
	adda.l	ScnFb,a3	
	lea	ChunkCouleur,a2 ; R‚cup‚ration du chunk couleur
	lsl.w	#3,d1	; Facteur d'‚chelle
	move.l	(a2,d1.w),d2
	move.l	d2,d3
	move.l	d2,d4
	move.l	d2,d5
	move.l	d2,d6
	REPT	FBSIZE/YRES/5/4 ; 5 registres de 4 octets utilis‚s
	movem.l	d2-d6,-(a3)
	ENDR	
	rts


	SECTION DATA
ChunkCouleur ; 4 pixels de la mˆme couleur d'un chunk
	dc.w 0,0,0,0
	dc.w 0,0,0,-1
	dc.w 0,0-1,0
	dc.w 0,0,-1,-1
	dc.w 0,-1,0,0
	dc.w 0,-1,0,-1
	dc.w 0,-1,-1,0
	dc.w 0,-1,-1,-1
	dc.w -1,0,0,0
	dc.w -1,0,0,-1
	dc.w -1,0-1,0
	dc.w -1,0,-1,-1
	dc.w -1,-1,0,0
	dc.w -1,-1,0,-1
	dc.w -1,-1,-1,0
	dc.w -1,-1,-1,-1
