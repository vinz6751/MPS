RASTER_DEBUG	EQU	0


; D‚finitions
HBL		EQU	$120


; Configuration
CENTRE_HAUT	EQU	70
CENTRE_BAS	EQU	90	


; Programme de d‚bug
	IFNE	RASTER_DEBUG
VBL	EQU	$70

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
	; Sauve vecteur HBL
	move.l	HBL.w,oldHbl
	rts
oldHbl	ds.l 1


RasterDeinit
	move.b 	#0,$fffffa1b.w 	;Timer B stop
	andi.b	#-2,$fffffa07.w	;d‚sactive HBL
	move.l	oldHbl,HBL.w
	rts


RasterVbl	; r‚initialise le raster
	move.w	#$101,$ffff8240.w	
	move.l	#rasterHblMilieu,HBL.w
	ori.b	#1,$fffffa07.w ; enable HBL	
	ori.b	#1,$fffffa13.w ; unmask HBL	
	move.b 	#CENTRE_HAUT,$fffffa21.w ; Timer B data : Counter value
	move.b 	#8,$fffffa1b.w ; Timer B start : Event count mode
	IFEQ	RASTER_DEBUG
	rts
	ELSE
	rte
	ENDC

rasterHblMilieu
	clr.w	$ffff8240.w	;noir
	move.b 	#0,$fffffa1b.w 	;stoppe Timer B
	move.b 	#CENTRE_BAS,$fffffa21.w 	;valeur compteur Timer B
	move.b 	#8,$fffffa1b.w 	;commence … compter les ‚vŠnements
	bclr 	#0,$fffffa0f.w 	;fin interruption Timer B
	move.l	#rasterHblBas,HBL.w
	rte

rasterHblBas
	move.w	#$101,$ffff8240.w	;remet la couleur du fond
	bclr	#0,$fffffa07.w	;d‚sactive HBL
	move.b 	#0,$fffffa1b.w 	;stoppe Timer B
	bclr 	#0,$fffffa0f.w 	;fin interruption Timer B
	rte