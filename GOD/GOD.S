	OUTPUT 	f:\mps\god\GOD.TOS

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
	bsr	RasterInit
	bsr	VblInstalle
	bsr	MusiqueInit
	IFEQ	DEBUG
	bsr	KbdInstalle
	ENDC
	bsr	ScnEfface
;	bsr	AlienInit
	bsr	EliteInit
	bsr	ScrollInit
	jsr	Cube3dInit

	clr.w	FlagQuitter
BouclePrincipale
	IFNE	DEBUG
	Bconstat2
	bne.s	quitte
	ELSE
	tst.w	FlagQuitter
	bne.s	quitte
	ENDC
	
;	bsr	AlienAnimation
	bsr	EliteAnimation
	bsr	ScrollAnimation
	jsr	Cube3dAnimation
	
	bra.s	BouclePrincipale

quitte		
	IFEQ	DEBUG
	bsr	KbdDesinstalle
	ENDC

	IFNE	DEBUG
	jsr	Cube3dDeinit
	bsr	ScrollDeinit
;	bsr	AlienDeinit
	bsr	VblDesinstalle
	bsr	RasterDeinit
	bsr	MusiqueDeinit
	bsr	ScnRestore
	bsr	ScnDeinit
	RestaurePalette OldPalette
	move.l	OldStack,sp
	ENDC
	rts	 ; Retour de la fonction principale

VblInstalle
	move.l	VBL.w,OldVbl
	move.l	#VblRoutine,VBL.w
	rts

VblDesinstalle
	move.l	OldVbl,VBL.w
	rts
	
VblRoutine
	bsr	RasterVbl
	bsr	MusiqueAnimation
	move.l	OldVbl,-(sp)
	rts

KbdInstalle
	move.l	KBD_VECS.w,OldKbdVecs
	move.l	#KbdRoutine,KBD_VECS.w
	rts

KbdDesinstalle
	move.l	OldKbdVecs,KBD_VECS.w
	rts

KbdRoutine
	move.w	d0,-(sp)
	move.b	KBD_ACIA_CTRL.w,d0
	bpl.s	.rien
	cmpi.b	#$39,KBD_ACIA_DATA.w ; $39 est le scancode de "espace"
	bne.s	.rien
	move.w	#-1,FlagQuitter
.rien	bclr	#6,$fffffa11.w
	move.w	(sp)+,d0
	rte

	; Modules
	INCLUDE ..\src\scn.s	 ; Gestion de l'‚cran
	INCLUDE ..\src\bitmap.s	 ; Dessin
	INCLUDE alien.s		 ; Alien
	INCLUDE elite.s		 ; Logo Elite
	INCLUDE blit.s		 ; Fonctions de 
	INCLUDE scroll.s	 ; Scroll texte
	INCLUDE raster.s
	INCLUDE musique.s
	INCLUDE cube3d.s
			
	SECTION DATA	
	EVEN

	SECTION BSS
	EVEN
FlagQuitter ds.w	1	; Si -1 on quitte
OldStack	  ds.l	1	; ancienne pile
OldPalette  ds.w	16	; ancienne palette de couleur	
OldVbl	  ds.l	1	; ancien vecteur VBL
OldKbdVecs  ds.l	1	; ancien vecteur clavier
	  ds.b	2024	; 1Ko de pile
Stack	  ds.l	1	; sommet de la pile
Fb	  ds.l	FBSIZE+256+10*160 ; 256 pour alignement 16bit, 10 lignes suppl‚mentaire pour scrolltext