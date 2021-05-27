ZIC_DEBUG	   EQU 1 ; MusiqueZKey pour contr“ller Z avec le clavier
ZIC_TEST	   EQU 0 ; programme de test
ZIC_HANDLERS EQU 1 ; appelle les vrais handlers de Z
ZIC_FICHIER  EQU 1 ; charge zic.snd plut“t que le fichier int‚gr‚

	
	SECTION TEXT
************ PROGRAMME DE TEST ***********	
	IFNE ZIC_TEST
	INCLUDE macros.i

	Supexec	zictest
	Pterm0
zictest	
	bsr	MusiqueInit
	move.l	$70.w,oldVbl
	move.l	#.vbl,$70.w
.loop	Cconis
	tst.w	d0
	beq.s	.nokey
	Cnecin
	cmp.b	#' ',d0
	beq.s	.exit
	bsr	MusiqueZKey
	bsr	MusiqueZ
.nokey	bra.s	.loop
.exit	move.l	oldVbl,$70.w
	bsr	MusiqueDeinit
	rts

.vbl	bsr	MusiqueAnimation
	move.l	oldVbl(pc),-(sp)
	rts	

oldVbl	dc.l	0
	ENDC
************ FIN DU PROGRAMME DE TEST ***********	


	EVEN
MusiqueInit
	IFNE ZIC_FICHIER
	; Charle la musique depuis zic.snd
	clr.w	-(sp)
	pea	zicFile
	move.w	#61,-(sp)
	trap	#1 ; FOpen
	addq.l	#8,sp
	
	tst.w	d0
	move.l	d0,d7
	bmi.s	.inced
	
	pea	zicSnd
	move.l	#100000,-(sp)
	move.w	d7,-(sp)
	move.w	#63,-(sp)
	trap	#1 ; Fread
	lea	12(sp),sp
	
	move.w	d7,-(sp)
	move.w	#62,-(sp)
	trap	#1 ; Fclose
	addq.l	#4,sp	
	ENDC
	
.inced	jsr	zicSnd	; Init

	rts

	
MusiqueDeinit
	jsr	zicSnd+4
	rts


MusiqueAnimation
	jmp	zicSnd+8 ; joue la musique


	IFNE ZIC_DEBUG
	; pour le d‚bug a = Z01, b=Z02 etc.
MusiqueZKey
	cmp.b	#'A',d0
	blt.s	.notz
	cmp.b	#'Z',d0
	bgt.s	.minusc
	subi.b	#38,d0 ; A -> 27
	bra.s	.doZ
.minusc	cmp.b	#'a',d0
	blt.s	.notz
	cmp.b	#'{',d0
	bgt.s	.notz
	subi.b	#'a',d0
.doZ	move.b	d0,zicSnd+$b8
.notz	rts
	ENDC

MusiqueZ ; Traite les codes de synchro
	clr.l	d3
	move.b	zicSnd+$b8,d3
	cmp.b	zicZ,d3
	beq.s	.rts ; si inchang‚, on fait rien
	move.b	d3,zicZ

	; Appelle le gestionnaire de Z	
	add.l	d3,d3
	add.l	d3,d3
	lea	zHandlers,a3
	move.l	(a3,d3.w),a3
	cmpa.l	#0,a3
	beq.s	.rts; Z pas g‚r‚
	jmp	(a3)
.rts	rts


zHandlers	dc.l	0
	dc.l	EliteBump
	dc.l	zLogoStart
	dc.l	zLogoStop
	dc.l	0 ; 4
	dc.l	zCube1ClrNext, zCube2ClrNext, zCube3ClrNext, zCube4ClrNext ; 5-8 
	dc.l	zCubeAllBlanc   ; 9 
	dc.l	zCubeClrRestore ; 10
	dc.l 	zCube1Inv, zCube2Inv, zCube3Inv, zCube4Inv ; 11-14
	dc.l	zCubeAllInv ; 15
	dc.l	zFlash      ; 16
	dc.l	zScrollOn   ; 17
	dc.l	zScrollOff  ; 18
	dc.l	zLigneOn    ; 19
	dc.l	zLigneOff   ; 20
	dc.l	zFinTexte,0,0,zFinIntro   ; 21-24
	dc.l	zAlien
	dc.l	zFinIntro	
	dc.l 	zCube1Stop, zCube2Stop, zCube3Stop, zCube4Stop ;27-30
	dc.l	zCubeAllStop ; 31
	dc.l	zCube1RotReset, zCube2RotReset, zCube3RotReset, zCube4RotReset ;32-35
	dc.l	zCubeAllRotReset ; 36
	dc.l	zCubeSpdReset ; 37
	
zLogoStart
	move.w	#-1,LogoOnOff
	move.w	#-1,logoRun
	rts

zLogoStop	clr.w	LogoOnOff
	rts

zScrollOn	move.w	#-1,ScrollOnOff
	rts

zScrollOff clr.w	ScrollOnOff
	rts

zLigneOn	move.w	#-1,LigneOnOff
	rts

zLigneOff	clr.w	LigneOnOff
	rts

zCube1Inv	lea	cube1,a0	
	jmp	CubeInverseRotation	

