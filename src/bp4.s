	TEXT
.c0b0:		andi.l	#$7FFF7FFF,(a3)
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c1b0:		andi.l	#$BFFFBFFF,(a3)
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2b0:		andi.l	#$DFFFDFFF,(a3)
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3b0:		andi.l	#$EFFFEFFF,(a3)
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c4b0:		andi.l	#$F7FFF7FF,(a3)
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c5b0:		andi.l	#$FBFFFBFF,(a3)
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c6b0:		andi.l	#$FDFFFDFF,(a3)
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c7b0:		andi.l	#$FEFFFEFF,(a3)
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c8b0:		andi.l	#$FF7FFF7F,(a3)
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c9b0:		andi.l	#$FFBFFFBF,(a3)
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.cAb0:		andi.l	#$FFDFFFDF,(a3)
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.cBb0:		andi.l	#$FFEFFFEF,(a3)
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.cCb0:		andi.l	#$FFF7FFF7,(a3)
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.cDb0:		andi.l	#$FFFBFFFB,(a3)
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.cEb0:		andi.l	#$FFFDFFFD,(a3)
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.cFb0:		andi.l	#$FFFEFFFE,(a3)
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c0b1:		andi.l	#$7FFF7FFF,(a3)
	andi.w	#$7FFF,4(a3)
	ori.w	#$8000,6(a3)
	bra   .loop
.c1b1:		andi.l	#$BFFFBFFF,(a3)
	andi.w	#$BFFF,4(a3)
	ori.w	#$4000,6(a3)
	bra   .loop
.c2b1:		andi.l	#$DFFFDFFF,(a3)
	andi.w	#$DFFF,4(a3)
	ori.w	#$2000,6(a3)
	bra   .loop
.c3b1:		andi.l	#$EFFFEFFF,(a3)
	andi.w	#$EFFF,4(a3)
	ori.w	#$1000,6(a3)
	bra   .loop
.c4b1:		andi.l	#$F7FFF7FF,(a3)
	andi.w	#$F7FF,4(a3)
	ori.w	#$800,6(a3)
	bra   .loop
.c5b1:		andi.l	#$FBFFFBFF,(a3)
	andi.w	#$FBFF,4(a3)
	ori.w	#$400,6(a3)
	bra   .loop
.c6b1:		andi.l	#$FDFFFDFF,(a3)
	andi.w	#$FDFF,4(a3)
	ori.w	#$200,6(a3)
	bra   .loop
.c7b1:		andi.l	#$FEFFFEFF,(a3)
	andi.w	#$FEFF,4(a3)
	ori.w	#$100,6(a3)
	bra   .loop
.c8b1:		andi.l	#$FF7FFF7F,(a3)
	andi.w	#$FF7F,4(a3)
	ori.w	#$80,6(a3)
	bra   .loop
.c9b1:		andi.l	#$FFBFFFBF,(a3)
	andi.w	#$FFBF,4(a3)
	ori.w	#$40,6(a3)
	bra   .loop
.cAb1:		andi.l	#$FFDFFFDF,(a3)
	andi.w	#$FFDF,4(a3)
	ori.w	#$20,6(a3)
	bra   .loop
.cBb1:		andi.l	#$FFEFFFEF,(a3)
	andi.w	#$FFEF,4(a3)
	ori.w	#$10,6(a3)
	bra   .loop
.cCb1:		andi.l	#$FFF7FFF7,(a3)
	andi.w	#$FFF7,4(a3)
	ori.w	#$8,6(a3)
	bra   .loop
.cDb1:		andi.l	#$FFFBFFFB,(a3)
	andi.w	#$FFFB,4(a3)
	ori.w	#$4,6(a3)
	bra   .loop
.cEb1:		andi.l	#$FFFDFFFD,(a3)
	andi.w	#$FFFD,4(a3)
	ori.w	#$2,6(a3)
	bra   .loop
.cFb1:		andi.l	#$FFFEFFFE,(a3)
	andi.w	#$FFFE,4(a3)
	ori.w	#$1,6(a3)
	bra   .loop
.c0b2:		andi.l	#$7FFF7FFF,(a3)
	ori.w	#$8000,4(a3)
	andi.w	#$7FFF,6(a3)
	bra   .loop
.c1b2:		andi.l	#$BFFFBFFF,(a3)
	ori.w	#$4000,4(a3)
	andi.w	#$BFFF,6(a3)
	bra   .loop
.c2b2:		andi.l	#$DFFFDFFF,(a3)
	ori.w	#$2000,4(a3)
	andi.w	#$DFFF,6(a3)
	bra   .loop
.c3b2:		andi.l	#$EFFFEFFF,(a3)
	ori.w	#$1000,4(a3)
	andi.w	#$EFFF,6(a3)
	bra   .loop
