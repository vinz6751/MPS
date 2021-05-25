DEBUG	EQU	1

	OUTPUT 	f:\mps\god\GOD.TOS

	OPT	P=68000;
	OPT	O+
	OPT	OW-
	IFEQ DEBUG
	OPT	NODEBUG
	ENDC

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
CLIPPING	EQU 	0 ; Dans bitmap.s


	EVEN
	SECTION TEXT
_main	
	IFNE	DEBUG
	KbdFlush
	ENDC
	
	Supexec	Main
	Pterm0	

Main	move.l	sp,OldStack
	SauvePalette OldPalette

	; Initialise l'‚cran
	lea	Stack,sp
	bsr	ScnInit
	bsr	BmpInit

	; Passe en basse r‚solution
	clr.w	d0
	lea	Fb,a0
	bsr	ScnSet	

	; Initialise l'‚cran
	move.l	ScnFb,BmpFb
	RestaurePalette ElitePalette
	bsr	ScnEfface

	; D‚sactive interruptions non n‚cessaires
	move.b	#$12,$fffffc02.w    ; rapport souris
	andi.b #%11011111,$fffffa09.w ; timer C
	
	; Lance la musique parce que les Z coordonnent tout
	bsr	MusiqueInit
	bsr	VblInstalle
	move.l	#VblRoutineIntro,VBL.w

	jsr	Intro

 	RestaurePalette ElitePalette
 	move.w	ElitePalette,FlashBg		
	bsr	ScnEfface

	bsr	RasterInit
	move.l	#VblRoutine,VBL.w
		
	IFEQ	DEBUG
	bsr	KbdInstalle
	ENDC	
	bsr	EliteInit
	bsr	ScrollInit
	jsr	Cube3dInit
	jsr	DecoInit
	jsr	LigneInit
	jsr	LogoInit
	
	clr.w	FlagQuitter
BouclePrincipale
	IFNE	DEBUG
	Bconstat2
	beq.s	.nokey
	Cnecin
	cmp.w	#' ',d0
	beq.s	quitte
	bsr	MusiqueZKey
.nokey
	ELSE
	tst.w	FlagQuitter
	bne.s	quitte
	ENDC

	bsr	MusiqueZ
	bsr	EliteAnimation
	bsr	ScrollAnimation
	jsr	Cube3dAnimation
	jsr	DecoAnimation
	jsr	LigneAnimation
	jsr	LogoAnimation
		
	bra.s	BouclePrincipale

quitte		
	IFEQ	DEBUG
	bsr	KbdDesinstalle
	ENDC

	jsr	Cube3dDeinit
	bsr	ScrollDeinit
	bsr	VblDesinstalle
	bsr	RasterDeinit
	bsr	MusiqueDeinit
	jsr	DecoDeinit
	jsr	LigneDeinit
	bsr	ScnRestore
	bsr	ScnDeinit
	bsr	LogoDeinit
	RestaurePalette OldPalette
	move.l	OldStack,sp
	
	; R‚active timer C
	ori.b  	#%00100000,$fffffa09.w ; r‚active timer C
	move.b	#$08,$fffffc02.w        ; r‚active souris

	rts	 ; Retour de la fonction principale


VblInstalle
	move.l	VBL.w,OldVbl
	rts


VblDesinstalle
	move.l	OldVbl,VBL.w
	rts

	
VblRoutine
	bsr	FlashAnimation
	tst.w	flashClr
	bpl.s	.noraster; si on flash, pas de raster
	bsr	RasterVbl
.noraster	bsr	MusiqueAnimation
	move.l	OldVbl,-(sp)
	rts

VblRoutineIntro; routine VBL pour l'intro (pas de raster)
	bsr	FlashAnimation
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
	INCLUDE elite.s		 ; Logo Elite
	INCLUDE blit.s		 ; Fonctions de copie de m‚moire ‚cran
	INCLUDE scroll.s	 ; Scroll texte
	INCLUDE raster.s
	INCLUDE musique.s
	INCLUDE cube3d.s
	INCLUDE deco.s
	INCLUDE ligne.s
	INCLUDE logo.s
	INCLUDE intro.s
	INCLUDE flash.s
	
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