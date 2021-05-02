; Alien de l'intro
; Id‚es: l'alien est couleur 16 car ‡a permet de dessiner plus vite
; (voir bp4)
; On dessine la ligne horizontale de l'alien et on la recopie
; un certaine nombre de fois pour faire des carr‚s
AL2_DEBUG	EQU 0

ALIEN_MAX_ZOOM EQU 13
	SECTION TEXT

	IFNE	AL2_DEBUG
	pea	main
	move.w	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	
	clr.w	-(sp)
	trap	#1 ; Pterm0

	INCLUDE	..\src\scn.s
	INCLUDE	..\src\bitmap.s
Fb	ds.b	32256
	; Passe en basse r‚solution
	SECTION	TEXT
	
main	jsr	ScnInit
	jsr	BmpInit

	clr.w	d0
	lea	Fb,a0
	bsr	ScnSet	

	; Fixe l'adresse logique pour le dessin
	move.l	ScnFb,BmpFb

main2	bsr	IntroAlienInit
	bsr	IntroAlienAnimation

	move.w	#8,-(sp)
	trap	#1 ; Cnecin
	addq.l	#2,sp

	
	jsr	ScnRestore
	jsr	ScnDeinit
	ENDC	
	
IntroAlienInit
	move.w	#$700,$ffff825e.w ; couleur 16: rouge
	clr.w	AlienFin
	rts
	

IntroAlienAnimation
	subi.w	#1,.slow
	beq.s	.do
	rts
	
.do	move.w	#4,.slow
	move.w	.gros(pc),d2
	cmpi.w	#ALIEN_MAX_ZOOM,d2
	bne.s	.do1
	move.w	#-1,AlienFin
	rts
	
.do1	move.l	#160,d0
	move.l	#100,d1
	bsr.s	ali2_calcule_ligne
	
	addi.w	#1,.gros
	bra.s	IntroAlienAnimation
	rts
.gros	dc.w	1
.slow	dc.w	40 ; retard initial

ali2_calcule_ligne
	; Calcule le rendu de l'alien
	; d0:x, d1:y, d2:grossissement
	; d6: index de ligne du modŠle
	lea	.ali2_rlignes(pc),a6
	lea	alien_pts,a4
	movea.l	a4,a0    ; pour appel BmpPutPixelMono
	moveq	#8-1,d6  ; nombre de lignes
.bclligne	movea.l	(a6)+,a5 ; adresse de la ligne du modŠle … dessiner 
	move.w	(a5)+,d5 ; nombre de points sur la ligne du modŠle
	move.w	(a5)+,d4 ; offset y de la ligne
	muls	d2,d4
	add.w	d1,d4    ; y ‚cran o— dessiner
	; it‚ration sur les points de la ligne du modŠle
.bclmpts	move.w	d2,d7    ; it‚ration sur le grossissement pour le d‚doublement des points
	subq.w	#1,d7
	move.w	(a5)+,d3
	muls	d2,d3
	add.w	d0,d3    ; x ‚cran o— dessiner
	
	; dessine le point et d‚double suivant le facteur de grossissement
.xfactor	move.w	d3,(a4)+
	move.w	d4,(a4)+
	addq.w	#1,d3
	dbra	d7,.xfactor	
	
	dbra	d5,.bclmpts	
	dbra	d6,.bclligne
	
	; termine la liste de points
	move.w	#-1,(a4)

	; d‚termine le groupe de d‚but et le nombre de groupes
	; pour l'‚ffacement et le d‚doublage des lignes
	move.w	d2,d3
	muls.w	#-5,d3 ; pixel le plus … gauche
	add.w	d0,d3  
	andi.w	#$fff0,d3
	lsr.w	#1,d3 ; d3: groupe de d‚but
	; d‚termine la largeur … traiter
	move.w	d2,d4
	mulu.w	#10,d4 ; 10pixels de large * grossissement
	ext.l	d4
	addi.w	#$f,d4 ; arrondi au multiple de 16pixels sup‚rieur
	lsr.w	#4,d4  ; d4: nombre de groupes
	subq.w	#1,d4 ; puisqu'on utilise qu'avec des dbra

	IFNE	1	
	; d‚termine le num‚ro de ligne … partir duquel effacer
	move.w	d2,d5
	muls.w	#-4,d5 ; offset de ligne mini
	add.w	d1,d5 ; d5: num‚ro de ligne du haut
	move.w	d5,alien_mhi	
	
	; efface le carr‚ contenant l'alien
	lea	bmpLineYOffsets,a1
	add.w	d5,d5		; tableau de mots
	move.w	(a1,d5.w),a1	; offset ligne
	adda.l	BmpFb,a1		; frame buffer
	add.w	d3,a1		; ajout x
	movea.l	a1,a4		; a4: index alien dans fb
	moveq	#8-1,d5		; hauteur de l'alien
	mulu	d2,d5		; * le grossisseement
