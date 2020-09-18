; GŠre l'‚cran (r‚solutions, m‚moire)

	SECTION TEXT

ScnInit:
ScnDeinit:
	rts

ScnSet:
	; Passe en basse r‚solution donn‚e en d0 et assigne nouvelle
	; M‚moire vid‚o
	move.b	$ff8260,ScnOldres
	move.b	d0,$ff8260	; Low res

	; M‚moire ‚cran
	move.l	$ff8200,ScnOldfb
	move.l	#ScnFb,d0
	add.l	#$ff,d0
	clr.b	d0
	move.l	d0,ScnFb
	lsr.w	#8,d0
	move.l	d0,$ff8200
	rts
	

ScnRestore:
	; Restore
	move.l	ScnOldfb(pc),$ff8200
	move.b	ScnOldres(pc),$ff8260	
	rts

	SECTION DATA
	EVEN
ScnOldfb:	dc.l	1	; Adresse de l'ancienne m‚moire vid‚o
ScnOldres: dc.b	1	; Ancienne r‚solution

	SECTION BSS
	EVEN
ScnFb:	ds.l	1	; Pointeur vers zone m‚moire ‚cran
ScnFbbuf:	ds.b	32256	; Pour etre sur d'aligner l'‚cran sur 256 octets