.c4b2:		andi.l	#$F7FFF7FF,(a3)
	ori.w	#$800,4(a3)
	andi.w	#$F7FF,6(a3)
	bra   .loop
.c5b2:		andi.l	#$FBFFFBFF,(a3)
	ori.w	#$400,4(a3)
	andi.w	#$FBFF,6(a3)
	bra   .loop
.c6b2:		andi.l	#$FDFFFDFF,(a3)
	ori.w	#$200,4(a3)
	andi.w	#$FDFF,6(a3)
	bra   .loop
.c7b2:		andi.l	#$FEFFFEFF,(a3)
	ori.w	#$100,4(a3)
	andi.w	#$FEFF,6(a3)
	bra   .loop
.c8b2:		andi.l	#$FF7FFF7F,(a3)
	ori.w	#$80,4(a3)
	andi.w	#$FF7F,6(a3)
	bra   .loop
.c9b2:		andi.l	#$FFBFFFBF,(a3)
	ori.w	#$40,4(a3)
	andi.w	#$FFBF,6(a3)
	bra   .loop
.cAb2:		andi.l	#$FFDFFFDF,(a3)
	ori.w	#$20,4(a3)
	andi.w	#$FFDF,6(a3)
	bra   .loop
.cBb2:		andi.l	#$FFEFFFEF,(a3)
	ori.w	#$10,4(a3)
	andi.w	#$FFEF,6(a3)
	bra   .loop
.cCb2:		andi.l	#$FFF7FFF7,(a3)
	ori.w	#$8,4(a3)
	andi.w	#$FFF7,6(a3)
	bra   .loop
.cDb2:		andi.l	#$FFFBFFFB,(a3)
	ori.w	#$4,4(a3)
	andi.w	#$FFFB,6(a3)
	bra   .loop
.cEb2:		andi.l	#$FFFDFFFD,(a3)
	ori.w	#$2,4(a3)
	andi.w	#$FFFD,6(a3)
	bra   .loop
.cFb2:		andi.l	#$FFFEFFFE,(a3)
	ori.w	#$1,4(a3)
	andi.w	#$FFFE,6(a3)
	bra   .loop
.c0b3:		andi.l	#$7FFF7FFF,(a3)
	ori.l	#$80008000,(a3)
	bra   .loop
.c1b3:		andi.l	#$BFFFBFFF,(a3)
	ori.l	#$40004000,(a3)
	bra   .loop
.c2b3:		andi.l	#$DFFFDFFF,(a3)
	ori.l	#$20002000,(a3)
	bra   .loop
.c3b3:		andi.l	#$EFFFEFFF,(a3)
	ori.l	#$10001000,(a3)
	bra   .loop
.c4b3:		andi.l	#$F7FFF7FF,(a3)
	ori.l	#$08000800,(a3)
	bra   .loop
.c5b3:		andi.l	#$FBFFFBFF,(a3)
	ori.l	#$04000400,(a3)
	bra   .loop
.c6b3:		andi.l	#$FDFFFDFF,(a3)
	ori.l	#$02000200,(a3)
	bra   .loop
.c7b3:		andi.l	#$FEFFFEFF,(a3)
	ori.l	#$01000100,(a3)
	bra   .loop
.c8b3:		andi.l	#$FF7FFF7F,(a3)
	ori.l	#$00800080,(a3)
	bra   .loop
.c9b3:		andi.l	#$FFBFFFBF,(a3)
	ori.l	#$00400040,(a3)
	bra   .loop
.cAb3:		andi.l	#$FFDFFFDF,(a3)
	ori.l	#$00200020,(a3)
	bra   .loop
.cBb3:		andi.l	#$FFEFFFEF,(a3)
	ori.l	#$00100010,(a3)
	bra   .loop
.cCb3:		andi.l	#$FFF7FFF7,(a3)
	ori.l	#$00080008,(a3)
	bra   .loop
.cDb3:		andi.l	#$FFFBFFFB,(a3)
	ori.l	#$00040004,(a3)
	bra   .loop
.cEb3:		andi.l	#$FFFDFFFD,(a3)
	ori.l	#$00020002,(a3)
	bra   .loop
.cFb3:		andi.l	#$FFFEFFFE,(a3)
	ori.l	#$00010001,(a3)
	bra   .loop
