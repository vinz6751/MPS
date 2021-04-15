CUBE3D_DEBUG	EQU 0

	IFNE   CUBE3D_DEBUG
******************** DEBUG *******************

bconstat	EQU 1
bconin	EQU 2
crawcin	EQU 7
CLAVIER	EQU 2

	pea    	cube_main
	move.w	#38,-(sp)
	trap	#14 ; Supexec
	addq.l	#6,sp

	clr.w	-(sp)
	trap	#1
	
	INCLUDE ..\src\scn.s
	INCLUDE ..\src\bitmap.s
	
	SECTION TEXT
cube_main
	move.l	#fb,ScnFb
	
	bsr	ScnInit ;Initialise le module de gestion d'‚cran
	bsr	BmpInit ;Initialise les routines de bitmap
		
	moveq	#0,d0 ; Passe en ST Basse et d‚finit m‚moire vid‚o
	lea	fb,a0
	bsr	ScnSet

	move.l	ScnFb,BmpFb ;Efface l'‚cran
	bsr	ScnEfface

	bsr    Cube3dInit
	

.boucle	move.w #CLAVIER,-(sp)      
	move.w #bconstat,-(sp) ;touche appuy‚e ?
	trap   #13               
	addq.l #4,sp
	tst.w  d0                  

	bne.s  fin
	bsr    Cube3dAnimation              
	bra.s  .boucle
	
fin	bsr    Cube3dDeinit
	bsr    BmpDeinit
	bsr    ScnRestore
	bsr    ScnDeinit
	rts
	SECTION TEXT
	ENDC
********** FIN DU PROG DE DEBUG ***************
	
Cube3dInit:
	;
	move.w #1,cube3d_limiteur

	; Initialisation cube 1	
	lea    cube1,a0
	lea    cube_model,a1
	bsr    init_cube
	lea    cube1,a0
	move.w #48,c_xcenter(a0)
	move.w #LIGNEMY,c_ycenter(a0)
	move.w c_ycenter(a0),c_ycentro(a0)
	move.l #$00040003,c_xspeed(a0)
	move.w #$0004,c_zspeed(a0)
	move.w #1,c_couleur(a0)
	move.w #1,c_efface(a0)
	
	IFNE 1
	; Initialisation cube 2	
	lea    cube2,a0
	lea    cube_model,a1
	bsr    init_cube
	lea    cube2,a0
	move.w #112,c_xcenter(a0)
	move.w #LIGNEMY,c_ycenter(a0)
	move.w c_ycenter(a0),c_ycentro(a0)
	move.w #-4,c_xspeed(a0)
	move.w #3,c_yspeed(a0)
	move.w #3,c_zspeed(a0)
	move.w #7,c_couleur(a0)
	move.w #-1,c_efface(a0)

	; Initialisation cube 3	
	lea    cube3,a0
	lea    cube_model,a1
	bsr    init_cube
	lea    cube3,a0
	move.w #192,c_xcenter(a0)
	move.w #LIGNEMY,c_ycenter(a0)
	move.w c_ycenter(a0),c_ycentro(a0)
	move.w #-3,c_xspeed(a0)
	move.w #-5,c_yspeed(a0)
	move.w #3,c_zspeed(a0)
	move.w #11,c_couleur(a0)
	move.w #-1,c_efface(a0)

	; Initialisation cube 4	
	lea    cube4,a0
	lea    cube_model,a1
	bsr    init_cube
	lea    cube4,a0
	move.w #272,c_xcenter(a0)
	move.w #LIGNEMY,c_ycenter(a0)
	move.w c_ycenter(a0),c_ycentro(a0)
	move.w #4,c_xspeed(a0)
	move.w #3,c_yspeed(a0)
	move.w #-4,c_zspeed(a0)
	move.w #12,c_couleur(a0)
	move.w #1,c_efface(a0)

	ENDC
	
	rts
	
