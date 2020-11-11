MusiqueInit
	jsr	zicSnd	; Init
	rts
	
MusiqueDeinit
	jsr	zicSnd+4
	rts

MusiqueAnimation
	jsr	zicSnd+8 ; joue la musique
	rts

	SECTION DATA
	EVEN
zicSnd	INCBIN	.\ZICS\discord2.snd   ;test_zxx.snd
