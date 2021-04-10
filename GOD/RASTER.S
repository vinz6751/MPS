RASTER_DEBUG	EQU	0
HBL		EQU	$120

rasterCouleurP EQU	$502 ;On utilise qqchose bas en RAM pour pouvoir
		     ;ne transf‚rer que des word et b‚n‚ficier
		     ;de l'extension de signe
	IFNE	RASTER_DEBUG
VBL	EQU	$70

	;Programme d'essai
main	pea	.efface_ecran
	move.w	#9,-(sp)
	trap	#1	;Cconws
	addq.l	#6,sp
	
	pea	.main
	move.w	#38,-(sp)
	trap	#14	;Supexec
	addq.l	#6,sp
	clr.w	-(sp)
	trap	#1	;Pterm0

.main	bsr	RasterInit
	clr.w	$ffff8240.w
	move.l	VBL.w,.oldVbl
	move.l	#RasterVbl,VBL.w

.boucle	move.l	#$00020002,-(sp)
	trap	#13
	addq.l	#4,sp
	tst.w	d0
	bne	.quitte
	
	;bsr	RasterAnimation
	bra	.boucle


.quitte	move.l	oldHbl(pc),HBL.w
	move.l	.oldVbl(pc),VBL.w
	bsr	RasterDeinit
	move.w	#-1,$ffff8240
	rts

.efface_ecran dc.b 27,'E',0
	EVEN
.oldVbl	ds.l 1
	ENDC


RasterInit
	; Calcule le d‚grad‚
	move.l	#rasterCouleurs,rasterCouleurP.w
	lea	rasterCouleurs,a3
	move.w	#$0112,(a3)+
	clr.w	(a3)+

	; Installe vecteur HBL
	move.l	HBL.w,oldHbl
	move.l	#RasterHbl,HBL.w
	; Active les interruptions HBL
	rts
oldHbl	ds.l 1


RasterDeinit
	move.b 	#0,$fffffa1b.w 	;Timer B stop
	andi.b	#-2,$fffffa07.w	;d‚sactive HBL
	move.l	oldHbl,HBL.w
	rts


RasterVbl	clr.w	$ffff8240.w
	move.l	#rasterCouleurs,rasterCouleurP
	ori.b	#1,$fffffa07.w ; enable HBL	
	ori.b	#1,$fffffa13.w ; unmask HBL	
	move.b 	#60,$fffffa21.w ; Timer B data : Counter value
	move.b 	#8,$fffffa1b.w ; Timer B start : Event count mode
	IFEQ	RASTER_DEBUG
	rts
	ELSE
	rte
	ENDC


RasterHbl	move.l	a5,-(sp)
	move.l	rasterCouleurP.w,a5
	move.w	(a5)+,$ffff8240.w
	beq.s	.stopHbl
	bne.s	.cont
	move.l	#rasterCouleurs,a5
.cont	move.l	a5,rasterCouleurP.w
	movea.l	(sp)+,a5
	move.b 	#0,$fffffa1b.w 	;Timer B stop
	move.b 	#90,$fffffa21.w 	;Timer B data : Counter value
	move.b 	#8,$fffffa1b.w 	;Timer B start : Event count mode
	bclr 	#0,$fffffa0f.w 	; acknowledge interrupt Timer B
	rte
.stopHbl	bclr	#0,$fffffa07.w	; disable HBL
	move.b 	#0,$fffffa1b.w 	;Timer B stop
	bclr 	#0,$fffffa0f.w 	; acknowledge interrupt Timer B
	movea.l	(sp)+,a5
	rte


rasterCouleurs: ;Liste des couleurs pour chaque ligne. 0 marque la fin
	ds.w 200+1