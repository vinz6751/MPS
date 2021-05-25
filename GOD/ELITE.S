* Affiche et gŠre le logo "ELITE"

EL_BUMP	EQU -5

	SECTION TEXT
EliteInit
	rts

EliteBump ; Fait sauter le logo
	move.w	#EL_BUMP,el_Elite+el_bump
	rts

EliteAnimation ; affiche les "elite"
	subi.w	#1,.ralentisseur
	beq.s	.fait
	rts		
.fait	move.w	#3,.ralentisseur

	moveq	#4,d4	; strlen("ELITE")-1
	lea	el_Elite,a4 ; premiŠre lettre
.boucle	move.w	el_bump(a4),d1
	beq.s	.skip
.bump	move.w	el_x(a4),d0
	add.w	el_y(a4),d1
	addq.w	#1,el_bump(a4)
	bne.s	.pasbumpsuiv
	move.w	#EL_BUMP,el_bump+el_sizeof(a4) ; bump la lettre suivante
.pasbumpsuiv
	move.w	el_h(a4),d2
	movea.l	el_bmp(a4),a0
	bsr.s	.effaceHaut ; efface la ligne au dessus de l… ou on va dessiner
	jsr	BlitL32
	;pr‚pare prochaine it‚ration
.skip	lea	el_sizeof(a4),a4
	dbra	d4,.boucle
	
	IFNE 0
	; Si tous les bumps sont … 0 on recommence
	lea	el_Elite(pc),a4
	move.w	el_bump+el_sizeof*0(a4),d4 ; bump E
	add.w	el_bump+el_sizeof*1(a4),d4 ; bump l
	add.w	el_bump+el_sizeof*2(a4),d4 ; bump l
	add.w	el_bump+el_sizeof*3(a4),d4 ; bump l
	add.w	el_bump+el_sizeof*4(a4),d4 ; bump l
	bne.s	.noreset	; si la somme est nulle, on reset
	move.w	#EL_BUMP,el_bump(a4)
	ENDC
.noreset
	rts
	
.effaceHaut ; efface la ligne au dessus du logo … dessiner
 	; pour ne pas laisse de trace quand il descend
	move.w	d1,d5
	beq.s	.ehfin ; si on est sur la premire ligne ne fait rien
	lea	bmpLineYOffsets,a1
	subq.w	#1,d5 		; ligne pr‚c‚dente
	add.w	d5,d5		; tableau de mots
	move.w	(a1,d5.w),a1	; offset ligne
	adda.l	BmpFb,a1		; frame buffer
	add.w	d0,a1		; ajout x
	clr.l	(a1)+ 
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)	
.ehfin	rts
	

	SECTION DATA
.zprecedent   dc.w	0
.ralentisseur dc.w	50

;D‚finition d'une lettre pour l'animation
	rsreset
el_bump	rs.w	1 ;valeur de bump
el_x	rs.w	1
el_y	rs.w	1
el_h	rs.w	1 ;hauteur en nombre de lignes
el_bmp	rs.l	1 ;pointeur vers l'image … blitter
el_sizeof	rs.b	1

	IFNE	0
el_Elite	dc.w	6,32,7,42
	dc.l	Elite
el_eLite	dc.w	1,48,6,45
	dc.l	eLite
el_elIte	dc.w	1,64,10,38
	dc.l	elIte
el_eliTe	dc.w	1,80,12,35
	dc.l	eliTe
el_elitE	dc.w	1,96,9,42
	dc.l	elitE
	ELSE
el_Elite	dc.w	EL_BUMP,40,6,42
	dc.l	Elite
el_eLite	dc.w	0,56,6,45
	dc.l	eLite
el_elIte	dc.w	0,72,10,38
	dc.l	elIte
el_eliTe	dc.w	0,88,11,35
	dc.l	eliTe
el_elitE	dc.w	0,104,8,42
	dc.l	elitE
	ENDC
el_dummy_bump dc.w 0
	
	; Bitmaps des lettres prˆtes … blitter
Elite	INCBIN	elite\e.bin
eLite	INCBIN	elite\l.bin
elIte	INCBIN	elite\i.bin
eliTe	INCBIN	elite\t.bin
elitE	INCBIN	elite\e2.bin
	; Palette
ElitePalette INCBIN	elite\palette.bin
