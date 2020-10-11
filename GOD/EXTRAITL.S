; Outil d'extraction des lettres de ELITE et de la palette
	OUTPUT extrait.tos

X	EQU	0
Y	EQU	0
LARGEUR	EQU	31
HAUTEUR	EQU	39

	; Sauve le buffer dans le fichier nomm‚ par a5
SAUVE	MACRO
	pea	\1
	move.w	#65,-(sp)
	trap	#1
	addq.l	#6,sp

	move.w	#0,-(sp)
	pea	\1
	move.w	#60,-(sp)	; Fcreate
	trap	#1
	addq.l	#8,sp
	move.w	d0,handle
	;
	pea	buf
	move.l	len,-(sp)
	move.w	d0,-(sp)
	move.w	#64,-(sp)	; Fwrite
	trap	#1
	lea.l	14(sp),sp
	;
	move.w	handle,-(sp)
	move.w	#62,-(sp)
	trap	#1
	addq.l	#4,sp
	ENDM


	bsr	calculeYoffset

xpalette:
	movem.l	palette+2,d0-d7
	movem.l	d0-d7,buf
	move.l	#32,len
	SAUVE	nom_palette

	

xe:	lea	le+34,a0 ; passe 2 octets en tˆte plus 32 palette
	lea	buf,a1
	clr.l	len	
	REPT 39
	move.l	(a0),(a1)+	
	move.l	4(a0),(a1)+	; 16 pixels
	move.l	8(a0),(a1)+
	move.l	12(a0),(a1)+	; 32
	adda.l	#160,a0		; ligne suivante
	add.l	#16,len
	ENDR
	SAUVE	nom_e

xl:	lea	ll+34,a0 ; passe 2 octets en tˆte plus 32 palette
	lea	buf,a1
	clr.l	len	
	REPT 45
	move.l	(a0),(a1)+	
	move.l	4(a0),(a1)+ 
	move.l	8(a0),(a1)+
	move.l	12(a0),(a1)+
	adda.l	#160,a0		; ligne suivante
	add.l	#24,len
	ENDR
	SAUVE	nom_l

xi:	lea	li+34,a0 ; passe 2 octets en tˆte plus 32 palette
	lea	buf,a1
	clr.l	len	
	REPT 40
	move.l	(a0),(a1)+	
	move.l	4(a0),(a1)+	; 16 pixels
	move.l	8(a0),(a1)+
	move.l	12(a0),(a1)+	; 32
	adda.l	#160,a0		; ligne suivante
	add.l	#16,len
	ENDR
	SAUVE	nom_i

xt:	lea	lt+34,a0 ; passe 2 octets en tˆte plus 32 palette
	lea	buf,a1
	clr.l	len	
	REPT 35
	move.l	(a0),(a1)+	
	move.l	4(a0),(a1)+	; 16 pixels
	move.l	8(a0),(a1)+
	move.l	12(a0),(a1)+	; 32
	adda.l	#160,a0		; ligne suivante
	add.l	#16,len
	ENDR
	SAUVE	nom_t

xe2:	lea	le2+34,a0 ; passe 2 octets en tˆte plus 32 palette
	lea	buf,a1
	clr.l	len	
	REPT 43
	move.l	(a0),(a1)+	
	move.l	4(a0),(a1)+	; 16 pixels
	move.l	8(a0),(a1)+
	move.l	12(a0),(a1)+	; 32
	adda.l	#160,a0		; ligne suivante
	add.l	#16,len
	ENDR
	SAUVE	nom_e2

	clr.w	-(sp)	; Pterm0
	trap	#1			

	
calculeYoffset
	lea	yoffset,a0
	move.w	#199,d0
	clr.w	d1
.boucle	move.w	d1,(a0)+
	adda.l	#160,a0
	dbra	d0,.boucle
	rts
	

	


	SECTION BSS
buf	DS.W	32000
x	DS.W	1
y	DS.W	1
yoffset	DS.W	200
len	DS.L	1
handle	DS.W	1
	SECTION DATA
le	INCBIN elite\lettre-e.pi1
ll	INCBIN	elite\lettre-l.pi1
li	INCBIN	elite\lettre-i.pi1
lt	INCBIN	elite\lettre-t.pi1
le2	INCBIN	elite\lettr-e2.pi1
palette	INCBIN	logo8-1.pi1
	EVEN

nom_e	dc.b	"elite\e.bin",0
nom_l	dc.b	"elite\l.bin",0
nom_i	dc.b	"elite\i.bin",0
nom_t	dc.b	"elite\t.bin",0
nom_e2	dc.b	"elite\e2.bin",0
nom_palette	dc.b	"elite\palette.bin",0
