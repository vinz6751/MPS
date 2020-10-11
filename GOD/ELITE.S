	SECTION TEXT
EliteInit
	move.w	Elite_xe2,d0
	move.w	Elite_ye2,d1
	move.w	#42,d2
	lea	elitE,a0
	jsr	BlitL32
	rts

EliteAnimation
	move.w	Elite_xl,d0
	move.w	Elite_yl,d1
	move.w	#44,d2
	lea	eLite,a0
	jsr	BlitL32

	move.w	Elite_xi,d0
	move.w	Elite_yi,d1
	move.w	#39,d2
	lea	elIte,a0
	jsr	BlitL32

	move.w	Elite_xt,d0
	move.w	Elite_yt,d1
	move.w	#34,d2
	lea	eliTe,a0
	jsr	BlitL32

	; elitE
	move.w	Elite_dye2,d4
	move.w	Elite_ye2,d3
	bgt.s	.ye2nomin
	clr.w	d3		; y minimum = 0
	neg.w	d4		; repart dans l'autre sens
	bra.s	.ye2ok
.ye2nomin
	cmp.w	#YRES-1-43,d3	; y max
	blt.s	.ye2ok
	move.w	#YRES-1-43,d3
	neg.w	d4		; repart vers le haut
.ye2ok	tst.w	d4		; suivant le sign du delta on monte ou descend
	bmi.s	.ye2down
	lea	BlitShiftDown32_1px,a2
	bra.s	.ye2dessine
.ye2down
	lea	BlitShiftUp32_1px,a2
.ye2dessine
	move.w	Elite_xe2,d0	; Trouve l'adresse du bloc (on pourrait la garder !)
	ext.l	d0
	move.w	Elite_ye2(pc),d1
	jsr	BlitCalcOffset
	move.l	d0,a0
	move.w	#42,d2
	jsr	(a2)
	add.w	d4,Elite_ye2
	move.w	d4,Elite_dye2
.skip_ye2

	; Animation du Elite
	move.w	Elite_ye,d0
	add.w	Elite_dye,d0
	bpl.s	.notymin
	neg.w	Elite_dye
	clr.w	d0
.notymin
	cmpi.w	#YRES-1-39,d0
	blt.s	.notymax
	neg.w	Elite_dye
.notymax
	move.w	d0,Elite_ye
	bsr	EliteDessineE

	rts

EliteDessineE
	move.w	Elite_xe,d0
	move.w	Elite_ye,d1
	move.w	#38,d2
	lea	Elite,a0
	jsr	BlitL32
	rts

	SECTION DATA
ElitePalette	INCBIN	elite\palette.bin
Elite	INCBIN	elite\e.bin
eLite	INCBIN	elite\l.bin
elIte	INCBIN	elite\i.bin
eliTe	INCBIN	elite\t.bin
elitE	INCBIN	elite\e2.bin

Elite_xe	dc.w	8
Elite_dxe	dc.w	8
Elite_dye	dc.w	1
Elite_ye	dc.w	80
Elite_xl	dc.w	32
Elite_yl	dc.w	80
Elite_xi	dc.w	64
Elite_yi	dc.w	80
Elite_xt	dc.w	96
Elite_yt	dc.w	80
Elite_xe2	dc.w	120
Elite_ye2	dc.w	80
Elite_dye2	dc.w	1