.c0b4:		andi.w	#$7FFF,(a3)
	ori.w	#$8000,2(a3)
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c1b4:		andi.w	#$BFFF,(a3)
	ori.w	#$4000,2(a3)
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2b4:		andi.w	#$DFFF,(a3)
	ori.w	#$2000,2(a3)
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3b4:		andi.w	#$EFFF,(a3)
	ori.w	#$1000,2(a3)
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c4b4:		andi.w	#$F7FF,(a3)
	ori.w	#$800,2(a3)
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c5b4:		andi.w	#$FBFF,(a3)
	ori.w	#$400,2(a3)
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c6b4:		andi.w	#$FDFF,(a3)
	ori.w	#$200,2(a3)
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c7b4:		andi.w	#$FEFF,(a3)
	ori.w	#$100,2(a3)
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c8b4:		andi.w	#$FF7F,(a3)
	ori.w	#$80,2(a3)
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c9b4:		andi.w	#$FFBF,(a3)
	ori.w	#$40,2(a3)
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.cAb4:		andi.w	#$FFDF,(a3)
	ori.w	#$20,2(a3)
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.cBb4:		andi.w	#$FFEF,(a3)
	ori.w	#$10,2(a3)
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.cCb4:		andi.w	#$FFF7,(a3)
	ori.w	#$8,2(a3)
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.cDb4:		andi.w	#$FFFB,(a3)
	ori.w	#$4,2(a3)
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.cEb4:		andi.w	#$FFFD,(a3)
	ori.w	#$2,2(a3)
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.cFb4:		andi.w	#$FFFE,(a3)
	ori.w	#$1,2(a3)
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c0b5:		andi.w	#$7FFF,(a3)
	ori.w	#$8000,2(a3)
	andi.w	#$7FFF,4(a3)
	ori.w	#$8000,6(a3)
	bra   .loop
.c1b5:		andi.w	#$BFFF,(a3)
	ori.w	#$4000,2(a3)
	andi.w	#$BFFF,4(a3)
	ori.w	#$4000,6(a3)
	bra   .loop
.c2b5:		andi.w	#$DFFF,(a3)
	ori.w	#$2000,2(a3)
	andi.w	#$DFFF,4(a3)
	ori.w	#$2000,6(a3)
	bra   .loop
.c3b5:		andi.w	#$EFFF,(a3)
	ori.w	#$1000,2(a3)
	andi.w	#$EFFF,4(a3)
	ori.w	#$1000,6(a3)
	bra   .loop
.c4b5:		andi.w	#$F7FF,(a3)
	ori.w	#$800,2(a3)
	andi.w	#$F7FF,4(a3)
	ori.w	#$800,6(a3)
	bra   .loop
.c5b5:		andi.w	#$FBFF,(a3)
	ori.w	#$400,2(a3)
	andi.w	#$FBFF,4(a3)
	ori.w	#$400,6(a3)
	bra   .loop
.c6b5:		andi.w	#$FDFF,(a3)
	ori.w	#$200,2(a3)
	andi.w	#$FDFF,4(a3)
	ori.w	#$200,6(a3)
	bra   .loop
.c7b5:		andi.w	#$FEFF,(a3)
	ori.w	#$100,2(a3)
	andi.w	#$FEFF,4(a3)
	ori.w	#$100,6(a3)
	bra   .loop
.c8b5:		andi.w	#$FF7F,(a3)
	ori.w	#$80,2(a3)
	andi.w	#$FF7F,4(a3)
	ori.w	#$80,6(a3)
	bra   .loop
.c9b5:		andi.w	#$FFBF,(a3)
	ori.w	#$40,2(a3)
	andi.w	#$FFBF,4(a3)
	ori.w	#$40,6(a3)
	bra   .loop
.cAb5:		andi.w	#$FFDF,(a3)
	ori.w	#$20,2(a3)
	andi.w	#$FFDF,4(a3)
	ori.w	#$20,6(a3)
	bra   .loop
.cBb5:		andi.w	#$FFEF,(a3)
	ori.w	#$10,2(a3)
	andi.w	#$FFEF,4(a3)
	ori.w	#$10,6(a3)
	bra   .loop
.cCb5:		andi.w	#$FFF7,(a3)
	ori.w	#$8,2(a3)
	andi.w	#$FFF7,4(a3)
	ori.w	#$8,6(a3)
	bra   .loop
.cDb5:		andi.w	#$FFFB,(a3)
	ori.w	#$4,2(a3)
	andi.w	#$FFFB,4(a3)
	ori.w	#$4,6(a3)
	bra   .loop
.cEb5:		andi.w	#$FFFD,(a3)
	ori.w	#$2,2(a3)
	andi.w	#$FFFD,4(a3)
	ori.w	#$2,6(a3)
	bra   .loop
.cFb5:		andi.w	#$FFFE,(a3)
	ori.w	#$1,2(a3)
	andi.w	#$FFFE,4(a3)
	ori.w	#$1,6(a3)
	bra   .loop
.c0b6:		andi.w	#$7FFF,(a3)
	ori.l	#$80008000,(a3)
	bra   .loop
.c1b6:		andi.w	#$BFFF,(a3)
	ori.l	#$40004000,(a3)
	bra   .loop
.c2b6:		andi.w	#$DFFF,(a3)
	ori.l	#$20002000,(a3)
	bra   .loop
.c3b6:		andi.w	#$EFFF,(a3)
	ori.l	#$10001000,(a3)
	bra   .loop
