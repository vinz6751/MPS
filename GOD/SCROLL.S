; Scroll text pour fonte de 16 pixels de large sur deux plans de bits
; La fonte est stockÇe pas sous forme d'image mais dans un format oó
; tous les mots d'un caractäres sont consÇcutifs.
; On stocke le caractäre Ö afficher dans un array de words.
; Ensuite Ö chaque itÇration on dÇcale chaque plan d'un bit et on
; l'insäre avec un rol sur le plan du dernier chunk de la ligne
; puis on roll tout le reste de proche en proche.
; Vinz / MPS Octobre 2020

FONT_W	EQU	16
FONT_H	EQU	10
FONT_LEN	EQU	43


	SECTION TEXT

ScrollInit	
	lea 	scrollFntIndex,a1
	move.l	#scrollFont,d2
	move.w	#FONT_LEN-1,d1
.bcl	move.l	d2,(a1)+
	addi.l	#8*FONT_H,d2
	dbra	d1,.bcl
	rts
	
ScrollDeinit
	rts

ScrollAnimation
	; Ralentisseur
;	move.w	.ralentisseur,d7
;	bne.s	.attend
;	move.w	#2,.ralentisseur
;	bra.s	.do			
;.attend	subi.w	#1,.ralentisseur
;	rts
;.do
	; DÇcompteur de pixel et chargement du prochain caractäre
	subi.w	#1,scrollPix
	bne.s	.scroll
	; Charge nouveau caractäre dans scrollBuf
	move.w	#FONT_W-1,scrollPix
	bsr	scrollPrepCar
	
.scroll	lea	scrollBuf,a1
	movea.l	BmpFb,a3
	adda.l	#160*(Y_RES-1-FONT_H)-32,a3
	moveq	#FONT_H-1,d3
.boucle	;movea.l	a2,a3
	; plan 0
	lsl.w	(a1)+	; rÇcupäre bit du plan 0
sxo	SET	152 	; scroll x offset
	REPT	14
	roxl	sxo(a3)	; insäre en pixel 15 plan0 dernier chunk de ligne et dÇcale toute la ligne
sxo	SET	sxo-8	; chunk prÇcÇdent
	ENDR
	; plan 1
	lsl.w	(a1)+	; meme chose plan 1
sxo	SET	154
	REPT	14
	roxl	sxo(a3)
sxo	SET	sxo-8
	ENDR
	; plan 2
	lea	4(a1),a1	; ignore plans 2 et 3
	lea	160(a3),a3 ; ligne suivante
	dbra	d3,.boucle

	rts
.ralentisseur	dc.w	$32


scrollPrepCar
	; PrÇpare le prochain caractäre du scrolltext
	movea.l	scrollCar(pc),a0
.redo	move.b	(a0)+,d2 	; caractäre Ö afficher
	ext.w	d2
	bpl.s	.carOk	; > -1 est marqueur de fin de message
	movea.l	#scrollMessage,a0 ; reset du message
	bra.s	.redo
.carOk	move.l	a0,scrollCar
	lea	scrollFntIndex,a2	
	add.w	d2,d2
	add.w	d2,d2
	movea.l	(a2,d2.w),a0
	; Copie le caractäre dans le buffer
	lea.l	scrollBuf,a1
	; on a 2x10 longs Ö copier
offset	SET	0
	REPT	2
	movem.l	(a0)+,d0-d7/a2-a3 ; 10 longs
	movem.l	d0-d7/a2-a3,offset(a1)
offset	SET	offset+10*4
	ENDR
	rts		
	
	SECTION DATA
scrollMessage	;dc.b "ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789 .,-!'? CECI EST UN MESSAGE A SCROLLER ! BON C'EST PAS TOP MAIS C'EST MON PREMIER ECRAN !! MPS POWER !!   ",0
	; Message Ö afficher, produit par l'outil EXTRAITL.S pour
	; remplacer les codes ASCII par des numÇros de cellule dans le fichier FONT.BIN
	INCBIN	message.bin
	
	EVEN
	; Ce fichier est produit par l'outil EXTRACTR dans le dossier FONT
scrollFont	INCBIN	font\fonte.bin

	EVEN
scrollCar	dc.l scrollMessage 	; pointeur vers caractäre courant
scrollPix	dc.w FONT_W-1	; dÇcompteur de colonne de cellule Ö afficher
	
	SECTION BSS
scrollCarBmp	ds.l 1 		; pointeur vers l'image du caractäre Ö afficher
scrollBuf		ds.b FONT_W*FONT_H 	; buffer ou on dÇcale les bits du caractäre Ö afficher
scrollFntIndex	ds.l FONT_LEN	; pointeurs vers cellules
	SECTION TEXT

