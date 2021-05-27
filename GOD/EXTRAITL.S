; Outil d'extraction:
* des lettres de ELITE
* de la palette
* du message to scroll text (conversion ASCII->no de cellule)
* du message de l'intro (pareil)

	OUTPUT f:\mps\god\extrait.tos

X	EQU	0
Y	EQU	0
LARGEUR	EQU	31
HAUTEUR	EQU	39

	INCLUDE	macros.i

	; Sauve le buffer dans le fichier nomm‚ par a5
SAUVE	MACRO
	Fdelete	#\1
	Fcreate	#\1,0
	move.w	d0,handle
	Fwrite	d0,len,buf
	Fclose	handle
	ENDM


main
	bsr	calculeYoffset

xpalette:
	movem.l	palette+2,d0-d7
	movem.l	d0-d7,buf
	move.l	#32,len
	SAUVE	nom_palette


xe:	lea	le+34,a0 ; passe 2 octets en tˆte plus 32 palette
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
	REPT 45
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

logoAnimation:
	lea	logoanim+34,a4
	lea	buf,a5
	
	moveq	#48-1,d6 ; hauteur en pixels
.blcl1	movea.l	a4,a6	
	REPT 3		; 3*16=48 pixels
	move.l	(a6)+,(a5)+
	move.l	(a6)+,(a5)+ ; 16 pixels
	ENDR
	lea	160(a4),a4 ; ligne suivante
	dbra	d6,.blcl1
	move.l	#48*48,len
	SAUVE	nom_logo1
	
	lea	buf,a5
	moveq	#48-1,d6 ; hauteur en pixels
.blcl2	movea.l	a4,a6
	REPT 3		; 3*16=48 pixels
	move.l	(a6)+,(a5)+
	move.l	(a6)+,(a5)+ ; 16 pixels
	ENDR
	lea	160(a4),a4 ; ligne suivante
	dbra	d6,.blcl2
	move.l	#48*48,len
	SAUVE	nom_logo2

	lea	buf,a5
	moveq	#48-1,d6 ; hauteur en pixels
.blcl3	movea.l	a4,a6	
	REPT 3		; 3*16=48 pixels
	move.l	(a6)+,(a5)+
	move.l	(a6)+,(a5)+ ; 16 pixels
	ENDR
	lea	160(a4),a4 ; ligne suivante
	dbra	d6,.blcl3
	move.l	#48*48,len
	SAUVE	nom_logo3
	
	lea	buf,a5
	moveq	#48-1,d6 ; hauteur en pixels
.blcl4	movea.l	a4,a6	
	REPT 3		; 3*16=48 pixels
	move.l	(a6)+,(a5)+
	move.l	(a6)+,(a5)+ ; 16 pixels
	ENDR
	lea	160(a4),a4 ; ligne suivante
	dbra	d6,.blcl4
	move.l	#48*48,len
	SAUVE	nom_logo4
	


alien:	; gros alien rouge. Il est avec la couleur 7 donc on va 
	Fopen	#nom_bidules
	move.w	d0,handle
	Fread	handle,#32034,buf
	Fclose	handle
	lea	buf+34,a2
	lea	buf2,a1
	; l'alien fait 75*50 pixels 75/16 -> il faut 5x16blocs sur 4 plans: 5x2o*4 = 40 octets par ligne
	moveq	#49,d4
.boucle	movea.l	a2,a0
	REPT	10
	move.l	(a0)+,(a1)+
	ENDR
	lea	160(a2),a2
	dbra	d4,.boucle
	Fdelete	#nom_alien
	Fcreate	#nom_alien
	move.w	d0,handle
	Fwrite	handle,#40*50,buf2
	Fclose	handle

traduitMessage:
	lea	nom_scrollmsg,a5
	lea	nom_scrollbin,a6
	bsr	ascii2cell
	lea	nom_introtxt,a5
	lea	nom_introbin,a6
	bsr	ascii2cell
	
	Pterm0
	
; ---------- Sous programmes -------------
	