init_cube:
	move.w #160,c_xcenter(a0)
	move.w #100,c_ycenter(a0)
	clr.w  c_x_alpha(a0)
	clr.w  c_y_beta(a0)
	clr.w  c_z_gamma(a0)
	clr.w  c_xspeed(a0)
	clr.w  c_yspeed(a0)
	clr.w  c_zspeed(a0)
	move.w #1,c_couleur(a0) ;Couleur par d‚faut
	
	lea    c_sizeof(a0),a6
	move.l a6,c_oldpts(a0) ;tableau des anciennes coordonn‚es des points
	move.w model_npoints(a1),d1
	move.w d1,c_npoints(a0)
	addq.w #1,d1	   ; c_npoint est le nombre de point -1
	mulu.w #3*2,d1
	adda.w d1,a6
	move.l a6,c_newpts(a0) ;le tableau des nouvelles coordonn‚es suit celui des anciennes

	move.l model_points(a1),c_points(a0)
	move.w model_nlignes(a1),c_nlignes(a0)
	move.l model_lignes(a1),c_lignes(a0)
	
	rts


Cube3dDeinit:
	rts


Cube3dAnimation:
;	subq.w #1,cube3d_limiteur
;	bne.s  .fin
;	move.w #10,cube3d_limiteur
;	clr.b  cube3d_limiteur

	; On ne redessine pas tous les cubes … chaque it‚ration
	; Le cube3d shifter est un mask de bit qu'on fait tourner
	; et … chaque bit correspond un cube. Si le bit est allum‚,
	; on anime le cube correspondant.
	
	move.b cube3d_shifter(pc),d0
	rol.b  #1,d0
	move.b d0,cube3d_shifter
	andi.b #$0f,d0
		
	btst   #0,d0
	beq.s   .skip1
	lea    cube1(pc),a6
	bsr    anime_cube
	bra.s  .fin
.skip1
	btst   #1,d0
	beq.s  .skip2
	lea    cube2(pc),a6
	bsr    anime_cube
	bra.s  .fin
.skip2
	btst   #2,d0
	beq.s  .skip3
	lea    cube3(pc),a6
	bsr    anime_cube
	bra.s  .fin
.skip3
	btst   #3,d0
	beq.s  .skip4
	lea    cube4(pc),a6
	bsr    anime_cube
.skip4	
.fin	rts

anime_cube:
	; Anime le cube en a6
	
	; Vitesse de rotation
	move.w c_xspeed(a6),d3 ;Vitesses de rotation en x, y et z
	move.w c_yspeed(a6),d4 ;...
	move.w c_zspeed(a6),d5 ;...

	; M…j des angles de rotation
	move.w #$00ff,d0
	add.w  d3,c_x_alpha(a6)
	and.w  d0,c_x_alpha(a6)
	add.w  d4,c_y_beta(a6)
	and.w  d0,c_y_beta(a6)
	add.w  d5,c_z_gamma(a6)
	and.w  d0,c_z_gamma(a6)

	* Traitement rotation
	lea     sinus_tab(pc),a0 ;Adresse de la table des sinus
	movea.l c_points(a6),a1  ;Coordonn‚es courantes
	movea.l c_newpts(a6),a2  ;Prochaine position … tracer
	movea.l c_oldpts(a6),a3  ;DerniŠre position trac‚e
	move.w c_npoints(a6),d5  ;Nombre de points … traiter

.calcul	move.w (a1)+,d0         ;x suivant
	move.w (a1)+,d1         ;y suivant
	move.w (a1)+,d2         ;z suivant

	move.l (a2),(a3)+       ; new(x,y,z) -> old
	move.w 4(a2),(a3)+

	;Rotation sur l'axe des X (m…j Y et Z)
