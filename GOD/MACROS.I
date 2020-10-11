Supexec	MACRO
	pea	\1
	move.w	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	ENDM

Cnecin	MACRO
	move.w	#8,-(sp)
	trap	#1
	addq.l	#2,sp
	ENDM

Pterm0	MACRO
	clr.w	-(sp)
	trap	#1	; Pterm0
	ENDM

Bconstat2	MACRO
	move.w	#2,-(sp)
	move.w	#1,-(sp)
	trap	#13	; Bconstat(2)
	addq.l	#4,sp
	tst.w	d0
	ENDM

Bconin2	MACRO
	move.w	#2,-(sp)
	move.w	#2,-(sp)
	trap	#13	; Bconin(2)
	addq.l	#4,sp
	ENDM

KbdFlush MACRO
.debut\@	
	Bconstat2
	beq.s	.fin\@
	Bconin2
	bra.s	.debut\@
.fin\@
	ENDM



SauvePalette MACRO
	movem.l	$ffff8240,d0-d7
	movem.l	d0-d7,\1
	ENDM

RestaurePalette MACRO
	movem.l	\1,d0-d7
	movem.l	d0-d7,$ffff8240
	ENDM