.c4b6:		andi.w	#$F7FF,(a3)
	ori.l	#$08000800,(a3)
	bra   .loop
.c5b6:		andi.w	#$FBFF,(a3)
	ori.l	#$04000400,(a3)
	bra   .loop
.c6b6:		andi.w	#$FDFF,(a3)
	ori.l	#$02000200,(a3)
	bra   .loop
.c7b6:		andi.w	#$FEFF,(a3)
	ori.l	#$01000100,(a3)
	bra   .loop
.c8b6:		andi.w	#$FF7F,(a3)
	ori.l	#$00800080,(a3)
	bra   .loop
.c9b6:		andi.w	#$FFBF,(a3)
	ori.l	#$00400040,(a3)
	bra   .loop
.cAb6:		andi.w	#$FFDF,(a3)
	ori.l	#$00200020,(a3)
	bra   .loop
.cBb6:		andi.w	#$FFEF,(a3)
	ori.l	#$00100010,(a3)
	bra   .loop
.cCb6:		andi.w	#$FFF7,(a3)
	ori.l	#$00080008,(a3)
	bra   .loop
.cDb6:		andi.w	#$FFFB,(a3)
	ori.l	#$00040004,(a3)
	bra   .loop
.cEb6:		andi.w	#$FFFD,(a3)
	ori.l	#$00020002,(a3)
	bra   .loop
.cFb6:		andi.w	#$FFFE,(a3)
	ori.l	#$00010001,(a3)
	bra   .loop
.c0b7:		andi.w	#$7FFF,(a3)
	ori.l	#$80008000,(a3)
	bra   .loop
.c1b7:		andi.w	#$BFFF,(a3)
	ori.l	#$40004000,(a3)
	bra   .loop
.c2b7:		andi.w	#$DFFF,(a3)
	ori.l	#$20002000,(a3)
	bra   .loop
.c3b7:		andi.w	#$EFFF,(a3)
	ori.l	#$10001000,(a3)
	bra   .loop
.c4b7:		andi.w	#$F7FF,(a3)
	ori.l	#$08000800,(a3)
	bra   .loop
.c5b7:		andi.w	#$FBFF,(a3)
	ori.l	#$04000400,(a3)
	bra   .loop
.c6b7:		andi.w	#$FDFF,(a3)
	ori.l	#$02000200,(a3)
	bra   .loop
.c7b7:		andi.w	#$FEFF,(a3)
	ori.l	#$01000100,(a3)
	bra   .loop
.c8b7:		andi.w	#$FF7F,(a3)
	ori.l	#$00800080,(a3)
	bra   .loop
.c9b7:		andi.w	#$FFBF,(a3)
	ori.l	#$00400040,(a3)
	bra   .loop
.cAb7:		andi.w	#$FFDF,(a3)
	ori.l	#$00200020,(a3)
	bra   .loop
.cBb7:		andi.w	#$FFEF,(a3)
	ori.l	#$00100010,(a3)
	bra   .loop
.cCb7:		andi.w	#$FFF7,(a3)
	ori.l	#$00080008,(a3)
	bra   .loop
.cDb7:		andi.w	#$FFFB,(a3)
	ori.l	#$00040004,(a3)
	bra   .loop
.cEb7:		andi.w	#$FFFD,(a3)
	ori.l	#$00020002,(a3)
	bra   .loop
.cFb7:		andi.w	#$FFFE,(a3)
	ori.l	#$00010001,(a3)
	bra   .loop
.c0b8:		ori.w	#$8000,(a3)
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c1b8:		ori.w	#$4000,(a3)
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2b8:		ori.w	#$2000,(a3)
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3b8:		ori.w	#$1000,(a3)
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c4b8:		ori.w	#$800,(a3)
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c5b8:		ori.w	#$400,(a3)
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c6b8:		ori.w	#$200,(a3)
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c7b8:		ori.w	#$100,(a3)
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c8b8:		ori.w	#$80,(a3)
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c9b8:		ori.w	#$40,(a3)
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.cAb8:		ori.w	#$20,(a3)
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.cBb8:		ori.w	#$10,(a3)
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.cCb8:		ori.w	#$8,(a3)
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.cDb8:		ori.w	#$4,(a3)
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.cEb8:		ori.w	#$2,(a3)
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.cFb8:		ori.w	#$1,(a3)
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c0b9:		ori.w	#$8000,(a3)
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c1b9:		ori.w	#$4000,(a3)
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2b9:		ori.w	#$2000,(a3)
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3b9:		ori.w	#$1000,(a3)
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c4b9:		ori.w	#$800,(a3)
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c5b9:		ori.w	#$400,(a3)
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c6b9:		ori.w	#$200,(a3)
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c7b9:		ori.w	#$100,(a3)
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c8b9:		ori.w	#$80,(a3)
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c9b9:		ori.w	#$40,(a3)
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.cAb9:		ori.w	#$20,(a3)
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.cBb9:		ori.w	#$10,(a3)
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.cCb9:		ori.w	#$8,(a3)
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.cDb9:		ori.w	#$4,(a3)
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.cEb9:		ori.w	#$2,(a3)
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.cFb9:		ori.w	#$1,(a3)
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c0bA:		ori.w	#$8000,(a3)
	andi.w	#$7FFF,2(a3)
	ori.w	#$8000,4(a3)
	andi.w	#$7FFF,6(a3)
	bra   .loop
