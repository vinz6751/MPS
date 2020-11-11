; Dessins en m‚moire vid‚o. Ces routines sont ‚crites pour fonctionner sur
; ST en basse r‚solution (320x200, 16 couleurs), le plus rapidement possible
; quitte … utiliser un peu de m‚moire. Pour optimiser, les techniques
; suivantes sont utilis‚es:
; - Utiliser au maximum les registres pour ‚viter les accŠs m‚moire, y 
;   compris pour stocker les r‚sultats interm‚diaires.
; - add.w add.w au lieu de lsr.w #1.
; - Rentabiliser le co–t d'initialisation des fonction en traitant des tableaux de points plut“t qu'un seul.
; - Empilage puis rts plut“t que jump.
; - Utilisation de fonctions d'addressage pixel, une par pixel dans un mot et par couleur (bp4.s)
;
; Vinz/MPS 2020

	IFND	CLIPPING
CLIPPING	EQU	1	; Empˆche le dessin en dehors de l'‚cran. On peut le d‚sactiver pour gagner quelques cycles.
	ENDC

X_RES	EQU	320	; R‚solution de la m‚moire vid‚o
Y_RES	EQU	200

; Pour utiliser le module il faut l'initialiser ave BmpInit.
; Quand on a fini, appeler BmpDeinit.
;
; Les fonctions disponibles sont :
; BmpPixelPutMono: dessine des points tous de la mˆme couleur.
;   a0: pointeur vers un tableau de paire de mots (x.w,y.w).
;       x < 0 marque la fin du tableau.
;   d0: num‚ro de couleur

; BmpLine: dessine un ligne.
;   a0: pointeur vers un tableau de 2 points (x.w,y.w).
;       Peu importe l'orientation de la ligne.
;  d0: num‚ro de couleur
 
; BmpCircle: dessine un cercle
;   d1: x du centre
;   d2: y du centre
;   d3: rayon
;   d0: num‚ro de couleur
 

	SECTION TEXT
BmpInit:	; Initialise le module
	; Calcul des offsets de ligne (16bits seulement)
	lea	bmpLineYOffsets,a1
	move.w	#-160,d2	
	move.l	#Y_RES-1,d1
.loop:	addi.l	#160,d2
	move.w	d2,(a1)+
	dbra	d1,.loop

BmpDeinit: ; D‚sinitialise le module
	rts


BmpPixelPutMono:
	; Dessine des points, tous de la mˆme couleur.
	; a0 pointe vers un tableau de paires (x.w,y.w).
	; Quand x > 32767 on arrˆte
	; d0.w est la couleur d‚sir‚e.
	; Affecte d0.w d1.l d2.l a0-a3
	lea	bmpLineYOffsets,a1	; Offset des lignes	
	lea	.bp4_couleurs,a2 	; Tableau des routines de couleur
	add.w	d0,d0
	add.w	d0,d0		; index.l du tableau de routines de dessin
	movea.l	(a2,d0.w),a2  	; Routines de couleur pour la couleur choisie
	move.l	BmpFb,d0		; Economise accŠs m‚moire et cycles
.loop:	move.w	(a0)+,d1
	bmi.s	.fin
	IFNE	CLIPPING
	cmpi.w	#X_RES-1,d1
	bpl	.x_out
	ENDC
	ext.l	d1
	move.w	(a0)+,d2	; d1.l:x d2.w:y 
	IFNE	CLIPPING
	cmpi.w	#Y_RES-1,d2
	bpl	.y_out	
	ENDC
	add.w	d2,d2
	movea.w	(a1,d2.w),a3	; Offset Y pris en compte
	
	adda.l	d0,a3		; + adresse de la m‚moire vid‚o

	move.w	d1,d2
	andi.w	#$fff0,d1		; Optimisation de lsr #4 puis lsl #3
	lsr.w	#1,d1		; Pour trouver le num‚ro de groupe des 16 pixels et les plans font 8 octets 
	adda.l	d1,a3		; Offset X pris en compte

	andi.w	#$f,d2		; d2: num‚ro du bit dans le plan
	add.w	d2,d2
	add.w	d2,d2
	move.l	(a2,d2.w),-(sp)