.xrotate	move.w c_x_alpha(a6),d7 ;Lecture angle de rotation (0-360)
	move.b (a0,d7.w),d6     ;Lecture sin(alpha)
	move.b 64(a0,d7.w),d7   ;lecture cos(alpha)
	ext.w  d6               ;Extension sur 16 bits
	ext.w  d7               ;...
	move.w d1,d3            ;Copie de y
	move.w d2,d4            ;Copie de z
	muls   d7,d1            ;Calcul y.cos(alpha)
	muls   d6,d4            ;Calcul z.sin(alpha)
	sub.w  d4,d1            ;Calcul y.cos(alpha) - z.sin(alpha)
	asr.w  #7,d1            ;Mise … jour de y --> d1
	muls   d6,d3            ;Calcul y.sin(alpha)
	muls   d7,d2            ;Calcul z.cos(alpha)
	add.w  d3,d2            ;Calcul y.sin(alpha) + z.cos(alpha)
	asr.w  #7,d2            ;Mise … jour de z --> d2

	;Rotation sur l'axe Y (m…j X et Z)
.yrotate	move.w c_y_beta(a6),d7  ;Lecture angle de rotation (0-360)
	move.b 0(a0,d7.w),d6    ;Lecture sin(beta)
	move.b 64(a0,d7.w),d7   ;Lecture cos(beta)
	ext.w  d6               ;Extension de signe
	ext.w  d7               ;... 
	move.w d0,d3            ;Copie de x 
	move.w d2,d4            ;Copie de z
	muls   d7,d0            ;Calcul x.cos(beta)
	muls   d6,d4            ;Calcul z.sin(beta)
	add.w  d4,d0            ;Calcul x.cos(beta) + y.sin(beta)
	asr.w  #7,d0            ;Mise … jour de x --> d0
	muls   d6,d3            ;Calcul x.sin(beta)
	muls   d7,d2            ;Calcul z.cos(beta)
	sub.w  d3,d2            ;Calcul z.cos(beta) - x.sin(beta)
	asr.w  #7,d2            ;Mise … jour de z --> d2

	;Rotation sur l'axe Z (m…j X et Y)
.zrotate	move.w c_z_gamma(a6),d7 ;Lecture angle de rotation (0-360)
	move.b (a0,d7.w),d6     ;Lecture sin(gamma)
	move.b 64(a0,d7.w),d7   ;Lecture cos(gamma)
	ext.w  d6               ;Extension de signe
	ext.w  d7               ;...
	move.w d0,d3            ;Copie de x
	move.w d1,d4            ;Copie de z
	muls   d7,d0            ;Calcul x.cos(gamma)
	muls   d6,d4            ;Calcul y.sin(gamma)
	sub.w  d4,d0            ;Calcul x.cos(gamma) - y.sin(gamma)
	asr.w  #7,d0            ;Mise … jour de x --> d0
	muls   d6,d3            ;Calcul x.sin(gamma)
	muls   d7,d1            ;Calcul y.cos(gamma)
	add.w  d3,d1            ;Calcul x.sin(gamma) + y.cos(gamma)
	asr.w  #7,d1            ;Mise … jour de y --> d1

	move.w c_ycenter(a6),c_ycentro(a6)
	add.w  c_xcenter(a6),d0 ;Offset de centre d'‚cran
	add.w  c_ycenter(a6),d1 ;idem en vertical
	add.w  ligne1y,d1	    ;D‚cale verticalement suivant la bande noire

.update	move.w d0,(a2)+         ;Copie des nouvelles coordonn‚es
	move.w d1,(a2)+           
	move.w d2,(a2)+           

	dbra   d5,.calcul	    ;Calcul pour tous les points...


.clear    ;Efface la figure
	tst.w   c_efface(a6)
	beq.s   .draw
	bsr     efface

.draw    	;Dessine la figure
	movea.l c_newpts(a6),a3    ;Nouvelles coordonn‚es
	lea     linebuf(pc),a0
	move.w  c_couleur(a6),d0
;	addq.b  #1,d0
;	andi.b  #$f,d0
;	move.w  d0,c_couleur(a6)
	bsr     model_draw
          rts


