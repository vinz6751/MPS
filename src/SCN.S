; GŠre l'‚cran (r‚solutions, m‚moire)

	SECTION TEXT

ScnInit:
ScnDeinit:
	rts

ScnSet:
	; Passe en r‚solution donn‚e en d0 et assigne nouvelle
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

ScnVsyncAndExecute:
	; Attend la VBL et appelle le code en a0
	move.b	$469.w,d0	; dernier octet de _vblclock
.wait	cmp.b	$469.w,d0
	beq.s	.wait
	jmp	(a0)
	
ScnVsync:
	; Attend la VBL
	move.b	$469.w,d0	; dernier octet de _vblclock
.wait	cmp.b	$469.w,d0
	beq.s	.wait
	rts

ScnPaletteSetColorRGB3
	; d0.w: num‚ro de couleur;
	; d1.w,d2.w,d3.w: R,G,B sur 3 bits
	; AltŠre d0-d3/a0
	andi.w	#%111,d3
	lsl.w	#8,d1
	lsl.w	#4,d2
	or.w	d1,d3
	or.w	d2,d3
	add.w	d0,d0
	lea	$ff8240,a0
	move.w	d3,(a0,d0.w)
	rts

ScnPaletteSetColorSte
	; d0.w num‚ro de couleur
	; d1.w couleur au format STe (rRRR gGGG bBBB) , minuscule: LSb	
	lea	$ff8240,a0
	add.w	d0,d0
	move.w	d1,(a0,d0.w)
	rts

	SECTION DATA
	EVEN
ScnOldfb:	dc.l	1	; Adresse de l'ancienne m‚moire vid‚o
ScnOldres: dc.b	1	; Ancienne r‚solution

	SECTION BSS
	EVEN
ScnFb:	ds.l	1	; Pointeur vers zone m‚moire ‚cran
ScnFbbuf:	ds.b	32256	; Pour etre sur d'aligner l'‚cran sur 256 octets