.c1bA:		ori.w	#$4000,(a3)
	andi.w	#$BFFF,2(a3)
	ori.w	#$4000,4(a3)
	andi.w	#$BFFF,6(a3)
	bra   .loop
.c2bA:		ori.w	#$2000,(a3)
	andi.w	#$DFFF,2(a3)
	ori.w	#$2000,4(a3)
	andi.w	#$DFFF,6(a3)
	bra   .loop
.c3bA:		ori.w	#$1000,(a3)
	andi.w	#$EFFF,2(a3)
	ori.w	#$1000,4(a3)
	andi.w	#$EFFF,6(a3)
	bra   .loop
.c4bA:		ori.w	#$800,(a3)
	andi.w	#$F7FF,2(a3)
	ori.w	#$800,4(a3)
	andi.w	#$F7FF,6(a3)
	bra   .loop
.c5bA:		ori.w	#$400,(a3)
	andi.w	#$FBFF,2(a3)
	ori.w	#$400,4(a3)
	andi.w	#$FBFF,6(a3)
	bra   .loop
.c6bA:		ori.w	#$200,(a3)
	andi.w	#$FDFF,2(a3)
	ori.w	#$200,4(a3)
	andi.w	#$FDFF,6(a3)
	bra   .loop
.c7bA:		ori.w	#$100,(a3)
	andi.w	#$FEFF,2(a3)
	ori.w	#$100,4(a3)
	andi.w	#$FEFF,6(a3)
	bra   .loop
.c8bA:		ori.w	#$80,(a3)
	andi.w	#$FF7F,2(a3)
	ori.w	#$80,4(a3)
	andi.w	#$FF7F,6(a3)
	bra   .loop
.c9bA:		ori.w	#$40,(a3)
	andi.w	#$FFBF,2(a3)
	ori.w	#$40,4(a3)
	andi.w	#$FFBF,6(a3)
	bra   .loop
.cAbA:		ori.w	#$20,(a3)
	andi.w	#$FFDF,2(a3)
	ori.w	#$20,4(a3)
	andi.w	#$FFDF,6(a3)
	bra   .loop
.cBbA:		ori.w	#$10,(a3)
	andi.w	#$FFEF,2(a3)
	ori.w	#$10,4(a3)
	andi.w	#$FFEF,6(a3)
	bra   .loop
.cCbA:		ori.w	#$8,(a3)
	andi.w	#$FFF7,2(a3)
	ori.w	#$8,4(a3)
	andi.w	#$FFF7,6(a3)
	bra   .loop
.cDbA:		ori.w	#$4,(a3)
	andi.w	#$FFFB,2(a3)
	ori.w	#$4,4(a3)
	andi.w	#$FFFB,6(a3)
	bra   .loop
.cEbA:		ori.w	#$2,(a3)
	andi.w	#$FFFD,2(a3)
	ori.w	#$2,4(a3)
	andi.w	#$FFFD,6(a3)
	bra   .loop
.cFbA:		ori.w	#$1,(a3)
	andi.w	#$FFFE,2(a3)
	ori.w	#$1,4(a3)
	andi.w	#$FFFE,6(a3)
	bra   .loop
.c0bB:		ori.w	#$8000,(a3)
	andi.w	#$7FFF,2(a3)
	ori.l	#$80008000,(a3)
	bra   .loop
.c1bB:		ori.w	#$4000,(a3)
	andi.w	#$BFFF,2(a3)
	ori.l	#$40004000,(a3)
	bra   .loop
.c2bB:		ori.w	#$2000,(a3)
	andi.w	#$DFFF,2(a3)
	ori.l	#$20002000,(a3)
	bra   .loop
.c3bB:		ori.w	#$1000,(a3)
	andi.w	#$EFFF,2(a3)
	ori.l	#$10001000,(a3)
	bra   .loop
.c4bB:		ori.w	#$800,(a3)
	andi.w	#$F7FF,2(a3)
	ori.l	#$08000800,(a3)
	bra   .loop
.c5bB:		ori.w	#$400,(a3)
	andi.w	#$FBFF,2(a3)
	ori.l	#$04000400,(a3)
	bra   .loop
.c6bB:		ori.w	#$200,(a3)
	andi.w	#$FDFF,2(a3)
	ori.l	#$02000200,(a3)
	bra   .loop
