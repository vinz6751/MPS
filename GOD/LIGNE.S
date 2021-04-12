	SECTION TEXT
LIGNE1Y	EQU	79
LIGNE2Y	EQU	170
LIGNEMY	EQU	(LIGNE2Y-LIGNE1Y)/2
LIGNE_RALENTISSEUR EQU 7
	
LigneInit:
	; pr‚paration ligne 1
	; puisqu'on va utiliser des movems x,-(ay) pour copier la ligne
	; il faut lire les groupes de registres de droite … gauche
	lea	ligne1,a0
	move.l	(a0)+,ligne1_1
	movem.l	(a0)+,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,ligne1_2
	movem.l	(a0)+,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,ligne1_3
	movem.l	(a0)+,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,ligne1_4
	rts

LigneAnimation:
;	subi.w	#1,ligneralentisseur
;	beq.s	.fait
;	rts	
;.fait	move.w	#LIGNE_RALENTISSEUR,ligneralentisseur

	; Calcule nouveau y de la ligne avec sinus
	lea 	sinus_tab,a0 ; dans les cube3d.s
	move.w	ligneh_angle,d2
	move.b	(a0,d2.w),d1
	ext.w	d1
	asr.w	#3,d1 ; r‚duit l'amplitude … 8
	addi.w	#LIGNE1Y,d1
	; pr‚pare prochaine it‚ration
	addq.b	#2,d2
	move.w	d2,ligneh_angle
	move.w	ligne1yold(pc),d0
	move.w	d1,ligne1yold
	cmp.w	d2,d1
	beq.s	.nodraw1 ; pas la peine de redessiner si nouveau y = ancien

	move.w	d0,-(sp)   ; sauve d0 (ancienne position)
	move.w	d1,ligne1y ; sauve d1 (nouvelle position)

	bsr	BmpClearLineStLow ; efface ancienne position
	move.w	ligne1y(pc),d1
	bsr.s	.dessine ; dessine la nouvelle

	; efface la ligne du bas
	move.w	(sp),d0
	addi.w	#LIGNE2Y-LIGNE1Y,d0
	bsr	BmpClearLineStLow ; efface anciene position
	move.w	ligne1y(pc),d1
	addi.w	#LIGNE2Y-LIGNE1Y,d1
	move.w	d1,ligne2y
	bsr.s	.dessine ; dessine la nouvelle
	addq.l	#2,sp
.nodraw1

	rts
	

.dessine	; dessine la ligne dont le y est en d1.w
	lea 	bmpLineYOffsets,a1
	addq.w	#1,d1 ; on commence sur la ligne suivante … cause de la pr‚d‚cr‚mentation
	add.w	d1,d1 ; facteur d'‚chelle
	movea	(a1,d1.w),a1 
	adda.l	BmpFb,a1
		
	lea	ligne1_4,a0
	movem.l	(a0)+,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,-(a1)
	movem.l	ligne1_3,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,-(a1)
	movem.l	ligne1_2,d0-d7/a2-a6
	movem.l	d0-d7/a2-a6,-(a1)
	move.l	ligne1_1,-(a1)	
	rts
ligneh_angle dc.w	0 ; angle pour table des sinus
ligne1yold dc.w	LIGNE1Y ; ancien y (… effacer)
ligne1y	dc.w	LIGNE1Y
ligne2y	dc.w	LIGNE2Y
ligneralentisseur dc.w LIGNE_RALENTISSEUR
	
	SECTION DATA
ligne1	INCBIN "elite\line1.bmp"
;ligne2	INCBIN "elite\line2.bmp"

	SECTION BSS
	EVEN
ligne1_4	ds.w	13*4
ligne1_3	ds.w	13*4
ligne1_2	ds.w	13*4
ligne1_1	ds.w	4