model_draw
	; Dessine le modŠle en a6
	; a3: est la liste de points … utiliser pour le rendu
	; d0: num‚ro de couleur
          lea     c_nlignes(a6),a4   ;D‚but de la liste de lignes
	lea     linebuf(pc),a0
          move.w  (a4)+,d4           ;Nombre-1 de lignes … tracer
	movea.l (a4),a4	       ;Indirection liste de lignes
.drawlp  	move.w  (a4)+,d5           ;Lecture no de point d‚but
          move.l  (a3,d5.w),(a0)     ;Fixe x1 et y1
          move.w  (a4)+,d5           ;Lecture no de point fin
          move.l  (a3,d5.w),4(a0)    ;Fixe x2 et y2
	
          movem.l d0/d4/a0/a3/a4/a6,-(sp)  ;Gestion de la boucle
          jsr     BmpLine            ;Trace la ligne...
          movem.l (sp)+,d0/d4/a0/a3/a4/a6
          dbra    d4,.drawlp
          rts
	
	
efface2	; Efface la zone noire
	move.w	ligne2y,d1
	move.l	a6,-(sp)
	lea	bmpLineYOffsets(pc),a6
	add.w	d1,d1
	move.w	(a6,d1.w),a6
	adda.l	BmpFb(pc),a6
	
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d4
	moveq	#0,d5
	moveq	#0,d6
	moveq	#0,d7
	move.l	d0,a0
	move.l	d0,a1
	move.l	d0,a2
	move.l	d0,a3
	move.l	d0,a4
	move.l	d0,a5 ; 14 registers	
;	REPT	(LIGNE2Y-LIGNE1Y)*160/(14*4)
	REPT	(170-79)*160/(14*4)
	movem.l	d0-d7/a0-a5,-(a6)
	ENDR		
	move.l	(sp)+,a6
	rts