.c7bB:		ori.w	#$100,(a3)
	andi.w	#$FEFF,2(a3)
	ori.l	#$01000100,(a3)
	bra   .loop
.c8bB:		ori.w	#$80,(a3)
	andi.w	#$FF7F,2(a3)
	ori.l	#$00800080,(a3)
	bra   .loop
.c9bB:		ori.w	#$40,(a3)
	andi.w	#$FFBF,2(a3)
	ori.l	#$00400040,(a3)
	bra   .loop
.cAbB:		ori.w	#$20,(a3)
	andi.w	#$FFDF,2(a3)
	ori.l	#$00200020,(a3)
	bra   .loop
.cBbB:		ori.w	#$10,(a3)
	andi.w	#$FFEF,2(a3)
	ori.l	#$00100010,(a3)
	bra   .loop
.cCbB:		ori.w	#$8,(a3)
	andi.w	#$FFF7,2(a3)
	ori.l	#$00080008,(a3)
	bra   .loop
.cDbB:		ori.w	#$4,(a3)
	andi.w	#$FFFB,2(a3)
	ori.l	#$00040004,(a3)
	bra   .loop
.cEbB:		ori.w	#$2,(a3)
	andi.w	#$FFFD,2(a3)
	ori.l	#$00020002,(a3)
	bra   .loop
.cFbB:		ori.w	#$1,(a3)
	andi.w	#$FFFE,2(a3)
	ori.l	#$00010001,(a3)
	bra   .loop
.c0bC:		ori.l	#$80008000,(a3)
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c1bC:		ori.l	#$40004000,(a3)
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2bC:		ori.l	#$20002000,(a3)
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3bC:		ori.l	#$10001000,(a3)
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c4bC:		ori.l	#$08000800,(a3)
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c5bC:		ori.l	#$04000400,(a3)
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c6bC:		ori.l	#$02000200,(a3)
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c7bC:		ori.l	#$01000100,(a3)
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c8bC:		ori.l	#$00800080,(a3)
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c9bC:		ori.l	#$00400040,(a3)
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.cAbC:		ori.l	#$00200020,(a3)
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.cBbC:		ori.l	#$00100010,(a3)
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.cCbC:		ori.l	#$00080008,(a3)
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.cDbC:		ori.l	#$00040004,(a3)
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.cEbC:		ori.l	#$00020002,(a3)
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.cFbC:		ori.l	#$00010001,(a3)
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c0bD:		ori.l	#$80008000,(a3)
	andi.w	#$7FFF,4(a3)
	ori.w	#$8000,6(a3)
	bra   .loop
.c1bD:		ori.l	#$40004000,(a3)
	andi.w	#$BFFF,4(a3)
	ori.w	#$4000,6(a3)
	bra   .loop
.c2bD:		ori.l	#$20002000,(a3)
	andi.w	#$DFFF,4(a3)
	ori.w	#$2000,6(a3)
	bra   .loop
.c3bD:		ori.l	#$10001000,(a3)
	andi.w	#$EFFF,4(a3)
	ori.w	#$1000,6(a3)
	bra   .loop
.c4bD:		ori.l	#$08000800,(a3)
	andi.w	#$F7FF,4(a3)
	ori.w	#$800,6(a3)
	bra   .loop
.c5bD:		ori.l	#$04000400,(a3)
	andi.w	#$FBFF,4(a3)
	ori.w	#$400,6(a3)
	bra   .loop
.c6bD:		ori.l	#$02000200,(a3)
	andi.w	#$FDFF,4(a3)
	ori.w	#$200,6(a3)
	bra   .loop
.c7bD:		ori.l	#$01000100,(a3)
	andi.w	#$FEFF,4(a3)
	ori.w	#$100,6(a3)
	bra   .loop
.c8bD:		ori.l	#$00800080,(a3)
	andi.w	#$FF7F,4(a3)
	ori.w	#$80,6(a3)
	bra   .loop
.c9bD:		ori.l	#$00400040,(a3)
	andi.w	#$FFBF,4(a3)
	ori.w	#$40,6(a3)
	bra   .loop
.cAbD:		ori.l	#$00200020,(a3)
	andi.w	#$FFDF,4(a3)
	ori.w	#$20,6(a3)
	bra   .loop
.cBbD:		ori.l	#$00100010,(a3)
	andi.w	#$FFEF,4(a3)
	ori.w	#$10,6(a3)
	bra   .loop
.cCbD:		ori.l	#$00080008,(a3)
	andi.w	#$FFF7,4(a3)
	ori.w	#$8,6(a3)
	bra   .loop
.cDbD:		ori.l	#$00040004,(a3)
	andi.w	#$FFFB,4(a3)
	ori.w	#$4,6(a3)
	bra   .loop
