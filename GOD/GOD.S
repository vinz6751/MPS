	OUTPUT 	f:\MPS\GOD\GOD.TOS

	OPT	P=68000;
;	OPT	O+
;	OPT	OW-

	INCLUDE	macros.i

	; D‚finitions mat‚rielles
VBL		EQU	$70
KBD_VECS		EQU	$118
KBD_ACIA_CTRL	EQU	$fffffc00
KBD_ACIA_DATA	EQU	$fffffc02

XRES	EQU	320
YRES	EQU	200
FBSIZE	EQU	32000


	; Pr‚f‚rences
DEBUG	EQU	1
CLIPPING	EQU 	0 ; Dans bitmap.s

	SECTION TEXT
_main	
	IFNE	DEBUG
	KbdFlush
	Supexec	Main
	Pterm0	

Main	move.l	sp,OldStack
	SauvePalette OldPalette
	ENDC

	; Initialise l'‚cran
	lea	Stack,sp
	bsr	ScnInit
	bsr	BmpInit

	; Passe en basse r‚solution
	clr.w	d0
	lea	Fb,a0
	bsr	ScnSet	

	; Fixe l'adresse logique pour le dessin
	move.l	ScnFb,BmpFb

	RestaurePalette ElitePalette
	bsr	VblInstalle
;	bsr	KbdInstalle
	bsr	MusiqueInit
	bsr	ScnEfface
	bsr	AlienInit
	bsr	EliteInit
	bsr	ScrollInit

	clr.w	FlagQuitter
BouclePrincipale
	Bconstat2
;	tst.w	FlagQuitter
	bne.s	.quitte

;	bsr	ScnEfface
;	bsr	AlienAnimation
	bsr	EliteAnimation
	bsr	ScrollAnimation
;	bsr	AnimationRaster		

	bra.s	BouclePrincipale

.quitte		
	IFNE	DEBUG
	bsr	ScrollDeinit
;	bsr	AlienDeinit
;	bsr	KbdDesinstalle
	bsr	VblDesinstalle
	bsr	ScnRestore
	bsr	ScnDeinit
	RestaurePalette OldPalette
	move.l	OldStack,sp
	ENDC

	rts	 ; Retour de la fonction principale


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


	SECTION TEXT

	
AnimationRaster
	; Initialisation
	move.w	#16,.couleur
	move.w	#-1,.ligne
	
.boucle	move.w	.couleur,d1
	subq.w	#1,d1
	bne.s	.colOk
.resetCol	moveq.w	#15,d1
.colOk	move.w	d1,.couleur

	move.w	.ligne,d0
	addq.w	#1,d0
	cmp.w	#YRES-1,d0
	beq.s	.fin
	move.w	d0,.ligne

	bsr	LigneHorizontale
	bra.s	.boucle
.fin	rts	
	SECTION DATA
.couleur	ds.w	1	
.ligne	ds.w	1
	SECTION TEXT	


VblInstalle
	move.l	VBL.w,OldVbl
	move.l	#VblRoutine,VBL.w
	rts

VblDesinstalle
	move.l	OldVbl,VBL.w
	rts
	
VblRoutine
	jsr	ZicSnd+8 ; joue la musique
	move.l	OldVbl,-(sp)
	rts

MusiqueInit
	jsr	ZicSnd	; Init
	rts

KbdInstalle
	move.l	KBD_VECS.w,OldKbdVecs
	move.l	#KbdRoutine,KBD_VECS.w
	rts

KbdDesinstalle
	move.l	OldKbdVecs,KBD_VECS.w
	rts

KbdRoutine
	move.w	#$2500,sr
	move.w	d0,-(sp)
	move.b	KBD_ACIA_CTRL,d0
	bpl.s	.rien
	cmpi.b	#$39,KBD_ACIA_DATA ; $39 est le scan code de "espace"
	bne.s	.rien
	move.w	#-1,FlagQuitter
.rien	bclr	#6,$fffa11
	move.w	(sp)+,d0
	move.w	#2300,sr
	rte

	INCLUDE ..\src\scn.s	 ; Gestion de l'‚cran
	INCLUDE ..\src\bitmap.s	 ; Dessin
	INCLUDE alien.s		 ; Alien
	INCLUDE	elite.s		 ; Logo Elite
	INCLUDE	blit.s		 ; Fonctions de 
	INCLUDE	scroll.s	 ; Scroll texte


	SECTION DATA	
	EVEN
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
		
	EVEN

ZicSnd	INCBIN	F:\MPS\GOD\ZICS\test_zxx.snd

	SECTION BSS
	EVEN
FlagQuitter	ds.w	1	; Si -1 on quitte
	IFNE	DEBUG
OldStack	ds.l	1	; ancienne pile
OldPalette ds.w	16	; ancienne palette de couleur	
OldVbl	ds.l	1	; ancien vecteur VBL
OldKbdVecs	ds.l	1; ancien vecteur clavier
	ENDC
	ds.b	1024	; 1Ko de pile
Stack	ds.l	1	; sommet de la pile
Fb	ds.l	FBSIZE+256+10*160 ; 256 pour alignement 16bit, 10 lignes suppl‚mentaire pour scrolltext