.clrligne	move.w	d4,d6		; d‚compteur de groupes
	movea.l	a1,a2
.clrgrp	clr.l	(a2)+		; 1 groupe 
	clr.l	(a2)+
;	move.l	#$62841423,(a2)+
;	move.l	#$55555550,(a2)+
	dbra	d6,.clrgrp
	lea	160(a1),a1	; ligne suivante
	dbra	d5,.clrligne
	ENDC
	
	; sauve les paramŠtres
	move.w	d0,d5 ; x
	move.w	d1,d6 ; y
	move.w	d2,d7 ; grossissement

	; dessine les points
	move.w	#$f,d0
	jsr	BmpPixelPutMono

	; restaure les paramŠtres
	move.w	d5,d0
	move.w	d6,d1
	move.w	d7,d2
	
	; d‚double les lignes dessin‚es
	subq.w	#1,d2   ; si grossisement 1, on ne d‚double pas
	ble.s	.nozoom
	move.w	d2,d5
	mulu	#160,d7; d7: distance en octets entre 2 lignes de l'alien … copier

	moveq	#8-1,d3 ; d3:MSB=d‚compteur lignes d'alien … copier
.bclddbl	swap	d3 ; boucle sur lignes source
	; copie donn‚es sources dans variables de boucles
	movea.l	a4,a1   ; index ligne source fb
	move.w	d4,d6   ; decompteur de groupes
	
.ddblgrp	; boucle sur les groupes
	move.w	d7,d5   ; ‚cart entre 2 lignes en octets
	move.w	d2,d3   ; d3.LSW: d‚compteur de lignes destination
	move.l	(a1),d0 ; charge les donn‚es du groupe	
	move.l	4(a1),d1

.ddbl1	; boucle sur les lignes destinations pour le groupe
	sub.w	#160,d5
	move.l	d0,(a1,d5.w)
	move.l	d1,4(a1,d5.w)
	
	;bsr .pause
	dbra	d3,.ddbl1 ; fin boucle destinations pour le groupe
	
	addq.l	#8,a1 ; avance tˆte de lecture de groupe dans la ligne source
	dbra	d6,.ddblgrp ; fin boucle groupes
	
	swap	d3
	adda.l	d7,a4 ; ligne alien … copier suivante
	dbra	d3,.bclddbl ; fin boucle lignes source
	
.nozoom		
	rts	


.ali2_relmodel ; ModŠle de l'alien en relatif par rapport … son centre
	; nb points-1, offsetligne, points
.rl_4	dc.w	1, -4, -3, 2
.rl_3	dc.w	1, -3, -2, 1
.rl_2	dc.w	5, -2, -3,-2,-1,0,1,2
.rl_1	dc.w	5, -1, -4,-3,-1,0,2,3
.rl0	dc.w	9,  0, -5,-4,-3,-2,-1,0,1,2,3,4
.rl1	dc.w	7,  1, -5,-3,-2,-1,0,1,2,4
.rl2	dc.w	3,  2, -5,-3,2,4
.rl3	dc.w	1,  3, -2,1
.ali2_rlignes dc.l .rl_4, .rl_3, .rl_2, .rl_1, .rl0, .rl1, .rl2, .rl3

pause 	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#8,-(sp)
	trap	#1
	addq.l	#2,sp
	movem.l	(sp)+,d0-d7/a0-6
	rts



	SECTION BSS
alien_pts	ds.w	40*2*ALIEN_MAX_ZOOM+1 ;34points de (x,y) d‚cupl‚s (facteur maximum) + marqueur de fin
alien_mhi ds.w	1 ; num‚ro de ligne du d‚but du masque (… affacer)
alien_ngp	ds.w	1 ; nombre de groupes de largeur du masque
alien_idx	ds.w	1 ; index de la position de l'alien dans la m‚moire ‚cran
AlienFin	ds.w	1 ; signale la fin de l'animation