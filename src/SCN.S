; GŠre l'‚cran (r‚solutions, m‚moire)

	IFND	FBSIZE
FBSIZE	EQU	32000
	ENDC

	SECTION TEXT

ScnInit:
	lea	scnBlanc,a0
	moveq	#12,d0
.blanc	clr.l	(a0)+
	dbra	d0,.blanc
ScnDeinit
	rts

ScnSet:
	; Passe en r‚solution donn‚e en d0 et assigne nouvelle
	; M‚moire vid‚o pass‚e en a0.
	; L'adresse de la m‚moire ‚cran effective esc conserv‚e en
	; ScnFb. L'ancienne adresse en ScnOlffb
	; TODO: Aligner sur 256 ou 16 bits suivant STf ou STe
	move.b	$ffff8260.w,ScnOldres
	move.b	d0,$ffff8260.w	; Low res

	; M‚moire ‚cran
	move.l	$ffff8200.w,ScnOldfb
	move.l	a0,d0
	add.l	#$ff,d0
	clr.b	d0
	move.l	d0,ScnFb
	lsr.w	#8,d0
	move.l	d0,$ffff8200.w
	rts
	

ScnRestore:
	; Restore
	move.l	ScnOldfb(pc),$ffff8200.w
	move.b	ScnOldres(pc),$ffff8260.w	
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
	lea	$ffff8240.w,a0
	move.w	d3,(a0,d0.w)
	rts

ScnPaletteSetColorSte
	; d0.w num‚ro de couleur
	; d1.w couleur au format STe (rRRR gGGG bBBB) , minuscule: LSb	
	lea	$ffff8240.w,a0
	add.w	d0,d0
	move.w	d1,(a0,d0.w)
	rts

ScnEfface
	; Efface l'‚cran (32000 octets).
	; Ceci fonctionne en utilisant des MOVEM. On utilise le plus
	; de registres possibles, en gardant que d0 comme d‚compteur
	; et a6 comme pointeur vers m‚moire vid‚o. Essay‚ d'utiliser
	; sp mais ‡a marche pas. Je pense si y'a une interruption ‡a
	; empile des trucs et ‡a met la zone. J'ai essay‚ de d‚sactiver 
	; interruptions mais ‡a marchait quand mˆme pas.
	move.l	#FBSIZE/4/13-1,d0
	; Charge les 13 registres
	movem.l	scnBlanc,d1-a5
	movea.l	BmpFb,a6
	adda.w	#32004,a6	; … cause de la pr‚d‚cr‚mentation
.boucle	movem.l	d1-a5,-(a6)	
	dbra	d0,.boucle
	movem.l	d1-d6,-(a6) ; encore 20 octets	
	rts


	SECTION DATA
	EVEN
ScnOldfb	dc.l	1	; Adresse de l'ancienne m‚moire vid‚o
ScnOldres	dc.b	1	; Ancienne r‚solution

	SECTION BSS
	EVEN
ScnFb:	ds.l	1	; Pointeur vers zone m‚moire ‚cran
scnBlanc	ds.l	13	; Tout … 0, pour effacer l'‚cran