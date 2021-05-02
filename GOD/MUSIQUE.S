ZIC_FICHIER EQU 1

MusiqueInit
	IFNE ZIC_FICHIER
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
	jsr	zicSnd+8 ; joue la musique
	rts

MusiqueGetZ
	move.b	zicSnd+$b8,d0
	rts
	

	IFEQ ZIC_FICHIER
	SECTION DATA
	EVEN
zicSnd	;INCBIN	"zics\waterdt7.snd"
	INCBIN	"zics\test_zxx.snd"
	EVEN
	
	ELSE 
	
	SECTION DATA
zicFile	dc.b	"zic.snd",0
	EVEN

	SECTION BSS
zicSnd	ds.b	100000

	ENDC