.fin	rts			; plus efficace qu'un jsr
	include	..\src\bp4.s ; Routines de dessin de pixel, une par couleur et par pixel dans un ensemble de 16

	IFNE	CLIPPING		; Support du clipping
.x_out	addq.l	#2,a0		; Skip y
.y_out	bra	.loop	
	ENDC


getScreenPos:; d1:x, d2: y
	; R‚sultat dans a6
	movem.l	d1-d3,-(sp)
	and.l	#$ff,d1
	and.l	#$ff,d2
	movea.l	BmpFb,a6
	move.l	d1,d3
	and.l	#%11111110,d1
	rol.l	#2,d1
	add.l	d1,a6
	and.l	#%00000001,d3
	add.l	d3,a6
	mulu	#160,d2
	add.l	d2,a6
	movem.l	(sp)+,d1-d3
	rts

BmpLine:
	; Dessin de ligne par l'algorithme de Bresenham
	; a0 pointe vers un tableau de 2 paires (x.w,y.w)
	; d0.w est le num‚ro de couleur
	; Voir la page wikipedia, c'est ‡a qui est impl‚ment‚ ni plus ni moins
	move.w	(a0),d1	; x0
	move.w	2(a0),d2	; y0
	move.w	4(a0),d3	; x1
	move.w	6(a0),d4	; y1
	; abs(y1-y0)
	move.w	d4,d5	
	sub.w	d2,d5
	move.w	d5,d6
	swap	d5
	move.w	d6,d5	; d5.msw = y1-y0
	bpl.s	.absy
	neg.w	d5
.absy			; d5 = abs(y1-y0)
	; abs(x1-x0)
	move.w	d3,d6
	sub.w	d1,d6
	move.w	d6,d7	; d7 = x1-x0
	bpl.s	.absx
	neg.w	d6
.absx			; d6 = abs(x1-x0)

	cmp.w	d5,d6	; if abs(y1-y0) < abs(x1-x0)
	bls.s	.high
.low	tst.w	d7	;   if x0 > x1  
	bpl.s	.lowswap
	exg	d1,d3
	exg	d2,d4
.lowswap	bra.s	.plotLineLow
.high	swap	d5
	tst.w	d5	; if y0 > y1
	bpl.s	.highswap
	exg	d1,d3
	exg	d2,d4
.highswap	swap	d5
	bra.s	.plotLineHigh


.plotLineLow:
	; Dessine un ligne qui descend de gauche … droite	
	; Affecte:
	;  d1.w d2.w d4.w d5.w d6.w d7.w  
	; dx
	move.w	d3,d5	
	sub.w	d1,d5	; dx
	; dy et yi
	moveq.w	#1,d7
	move.w	d4,d6	
	sub.w	d2,d6	; dy et yi
	bpl.s	.dyyiok
	moveq.w	#-1,d7
	neg.w	d6
.dyyiok	; si dy < 0 alors yi=-1,dy=-dy. Maintenant d6:dy
	
	; Calcule d
	add.w	d6,d6	; d6: 2*dy
	move.w	d6,d4
	sub.w	d5,d4	; d4: d = 2*dy-dx
	add.w	d5,d5	; d5: 2*dx
	; Liste de point r‚sultante
	lea	bmpPointBuf,a1
	sub.w	d1,d3	; Pr‚pare le nombre d'it‚rations	
.loopl:	move.w	d1,(a1)+	; stocke point … dessiner dans la liste
	move.w	d2,(a1)+
	tst.w	d4	; if (d>=0)
	ble.s	.elsel
	add.w	d7,d2	; y += di
	sub.w	d5,d4	; d -= 2*dx
.elsel	add.w	d6,d4	; d += 2*dy
	addq.w	#1,d1	; x++
	dbra	d3,.loopl