efface	;Efface la figure en a6, carr‚d de 64px de haut
	;Les cubes sont dans des carr‚s de 64 pixels dispos‚s tous
	;les 72 pixels … partir de 16 pixels (16,88,160,232
	; d0.w: x (mod 16 = 0)  d1.w: y  d2.w: nombre de lignes -1
	; Affecte d1-d2/a0-a1
CUBEBOXH	EQU 69
	move.w	c_ycentro(a6),d1
	add.w	ligne1y,d1
	subi.w	#CUBEBOXH/2+2,d1
	lea	bmpLineYOffsets(pc),a1
	add.w	d1,d1		; tableau de mots
	move.w	(a1,d1.w),a1	; offset ligne
	adda.l	BmpFb(pc),a1	; frame buffer
	move.w	c_xcenter(a6),d0
	subi.w	#32,d0	; d‚but de la zone
	andi.w	#$fff0,d0
	lsr.w	#1,d0
	andi.w	#-2,d0	;il faut ˆtre pair pour utiliser .w ou .l
	adda.w	d0,a1	   ;ajout x

	moveq	#0,d0
	move.l	d0,d1
	move.l	d0,d2
	move.l	d0,d3
	move.l	d0,d4
	move.l	d0,d5
	move.l	d0,d6
	move.l	d0,d7
	lea	160*CUBEBOXH+8*4(a1),a1
	REPT	CUBEBOXH
	movem.l	d0-d7,-(a1)
	lea	-160+8*4(a1),a1
	ENDR
	
	rts
		
	
	SECTION   DATA
cube3d_shifter  dc.b %10001000
	EVEN
	
; ------- D‚finition d'une figure ------
	rsreset
c_xcenter	rs.w 1  ;X centre
c_ycenter	rs.w 1  ;Y centre
c_ycentro rs.w 1  ;Y centre ancien
c_couleur	rs.w 1  ;No de couleur
c_efface  rs.w 1  ;Indique s'il faut effacer ou pas avant de dessiner
c_x_alpha rs.w 1  ;Angle axe X
c_y_beta  rs.w 1  ;Angle axe Y
c_z_gamma rs.w 1  ;Angle axe Z
c_zspeed  rs.w 1  ;Vitesse en X
c_xspeed  rs.w 1  ;Vitesse en Y
c_yspeed  rs.w 1  ;Vitesse en Z
c_oldpts	rs.l 1  ;Pointeur vers tableau des anciens points
c_newpts	rs.l 1  ;Pointeur vers tableau des anciens points
;ModŠle
c_npoints rs.w 1  ;Nombre de points -1 composant l'objet
c_points  rs.l 1  ;Pointeur vers tableau de points (x.w,y.w,z.w)
c_nlignes rs.w 1  ;Nombre de lignes -1 reliant les points
c_lignes  rs.l 1  ;Pointeur vers tableau de paires d'index de points … relier
c_sizeof	rs.b 1

* D‚finition d'un modŠle 3D 
	rsreset
model_npoints rs.w 1 ;nombre de points
model_points  rs.l 1 ;pointeur vers tableau de points
model_nlignes rs.w 1 ;nombre de lignes
model_lignes  rs.l 1 ;pointeur vers tableau de lignes

* ModŠle 3D de cube
cube_model 
TCUBE	EQU 18 	;Taille des cot‚s du cube
NPOINTS	EQU 8 	;Nb de points
NLIGNES	EQU 12 	;Nb de lignes
.model:	dc.w NPOINTS-1
	dc.l .points
	dc.w NLIGNES-1
	dc.l .lignes
.points	dc.w -TCUBE,-TCUBE,-TCUBE        point 0
          dc.w TCUBE,-TCUBE,-TCUBE         point 1
          dc.w TCUBE,TCUBE,-TCUBE          point 2
          dc.w -TCUBE,TCUBE,-TCUBE         ...
          dc.w -TCUBE,-TCUBE,TCUBE
          dc.w TCUBE,-TCUBE,TCUBE
          dc.w TCUBE,TCUBE,TCUBE
          dc.w -TCUBE,TCUBE,TCUBE
.lignes   ; Table de tracage des lignes: offset point de depart, offset point d'arriv‚e
	dc.w  0*6,1*6 Joindre point 0 … 1
	dc.w  1*6,2*6 ;1 … 2
	dc.w  2*6,3*6 ;2 … 3
	dc.w  3*6,0*6 ;3 … 0
	dc.w  4*6,5*6 ;4 … 5
	dc.w  5*6,6*6 ;5 … 6
	dc.w  6*6,7*6 ;6 … 7
	dc.w  7*6,4*6 ;7 … 4
	dc.w  0*6,4*6 ;0 … 4
	dc.w  1*6,5*6 ;1 … 5
	dc.w  2*6,6*6 ;2 … 6
	dc.w  3*6,7*6 ;3 … 7

* Table sinus/cosinus
* Valeurs sign‚es et mises … l'‚chelle
* 360 degr‚s <---> $FF  

sinus_tab
	dc.b  $00,$03,$06,$09,$0C,$0F,$12,$15   
	dc.b  $18,$1B,$1E,$21,$24,$27,$2A,$2D   
	dc.b  $30,$33,$36,$39,$3B,$3E,$41,$43   22 … 32 degr‚s
	dc.b  $46,$49,$4B,$4E,$50,$52,$55,$57   
	dc.b  $59,$5B,$5E,$60,$62,$64,$66,$67   
	dc.b  $69,$6B,$6C,$6E,$70,$71,$72,$74   56 … 66 degr‚s
	dc.b  $75,$76,$77,$78,$79,$7A,$7B,$7B   
	dc.b  $7C,$7D,$7D,$7E,$7E,$7E,$7E,$7E   
	dc.b  $7E,$7E,$7E,$7E,$7E,$7E,$7D,$7D   90 … 100 degr‚s
	dc.b  $7C,$7B,$7B,$7A,$79,$78,$77,$76   
	dc.b  $75,$74,$72,$71,$70,$6E,$6C,$6B   
	dc.b  $69,$67,$66,$64,$62,$60,$5E,$5B   124 … 134 degr‚s
	dc.b  $59,$57,$55,$52,$50,$4E,$4B,$49   
	dc.b  $46,$43,$41,$3E,$3B,$39,$36,$33   
	dc.b  $30,$2D,$2A,$27,$24,$21,$1E,$1B   158 … 168 degr‚s
	dc.b  $18,$15,$12,$0F,$0C,$09,$06,$03   
	dc.b  $00,$FD,$FA,$F7,$F4,$F1,$EE,$EB   
	dc.b  $E8,$E5,$E2,$DF,$DC,$D9,$D6,$D3   190 … 200 degr‚s
	dc.b  $D0,$CD,$CA,$C7,$C5,$C2,$BF,$BD   
	dc.b  $BA,$B7,$B5,$B2,$B0,$AE,$AB,$A9   
	dc.b  $A7,$A5,$A2,$A0,$9E,$9C,$9A,$99   225 … 235 degr‚s
	dc.b  $97,$95,$94,$92,$90,$8F,$8E,$8C   
	dc.b  $8B,$8A,$89,$88,$87,$86,$85,$85   
	dc.b  $84,$83,$83,$82,$82,$82,$82,$82   259 … 269 degr‚s
	dc.b  $82,$82,$82,$82,$82,$82,$83,$83   
	dc.b  $84,$85,$85,$86,$87,$88,$89,$8A   
	dc.b  $8B,$8C,$8E,$8F,$90,$92,$94,$95   293 … 303 degr‚s
	dc.b  $97,$99,$9A,$9C,$9E,$A0,$A2,$A5   
	dc.b  $A7,$A9,$AB,$AE,$B0,$B2,$B5,$B7   
	dc.b  $BA,$BD,$BF,$C2,$C5,$C7,$CA,$CD   327 … 337 degr‚s
	dc.b  $D0,$D3,$D6,$D9,$DC,$DF,$E2,$E5   
	dc.b  $E8,$EB,$EE,$F1,$F4,$F7,$FA,$FD   350 … 360 degr‚s

cosinus	dc.b  $00,$03,$06,$09,$0C,$0F,$12,$15   0 … 10 degr‚s
	dc.b  $18,$1B,$1E,$21,$24,$27,$2A,$2D   
	dc.b  $30,$33,$36,$39,$3B,$3E,$41,$43   
	dc.b  $46,$49,$4B,$4E,$50,$52,$55,$57   
	dc.b  $59,$5B,$5E,$60,$62,$64,$66,$67   46 … 56 degr‚s
	dc.b  $69,$6B,$6C,$6E,$70,$71,$72,$74   
	dc.b  $75,$76,$77,$78,$79,$7A,$7B,$7B   
	dc.b  $7C,$7D,$7D,$7E,$7E,$7E,$7E,$7E   80 … 90 degr‚s

	EVEN

cubes	dc.l  cube1,cube2,cube3,cube4

	  SECTION BSS
linebuf	  ds.w  4         ;x1,y1,x2,y2 pour BmpLine

cube1	  ds.b  c_sizeof
	EVEN
cube1ptsbuf ds.w  NPOINTS*3*2

cube2	  ds.b  c_sizeof
cube2ptsbuf ds.w  NPOINTS*3*2

cube3	  ds.b  c_sizeof
cube3ptsbuf ds.w  NPOINTS*3*2

cube4	  ds.b  c_sizeof
	EVEN
cube4ptsbuf ds.w  NPOINTS*3*2

cube3d_limiteur ds.w 1 

	IFNE CUBE3D_DEBUG
; pour le debug
fb	ds.b  32000+256
	ENDC
