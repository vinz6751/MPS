; Macros BIOS/XBIOS/GEMDOS et utilitaires
; Vinz/MPS

Supexec	MACRO
	pea	\1
	move.w	#38,-(sp)
	trap	#14
	addq.l	#6,sp
	ENDM

Cconout	MACRO
	move.w	\1,-(sp)
	move.w	#2,-(sp)
	trap	#1
	addq.l	#4,sp
	ENDM

Cnecin	MACRO
	move.w	#8,-(sp)
	trap	#1
	addq.l	#2,sp
	ENDM

Cconws	MACRO
	move.l	\1,-(sp)
	move.w	#9,-(sp)
	trap	#1
	addq.l	#6,sp
	ENDM

Cconis	MACRO
	move.w	#11,-(sp)
	trap	#1
	addq.l	#2,sp
	ENDM

Fopen	MACRO
	move.w	#0,-(sp)	; Read only
	pea	\1
	move.w	#61,-(sp)
	trap	#1
	addq.l	#8,sp
	ENDM
	
Fdelete	MACRO
	pea	\1
	move.w	#65,-(sp)
	trap	#1
	addq.l	#6,sp
	ENDM

Fseek	MACRO
	move.w	\3,-(sp)
	move.w	\2,-(sp)
	move.l	\1,-(sp)
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp
	ENDM

Fcreate	MACRO
	move.w	#0,-(sp)
	pea	\1
	move.w	#60,-(sp)	; Fcreate
	trap	#1
	addq.l	#8,sp
	ENDM

Fwrite	MACRO
	pea	\3
	move.l	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#64,-(sp)	; Fwrite
	trap	#1
	lea.l	12(sp),sp
	ENDM

Fread	MACRO
	pea	\3
	move.l	\2,-(sp)
	move.w	\1,-(sp)
	move.w	#63,-(sp)	; Fread
	trap	#1
	lea.l	12(sp),sp
	ENDM

Fclose	MACRO
	move.w	\1,-(sp)
	move.w	#62,-(sp)
	trap	#1
	addq.l	#4,sp
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
	Cconis
	tst.w	d0
	beq.s	.fin\@
	Cnecin
	bra.s	.debut\@
.fin\@
	ENDM



SauvePalette MACRO
	movem.l	$ffff8240.w,d0-d7
	movem.l	d0-d7,\1
	ENDM

RestaurePalette MACRO
	movem.l	\1,d0-d7
	movem.l	d0-d7,$ffff8240.w
	ENDM