.loopendl	move.w	#$ffff,(a1) ; fin de la liste de points
	lea	bmpPointBuf,a0
	bra	BmpPixelPutMono
	
	
.plotLineHigh: ; Dessine une ligne qui monte de gauche … droite
	; d1-d4: x0,y0 x1,y1
	; a0: retourne liste de points g‚n‚r‚s 
	moveq.w	#1,d7
	move.w	d3,d5	
	sub.w	d1,d5	; d5: dx
	bpl.s	.dxxiok
	moveq.w	#-1,d7	: d7:xi
	neg.w	d5
.dxxiok	; si dx < 0 alors xi=-1,dx=-dx 
	
	; dy
	move.w	d4,d6	
	sub.w	d2,d6	; d6: dy
	
	; Calcule d
	add.w	d5,d5	; d5: 2*dx
	move.w	d5,d3	; On utilise plus x1 donc on utilise d3 pour d
	sub.w	d6,d3	; d3:  d = 2*dx-dy
	; AprŠs on utilise plus que 2*dx et 2*dy
	add.w	d6,d6	; d6: 2*dy
	; Liste de point r‚sultante
	lea	bmpPointBuf,a1	
	sub.w	d2,d4	; Pr‚pare nombre d'it‚rations
.looph:	move.w	d1,(a1)+	; stocke point … dessiner dans la liste
	move.w	d2,(a1)+
	tst.w	d3	; if (d>0)
	ble.s	.elseh
	add.w	d7,d1	; x += xi
	sub.w	d6,d3	; d -= 2*dy
.elseh	add.w	d5,d3	; d += 2*dx
	addq.w	#1,d2	; y++
	dbra	d4,.looph
.loopendh	move.w	#$ffff,(a1) ; fin de la liste de points
	lea	bmpPointBuf,a0
	bra	BmpPixelPutMono
	
	IFNE	0
BmpHLine:	; Dessine une ligne horizontale
	; d1: x1
	; d2: y
	; d3: x2
	; d0: couleur
	; Assure que x1 < x2
	cmp.w	d3,d1
	bmi.s	.ok
.ok	exg	d1,d3
	; L'id‚e est la suivante: 
	; x = x1
	; d = x2-x1+1
	; si x1 n'est pas le 16Šme bit d'un mot
	;  faire
	;   plot x
	;   d--
	;  tant que (d <> 0) ou (x & $f != 0)
	; Maintenant on est sur le d‚but d'un ensemble de 16 pixels.
	; Si il reste moins de 16 pixels, il faut les faire 1 par un
	; Sinon on peut dessiner 16 pixels et r‚pliquer. On peut meme
	; dessiner 32 pixels si les registres le permettent.
	; d1: x = x1
	; d4: d
	move.w	d3,d4	; x2
	sub.w	d1,d4	; x2-x1
	addq.w	#1,d4	; d4: x2-x1+1 d‚compteur de points
	lea	bmpPointBuf,a0
	ENDC		



BmpCircle:
	; Dessine un cercle par la m‚thode d'AndrŠs
	; d0.w: couleur
	; d1.w: x centre
	; d2.w: y centre
	; d3.w: rayon
	; AltŠre TOUT les registres
	; Initialisations
	move.w	d3,d5	: y := r
	swap	d3
	move.w	d5,d3	; d3.msw: r  d3.lsw: d
	subq.w	#1,d3	; d := r - 1
	clr.w	d4	; x := 0
	move.w	#X_RES,d7	; d‚compteur de place dans le buffer de points
	lea	bmpPointBuf,a0 ; Buffer de points
	move.w	d0,d7
	swap	d7	; ProtŠge la couleur