.cEbD:		ori.l	#$00020002,(a3)
	andi.w	#$FFFD,4(a3)
	ori.w	#$2,6(a3)
	bra   .loop
.cFbD:		ori.l	#$00010001,(a3)
	andi.w	#$FFFE,4(a3)
	ori.w	#$1,6(a3)
	bra   .loop
.c0bE:		ori.l	#$80008000,(a3)
	ori.w	#$8000,4(a3)
	andi.w	#$7FFF,6(a3)
	bra   .loop
.c1bE:		ori.l	#$40004000,(a3)
	ori.w	#$4000,4(a3)
	andi.w	#$BFFF,6(a3)
	bra   .loop
.c2bE:		ori.l	#$20002000,(a3)
	ori.w	#$2000,4(a3)
	andi.w	#$DFFF,6(a3)
	bra   .loop
.c3bE:		ori.l	#$10001000,(a3)
	ori.w	#$1000,4(a3)
	andi.w	#$EFFF,6(a3)
	bra   .loop
.c4bE:		ori.l	#$08000800,(a3)
	ori.w	#$800,4(a3)
	andi.w	#$F7FF,6(a3)
	bra   .loop
.c5bE:		ori.l	#$04000400,(a3)
	ori.w	#$400,4(a3)
	andi.w	#$FBFF,6(a3)
	bra   .loop
.c6bE:		ori.l	#$02000200,(a3)
	ori.w	#$200,4(a3)
	andi.w	#$FDFF,6(a3)
	bra   .loop
.c7bE:		ori.l	#$01000100,(a3)
	ori.w	#$100,4(a3)
	andi.w	#$FEFF,6(a3)
	bra   .loop
.c8bE:		ori.l	#$00800080,(a3)
	ori.w	#$80,4(a3)
	andi.w	#$FF7F,6(a3)
	bra   .loop
.c9bE:		ori.l	#$00400040,(a3)
	ori.w	#$40,4(a3)
	andi.w	#$FFBF,6(a3)
	bra   .loop
.cAbE:		ori.l	#$00200020,(a3)
	ori.w	#$20,4(a3)
	andi.w	#$FFDF,6(a3)
	bra   .loop
.cBbE:		ori.l	#$00100010,(a3)
	ori.w	#$10,4(a3)
	andi.w	#$FFEF,6(a3)
	bra   .loop
.cCbE:		ori.l	#$00080008,(a3)
	ori.w	#$8,4(a3)
	andi.w	#$FFF7,6(a3)
	bra   .loop
.cDbE:		ori.l	#$00040004,(a3)
	ori.w	#$4,4(a3)
	andi.w	#$FFFB,6(a3)
	bra   .loop
.cEbE:		ori.l	#$00020002,(a3)
	ori.w	#$2,4(a3)
	andi.w	#$FFFD,6(a3)
	bra   .loop
.cFbE:		ori.l	#$00010001,(a3)
	ori.w	#$1,4(a3)
	andi.w	#$FFFE,6(a3)
	bra   .loop
.c0bF:		ori.l	#$80008000,(a3)
	ori.l	#$80008000,(a3)
	bra   .loop
.c1bF:		ori.l	#$40004000,(a3)
	ori.l	#$40004000,(a3)
	bra   .loop
.c2bF:		ori.l	#$20002000,(a3)
	ori.l	#$20002000,(a3)
	bra   .loop
.c3bF:		ori.l	#$10001000,(a3)
	ori.l	#$10001000,(a3)
	bra   .loop
.c4bF:		ori.l	#$08000800,(a3)
	ori.l	#$08000800,(a3)
	bra   .loop
.c5bF:		ori.l	#$04000400,(a3)
	ori.l	#$04000400,(a3)
	bra   .loop
.c6bF:		ori.l	#$02000200,(a3)
	ori.l	#$02000200,(a3)
	bra   .loop
.c7bF:		ori.l	#$01000100,(a3)
	ori.l	#$01000100,(a3)
	bra   .loop
.c8bF:		ori.l	#$00800080,(a3)
	ori.l	#$00800080,(a3)
	bra   .loop
.c9bF:		ori.l	#$00400040,(a3)
	ori.l	#$00400040,(a3)
	bra   .loop
.cAbF:		ori.l	#$00200020,(a3)
	ori.l	#$00200020,(a3)
	bra   .loop
.cBbF:		ori.l	#$00100010,(a3)
	ori.l	#$00100010,(a3)
	bra   .loop
.cCbF:		ori.l	#$00080008,(a3)
	ori.l	#$00080008,(a3)
	bra   .loop
.cDbF:		ori.l	#$00040004,(a3)
	ori.l	#$00040004,(a3)
	bra   .loop
.cEbF:		ori.l	#$00020002,(a3)
	ori.l	#$00020002,(a3)
	bra   .loop
.cFbF:		ori.l	#$00010001,(a3)
	ori.l	#$00010001,(a3)
	bra   .loop

	DATA