ascii2cell: 
	; Convertit le fichier texte en a5 en num‚ro de cellules
	; et stocke le r‚sultat dans le nom de fichier a6 
	Fopen	a5
	move.w	d0,handle
	Fseek	#0,handle,#2
	move.l	d0,d7
	Fseek	#0,handle,#0
	Fread	handle,d7,buf
	Fclose	handle
	lea	buf,a0
	move.b	#-1,(a0,d7.w)	; force fin du message
.boucle	move.b	(a0),d0
	beq	.fait
	cmpi.b	#10,d0 ; LF
	bne.s	.paslf
	move.b	#-2,(a0)+
	bra.s	.boucle
.paslf	cmpi.b	#13,d0 ; CR
	bne.s	.pascr
	move.b	#-3,(a0)+
	bra.s	.boucle
.pascr	cmpi.b	#'0',d0
	blt.s	.pasChiffre
	cmpi.b	#'9',d0
	bgt.s	.pasChiffre
	subi.b	#'0'-('Z'-'A'+1),(a0)+
	bra.s	.boucle
.pasChiffre
	cmpi.b	#' ',d0
	bne.s	.point
	move.b	#42,(a0)+
	bra.s	.boucle	
.point	cmpi.b	#'.',d0
	bne.s	.virgule
	move.b	#36,(a0)+
	bra.s	.boucle
.virgule	cmpi.b	#',',d0
	bne.s	.tiret
	move.b	#37,(a0)+
	bra.s	.boucle
.tiret	cmpi.b	#'-',d0
	bne.s	.exclam
	move.b	#38,(a0)+
	bra.s	.boucle
.exclam	cmpi.b	#'!',d0
	bne.s	.apostrof
	move.b	#39,(a0)+
	bra.s	.boucle
.apostrof	cmpi.b	#$27,d0
	bne.s	.interrog
	move.b	#40,(a0)+
	bra.s	.boucle
.interrog	cmpi.b	#'?',d0
	bne.s	.alpha
	move.b	#41,(a0)+
	bra	.boucle
.alpha	subi.b	#'A',(a0)+
	bra	.boucle
	
.fait	move.b	#-1,(a0)
	addq.l	#1,d7	; ajoute octet de fin
	Fdelete	a6
	Fcreate	a6
	move.w	d0,handle
	Fwrite	handle,d7,buf
	Fclose	handle
	rts

	
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
buf2	DS.W	32000
x	DS.W	1
y	DS.W	1
yoffset	DS.W	200
len	DS.L	1
handle	DS.W	1

	SECTION DATA
le	INCBIN 	elite\lettre-e.pi1
ll	INCBIN	elite\lettre-l.pi1
li	INCBIN	elite\lettre-i.pi1
lt	INCBIN	elite\lettre-t.pi1
le2	INCBIN	elite\lettr-e2.pi1
palette	INCBIN	font\font3.pi1
logoanim	INCBIN	elite\anim-48b.pi1
	EVEN

nom_e	dc.b	"elite\e.bin",0
nom_l	dc.b	"elite\l.bin",0
nom_i	dc.b	"elite\i.bin",0
nom_t	dc.b	"elite\t.bin",0
nom_e2	dc.b	"elite\e2.bin",0
nom_palette	dc.b "elite\palette.bin",0
nom_scrollmsg 	dc.b "message.txt",0
nom_scrollbin	dc.b "message.bin",0
nom_introtxt	dc.b "introtxt.txt",0,0 ; pour EVEN
nom_introbin	dc.b "introtxt.bin",0,0
nom_bidules	dc.b "elite\bidules.pi1",0
nom_alien		dc.b "alien.bin",0
nom_logoanim	dc.b "elite\logoanim.pi1",0
nom_logo1		dc.b "elite\logo1.bmp",0
nom_logo2		dc.b "elite\logo2.bmp",0
nom_logo3		dc.b "elite\logo3.bmp",0
nom_logo4		dc.b "elite\logo4.bmp",0