.loopc	cmp.w	d5,d4	; compare y et x	
	bgt	.termine

	; Pour le dessin on remplit un buffer de
	; points et quand il est plein on dessine. d7 est le d‚compteur
	movea.w	d1,a1	
	adda.w	d4,a1	; centre_x + x
	movea.w	d1,a2
	adda.w	d5,a2	; centre_x + y
	movea.w	d1,a3
	suba.w	d4,a3	; centre_x - x
	movea.w	d1,a4
	suba.w	d5,a4	; centre_x - y
	movea.w	d2,a5
	adda.w	d4,a5	; centre_y + x
	movea.w	d2,a6
	adda.w	d5,a6	; centre_y + y
	move.w	d2,d6
	sub.w	d4,d6	; centre_y - x
	move.w	d2,d0
	sub.w	d5,d0	; centre_y - y
	move.w	a1,(a0)+	; cx+x cy+y
	move.w	a6,(a0)+
	move.w	a2,(a0)+	; cx+y cy+x
	move.w	a5,(a0)+
	move.w	a3,(a0)+	; cx-x cy+y
	move.w	a6,(a0)+
	move.w	a4,(a0)+	; cx-y cy+x
	move.w	a5,(a0)+
	move.w	a1,(a0)+	; cx+x cy-y
	move.w	d0,(a0)+
	move.w	a2,(a0)+	; cx+y cy-x
	move.w	d6,(a0)+
	move.w	a3,(a0)+	; cx-x cy-y
	move.w	d0,(a0)+
	move.w	a4,(a0)+	; cx-y cy-x
	move.w	d6,(a0)+
	subi.w	#16,d7
	bne.s	.nodraw
	bsr	.flush	; Tampon de points pleins, on dessine
	; d6 sert pour les r‚sultats interm‚diaires	
.nodraw	move.w	d4,d6
	add.w	d6,d6	; 2x
	cmp.w	d6,d3
	bmi.s	.sinon1	; si 2x <= d
	sub.w	d6,d3
	subq.w	#1,d3	; d -= 2x-1
	addq.w	#1,d4	; x++
	bra.s	.loopc
.sinon1	swap	d3	; R‚cupŠre r
	move.w	d3,d6	; r
	swap	d3
	sub.w	d5,d6	; r-y
	add.w	d6,d6	; 2(r-y)
	cmp.w	d3,d6
	bls.s	.sinon2	; si 2(r-y) > d
	move.w	d5,d6	; y
	add.w	d6,d6	; 2y
	subq.w	#1,d6	; 2y-1
	add.w	d6,d3	; d += 2y-1
	subq.w	#1,d5	; y--
	bra.s	.loopc
.sinon2	move.w	d5,d6	; y
	sub.w	d4,d6	; y-x
	subq.w	#1,d6	; y-x-1
	add.w	d6,d6	; 2(y-x-1)
	add.w	d6,d3	; d += 2(y-x-1)
	subq.w	#1,d5	; y--
	addq.w	#1,d4	; x++
	bra	.loopc
	
.flush	; Dessine les points dans le tampon et repr‚pare le.
	; Sauve registres importants pour la boucle principale
	movea.w	d1,a1
	movea.w	d2,a2
	move.w	#$ffff,(a0) ; Termine la liste de points
	lea	bmpPointBuf,a0 ; Liste de points
	swap	d7	; R‚cupŠre la couleur
	move.w	d7,d0
	swap	d7
	bsr	BmpPixelPutMono ; Dessine les points
	; Restore registres et reset le tampon
	move.w	a1,d1
	move.w	a2,d2
	move.w	#X_RES,d7
	lea	bmpPointBuf,a0
	rts		
	
.termine	; Termine le dessin du cercle
	bsr	.flush
	rts
	
	

	SECTION BSS
	EVEN
BmpFb		ds.l	1	; Adresse de la m‚moire vid‚o o— dessiner
bmpLineYOffsets	ds.l	Y_RES	; Offset des lignes dans la m‚moire ‚cran en basse r‚solution
bmpPointBuf	ds.w	X_RES*2 + 1 ; Buffer de points. Doit ˆtre:
	; - >= X_RES pour les lignes traversant l'‚cran
	; - Un multiple de 8 car quand on dessine les cercles on stocke 8 points d'un coup.
	; - +1 pour le marqueur de fin $ffff