zCube2Inv	lea	cube2,a0	
	jmp	CubeInverseRotation
	
zCube3Inv	lea	cube3,a0	
	jmp	CubeInverseRotation

zCube4Inv	lea	cube4,a0	
	jmp	CubeInverseRotation

zCubeAllInv ; Inverse le sense de rotation des cubes
	lea	cube1,a0
	jsr	CubeInverseRotation
	lea	cube2,a0
	jsr	CubeInverseRotation
	lea	cube3,a0
	jsr	CubeInverseRotation
	lea	cube4,a0
	jmp	CubeInverseRotation

zCube1Stop lea 	cube1,a0
	bra	CubeStop
zCube2Stop lea	cube2,a0
	bra	CubeStop
zCube3Stop lea	cube3,a0
	bra	CubeStop
zCube4Stop lea	cube4,a0
	bra	CubeStop
zCubeAllStop
	bsr	zCube1Stop
	bsr	zCube2Stop
	bsr	zCube3Stop
	bra	zCube4Stop
CubeStop	; stoppe la rotation du cube en a0
	clr.w	c_xspeed(a0)
	clr.w	c_yspeed(a0)
	clr.w	c_zspeed(a0)
	rts

zCube1RotReset
	lea	cube1,a0
	bra	zCubeRotReset
zCube2RotReset
	lea	cube2,a0
	bra	zCubeRotReset
zCube3RotReset
	lea	cube3,a0
	bra	zCubeRotReset
zCube4RotReset
	lea	cube4,a0
	bra	zCubeRotReset
zCubeAllRotReset ; reset les angles de tous les cubes
	bsr	zCube1RotReset
	bsr	zCube2RotReset
	bsr	zCube3RotReset
	bra	zCube4RotReset	
zCubeRotReset ; reset les angles de rotation d'un cube en a0
	clr.w	c_x_alpha(a0)
	clr.w	c_y_beta(a0)
	clr.w	c_z_gamma(a0)
	rts
		
zCubeSpdReset ; r‚initialise la vitesse de rotation des cubes
	lea	cube1,a0
	move.l #$00040003,c_xspeed(a0)
	move.w #$0004,c_zspeed(a0)
	lea	cube2,a0
	move.w #-4,c_xspeed(a0)
	move.w #3,c_yspeed(a0)
	move.w #3,c_zspeed(a0)
	lea	cube3,a0
	move.w #-3,c_xspeed(a0)
	move.w #-4,c_yspeed(a0)
	move.w #3,c_zspeed(a0)
	lea	cube4,a0
	move.w #4,c_xspeed(a0)
	move.w #3,c_yspeed(a0)
	move.w #-4,c_zspeed(a0)
	rts			


zCubeClrRestore ; Restore les couleurs d'origine des cubes
	lea	cube1,a0
	move.w	#1,c_couleur(a0)
	lea	cube2,a0
	move.w	#7,c_couleur(a0)
	lea	cube3,a0
	move.w	#11,c_couleur(a0)
	lea	cube4,a0
	move.w	#12,c_couleur(a0)
	rts

zCube1ClrNext ; Change la couleur du cube
	lea	cube1,a1
	bra.s	zCubeClrNext
	
zCube2ClrNext ; Change la couleur du cube
	lea	cube2,a1
	bra.s	zCubeClrNext

zCube3ClrNext ; Change la couleur du cube
	lea	cube3,a1
	bra.s	zCubeClrNext

zCube4ClrNext ; Change la couleur du cube
	lea	cube4,a1
	bra.s	zCubeClrNext

zCubeClrNext ; Change la couleur du cube en a1
	move.w	c_couleur(a1),d1
	addq.w	#1,d1
	andi.w	#$f,d1
	beq.s	.skip
	cmp.w	#4,d1 ; 0, 4 et 9 sont trop sombres
	beq.s	.skip
	cmp.w	#9,d1
	beq.s	.skip
	bra.s	.done
.skip	moveq	#1,d1 ; prend la couleur suivante
.done	move.w	d1,c_couleur(a1)
	rts
	
zCubeAllBlanc ; Met tous les cubes en blanc
	moveq	#$3,d0
	lea	cube1,a0
	move.w	d0,c_couleur(a0)
	lea	cube2,a0
	move.w	d0,c_couleur(a0)
	lea	cube3,a0
	move.w	d0,c_couleur(a0)
	lea	cube4,a0
	move.w	d0,c_couleur(a0)
	rts
	
zFinIntro	move.w	#-1,IntroFinie
	rts

zFinTexte	move.w	#-1,TxtFini
	rts
	
zFlash	bra	FlashNow

zAlien	move.w	#-1,IntroZoomAlien
	rts


	IFEQ ZIC_FICHIER
	SECTION DATA
	EVEN
zicSnd	INCBIN	"zics\waterdt2.snd"
	;INCBIN	"zics\test_zxx.snd"
	EVEN
	
	ELSE 
	
	SECTION DATA
zicFile	dc.b	"zic.snd",0
	EVEN

	SECTION BSS
zicSnd	ds.b	100000
	ENDC
	SECTION BSS
zicZ	ds.b	1 ; dernier Z d‚tect‚