.bp4_c0:	dc.l	.c0b0,.c1b0,.c2b0,.c3b0,.c4b0,.c5b0,.c6b0,.c7b0,.c8b0,.c9b0,.cAb0,.cBb0,.cCb0,.cDb0,.cEb0,.cFb0
.bp4_c1:	dc.l	.c0b1,.c1b1,.c2b1,.c3b1,.c4b1,.c5b1,.c6b1,.c7b1,.c8b1,.c9b1,.cAb1,.cBb1,.cCb1,.cDb1,.cEb1,.cFb1
.bp4_c2:	dc.l	.c0b2,.c1b2,.c2b2,.c3b2,.c4b2,.c5b2,.c6b2,.c7b2,.c8b2,.c9b2,.cAb2,.cBb2,.cCb2,.cDb2,.cEb2,.cFb2
.bp4_c3:	dc.l	.c0b3,.c1b3,.c2b3,.c3b3,.c4b3,.c5b3,.c6b3,.c7b3,.c8b3,.c9b3,.cAb3,.cBb3,.cCb3,.cDb3,.cEb3,.cFb3
.bp4_c4:	dc.l	.c0b4,.c1b4,.c2b4,.c3b4,.c4b4,.c5b4,.c6b4,.c7b4,.c8b4,.c9b4,.cAb4,.cBb4,.cCb4,.cDb4,.cEb4,.cFb4
.bp4_c5:	dc.l	.c0b5,.c1b5,.c2b5,.c3b5,.c4b5,.c5b5,.c6b5,.c7b5,.c8b5,.c9b5,.cAb5,.cBb5,.cCb5,.cDb5,.cEb5,.cFb5
.bp4_c6:	dc.l	.c0b6,.c1b6,.c2b6,.c3b6,.c4b6,.c5b6,.c6b6,.c7b6,.c8b6,.c9b6,.cAb6,.cBb6,.cCb6,.cDb6,.cEb6,.cFb6
.bp4_c7:	dc.l	.c0b7,.c1b7,.c2b7,.c3b7,.c4b7,.c5b7,.c6b7,.c7b7,.c8b7,.c9b7,.cAb7,.cBb7,.cCb7,.cDb7,.cEb7,.cFb7
.bp4_c8:	dc.l	.c0b8,.c1b8,.c2b8,.c3b8,.c4b8,.c5b8,.c6b8,.c7b8,.c8b8,.c9b8,.cAb8,.cBb8,.cCb8,.cDb8,.cEb8,.cFb8
.bp4_c9:	dc.l	.c0b9,.c1b9,.c2b9,.c3b9,.c4b9,.c5b9,.c6b9,.c7b9,.c8b9,.c9b9,.cAb9,.cBb9,.cCb9,.cDb9,.cEb9,.cFb9
.bp4_c10:	dc.l	.c0bA,.c1bA,.c2bA,.c3bA,.c4bA,.c5bA,.c6bA,.c7bA,.c8bA,.c9bA,.cAbA,.cBbA,.cCbA,.cDbA,.cEbA,.cFbA
.bp4_c11:	dc.l	.c0bB,.c1bB,.c2bB,.c3bB,.c4bB,.c5bB,.c6bB,.c7bB,.c8bB,.c9bB,.cAbB,.cBbB,.cCbB,.cDbB,.cEbB,.cFbB
.bp4_c12:	dc.l	.c0bC,.c1bC,.c2bC,.c3bC,.c4bC,.c5bC,.c6bC,.c7bC,.c8bC,.c9bC,.cAbC,.cBbC,.cCbC,.cDbC,.cEbC,.cFbC
.bp4_c13:	dc.l	.c0bD,.c1bD,.c2bD,.c3bD,.c4bD,.c5bD,.c6bD,.c7bD,.c8bD,.c9bD,.cAbD,.cBbD,.cCbD,.cDbD,.cEbD,.cFbD
.bp4_c14:	dc.l	.c0bE,.c1bE,.c2bE,.c3bE,.c4bE,.c5bE,.c6bE,.c7bE,.c8bE,.c9bE,.cAbE,.cBbE,.cCbE,.cDbE,.cEbE,.cFbE
.bp4_c15:	dc.l	.c0bF,.c1bF,.c2bF,.c3bF,.c4bF,.c5bF,.c6bF,.c7bF,.c8bF,.c9bF,.cAbF,.cBbF,.cCbF,.cDbF,.cEbF,.cFbF
.bp4_couleurs:	dc.l	.bp4_c0,.bp4_c1,.bp4_c2,.bp4_c3,.bp4_c4,.bp4_c5,.bp4_c6,.bp4_c7,.bp4_c8,.bp4_c9,.bp4_c10,.bp4_c11,.bp4_c12,.bp4_c13,.bp4_c14,.bp4_c15
