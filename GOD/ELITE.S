* Affiche et gŠre le logo "ELITE"

	SECTION TEXT
EliteInit
	rts

EliteAnimation ; affiche les "elite"
	moveq	#4,d4	; strlen("ELITE")-1
	lea	el_Elite,a4
.boucle	move.w	el_bump(a4),d1
	beq.s	.skip
	move.w	el_x(a4),d0
	add.w	el_y(a4),d1
	subq.w	#1,el_bump(a4)
	move.w	el_h(a4),d2
	movea.l	el_bmp(a4),a0
	jsr	BlitL32
	;pr‚pare prochaine it‚ration
.skip	lea	el_sizeof(a4),a4
	dbra	d4,.boucle
	rts

	SECTION DATA
;D‚finition d'une lettre pour l'animation
	rsreset
el_bump	rs.w	1 ;valeur de bump
el_x	rs.w	1
el_y	rs.w	1
el_h	rs.w	1 ;hauteur en nombre de lignes
el_bmp	rs.l	1 ;pointeur vers l'image … blitter
el_sizeof	rs.b	1


el_Elite	dc.w	1,32,10,38
	dc.l	Elite
el_eLite	dc.w	1,48,6,41
	dc.l	eLite
el_elIte	dc.w	1,64,10,38
	dc.l	elIte
el_eliTe	dc.w	1,80,11,33
	dc.l	eliTe
el_elitE	dc.w	1,96,8,42
	dc.l	elitE
	
	; Bitmaps des lettres prˆtes … blitter
Elite	INCBIN	elite\e.bin
eLite	INCBIN	elite\l.bin
elIte	INCBIN	elite\i.bin
eliTe	INCBIN	elite\t.bin
elitE	INCBIN	elite\e2.bin
	; Palette
ElitePalette INCBIN	elite\palette.bin
