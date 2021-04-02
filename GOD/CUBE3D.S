Vsync	MACRO
	move.w #37,-(sp)
	trap   #14 ; Vsync
	addq.l #2,sp
	ENDM

gemdos	EQU 1
bios	EQU 13
xbios	EQU 14

pterm	EQU $4C

bconstat	EQU 1
bconin	EQU 2
crawcin	EQU 7

CLAVIER	EQU 2

* D‚but
CUBE3D_DEBUG	EQU 1

	IFNE   CUBE3D_DEBUG
******************** DEBUG *******************
	pea    cube_main
	move.w	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	clr.w	-(sp)
	trap	#1
	
	INCLUDE ..\src\scn.s
	INCLUDE ..\src\bitmap.s
	
	SECTION TEXT
cube_main
	move.l	#fb,ScnFb
	
	bsr	ScnInit
	bsr	BmpInit
		
	moveq	#0,d0
	lea	fb,a0
	bsr	ScnSet

	move.l	ScnFb,BmpFb
	bsr	ScnEfface


	bsr    Cube3dInit
	

.boucle	move.w #CLAVIER,-(sp)      
	move.w #bconstat,-(sp) ;touche appuy‚e ?
	trap   #bios               
	addq.l #4,sp
	tst.w  d0                  

	bne.s  .fin
	bsr    Cube3dAnimation              
	bra.s  .boucle
	
.fin	bsr    Cube3dDeinit
	bsr    BmpDeinit
	bsr    ScnDeinit
	rts
	SECTION TEXT
	ENDC
********** FIN DU PROG DE DEBUG ***************
	
Cube3dInit:	
	move.w #160,xcenter
	move.w #100,ycenter
	rts

Cube3dDeinit:
	rts


Cube3dAnimation:

TCUBE	EQU 15 ;Taille du cube
NPOINTS	EQU 18 ;Nb de points
NLIGNES	EQU 12 ;Nb de lignes
 
	; Vitesse de rotation
	move.w xspeed(pc),d3 ;Vitesses de rotation en x, y et z
	move.w yspeed(pc),d4 ;...
	move.w zspeed(pc),d5 ;...

	; M…j des angles de rotation
	move.w #$00ff,d0
	add.w  d3,x_alpha
	and.w  d0,x_alpha
	add.w  d4,y_beta
	and.w  d0,y_beta
	add.w  d5,z_gamma
	and.w  d0,z_gamma

	* Traitement rotation
	lea    sinus_tab(pc),a0 ;Adresse de la table des sinus
	lea    xyz(pc),a1       ;Coordonn‚es courantes
	lea    newxyz(pc),a2    ;DerniŠre position trac‚e
	lea    oldxyz(pc),a3    ;Prochaine position … tracer

	move.w (a1)+,d5         ;Nombre de points … traiter
calcul	move.w (a1)+,d0         ;x suivant
	move.w (a1)+,d1         ;y suivant
	move.w (a1)+,d2         ;z suivant

	move.l (a2),(a3)+       ; new(x,y,z) -> old
	move.w 4(a2),(a3)+

	;Rotation sur l'axe des X (m…j Y et Z)
xrotate	move.w x_alpha,d7       ;Lecture angle de rotation (0-360)
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
yrotate	move.w y_beta,d7        ;Lecture angle de rotation (0-360)
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
zrotate	move.w z_gamma,d7       ;Lecture angle de rotation (0-360)
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

	add.w  xcenter,d0       ;Offset de centre d'‚cran
	add.w  ycenter,d1       ;idem en vertical

update	move.w d0,(a2)+         ;Copie des nouvelles coordonn‚es
	move.w d1,(a2)+           
	move.w d2,(a2)+           

	dbra    d5,calcul	    ;Calcul pour tous les points...


clear    	;Efface la figure
	lea     oldxyz,a3          ;Nouvelles coordonn‚es
          lea     line_list,a4       ;D‚but de la liste de lignes
	lea     linebuf,a0
	clr.w   d0	       ;Couleur du fond
          move.w  (a4)+,d4           ;Nombre-1 de lignes … tracer
.drawlp  	move.w  (a4)+,d5           ;Lecture no de point d‚but
          move.l  (a3,d5.w),(a0)     ;Fixe x1 et y1
          move.w  (a4)+,d5           ;Lecture no de point fin
          move.l  (a3,d5.w),4(a0)    ;Fixe x2 et y2
          movem.l d0/d4/a0/a3/a4,-(sp)  ;Gestion de la boucle
          jsr     BmpLine            ;Trace la ligne...
          movem.l (sp)+,d0/d4/a0/a3/a4
          dbra    d4,.drawlp

draw    	;Dessine la figure
	lea     newxyz,a3          ;Nouvelles coordonn‚es
          lea     line_list,a4       ;D‚but de la liste de lignes
	lea     linebuf,a0
	moveq   #2,d0
          move.w  (a4)+,d4           ;Nombre-1 de lignes … tracer
.drawlp  	move.w  (a4)+,d5           ;Lecture no de point d‚but
          move.l  (a3,d5.w),(a0)     ;Fixe x1 et y1
          move.w  (a4)+,d5           ;Lecture no de point fin
          move.l  (a3,d5.w),4(a0)    ;Fixe x2 et y2
          movem.l d0/d4/a0/a3/a4,-(sp)  ;Gestion de la boucle
          jsr     BmpLine            ;Trace la ligne...
          movem.l (sp)+,d0/d4/a0/a3/a4
          dbra    d4,.drawlp

          rts

	SECTION   DATA
fillptr   dc.w -1 ;Motif de remplissage (noir)

x_alpha   dc.w 0 ;Angle axe X
y_beta    dc.w 0 ;Angle axe Y
z_gamma   dc.w 0 ;Angle axe Z

zspeed    dc.w 2 ;Vitesse en X
xspeed    dc.w 2 ;Vitesse en Y
yspeed    dc.w 2 ;Vitesse en Z

* D‚finition de l'image 3D … traiter: 
* nombre de points.w
* liste de points (3*w par point)

xyz       dc.w NPOINTS-1 ;Nombre-1 de points … traiter
	dc.w -TCUBE,-TCUBE,-TCUBE        point 0
          dc.w TCUBE,-TCUBE,-TCUBE         point 1
          dc.w TCUBE,TCUBE,-TCUBE          point 2
          dc.w -TCUBE,TCUBE,-TCUBE         ...
          dc.w -TCUBE,-TCUBE,TCUBE
          dc.w TCUBE,-TCUBE,TCUBE
          dc.w TCUBE,TCUBE,TCUBE
          dc.w -TCUBE,TCUBE,TCUBE
* Table de tracage des lignes
* offset point de depart, offset point d'arriv‚e
line_list dc.w  12-1 ;Nombre-1 de lignes … tracer
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

	SECTION   BSS
xcenter	ds.w  160	      ;R‚f‚rence X de la figure
ycenter	ds.w  100	      ;R‚f‚rence Y de la figure
oldxyz	ds.w  NPOINTS*3 ;Anciennes coordonn‚es     
newxyz	ds.w  NPOINTS*3 ;Nouvelles coordonn‚es  
linebuf	ds.w  4         ;x1,y1,x2,y2 pour BmpLine
; pour le debug
fb	ds.b  32000+256
