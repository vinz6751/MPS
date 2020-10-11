ALIEN_NB_POINTS	EQU 46	; Nombre de points
ALIEN_L	EQU	11	; Largeur
ALIEN_H	EQU	8	; Hauteur


	SECTION TEXT
AlienInit
	move.w	#0,alienX
	move.w	#0,alienY
	move.w	#1,alienDx
	move.w	#1,alienDy
	move.w	#15,alienClr
AlienDeinit
	rts


AlienAnimation
;	bsr	ScnVsync
	; Efface l'ancienne position
;	bsr	EffaceEcran
	moveq.w	#0,d0 ; couleur	
	move.w	alienX,d1
	move.w	alienY,d2
	bsr	alienDessine
	; Calcule le nouvel alien
	move.w	alienX,d1
	move.w	alienY,d2
	; Bouge l'alien. Ajoute Dx/Dy, rebondit sur les bords de l'‚cran
	add.w	alienDx,d1
	bpl.w	.xminok
	clr.w	d1
	neg.w	alienDx
.xminok	cmpi.w	#X_RES-ALIEN_L-1,d1
	blt.s	.xmaxok
	move.w	#X_RES-ALIEN_L-1,d1
	neg.w	alienDx
.xmaxok	add.w	alienDy,d2
	bpl.w	.yminok
	clr.w	d2
	neg.w	alienDy
.yminok	cmpi.w	#Y_RES-ALIEN_H-1,d2
	blt.s	.ymaxok
	move.w	#Y_RES-ALIEN_H-1,d2
	neg.w	alienDy
.ymaxok	
	move.w	d1,alienX
	move.w	d2,alienY	
	subi.w	#1,alienClr
	bne.s	.clrok
	move.w	#$f,d0	; reset couleur
	move.w	d0,alienClr
.clrok	move.w	alienClr,d0	; Couleur
	bsr	alienDessine
	rts

alienDessine
	; d0.w:couleur, d1.w:x, d2.w:y
	move.w	#ALIEN_NB_POINTS-1,d3 
	lea.l	Alien,a0
	lea.l	.buf,a1
.boucle	move.w	(a0)+,d4
	add.w	d1,d4
	move.w	d4,(a1)+
	move.w	(a0)+,d4
	add.w	d2,d4
	move.w	d4,(a1)+
	dbra	d3,.boucle
	move.w	#-1,(a1)
	lea.l	.buf,a0
	jmp	BmpPixelPutMono	
	SECTION BSS
.buf	ds.w	ALIEN_NB_POINTS+1 ; +1 pour le -1 final
	EVEN

	SECTION DATA
Alien	; Liste de points pour dessiner un alien
	dc.w	2,0,8,0
	dc.w	3,1,7,1
	dc.w	2,2,3,2,4,2,5,2,6,2,7,2,8,2
	dc.w	1,3,2,3,4,3,5,3,6,3,8,3,9,3
	dc.w	0,4,1,4,2,4,3,4,4,4,5,4,6,4,7,4,8,4,9,4,10,4
	dc.w	0,5,2,5,3,5,4,5,5,5,6,5,7,5,8,5,10,5
	dc.w	0,6,2,6,8,6,10,6
	dc.w	3,7,4,7,6,7,7,7
	dc.w	-1

	SECTION BSS
alienX	ds.w	1
alienY	ds.w	1
alienDx	ds.w	2
alienDy	ds.w	2
alienClr ds.w	1

