	TEXT
.c0b0:	andi.l	#$7FFF7FFF,(a3)+
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c0b1:	andi.l	#$BFFFBFFF,(a3)+
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c0b2:	andi.l	#$DFFFDFFF,(a3)+
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c0b3:	andi.l	#$EFFFEFFF,(a3)+
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c0b4:	andi.l	#$F7FFF7FF,(a3)+
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c0b5:	andi.l	#$FBFFFBFF,(a3)+
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c0b6:	andi.l	#$FDFFFDFF,(a3)+
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c0b7:	andi.l	#$FEFFFEFF,(a3)+
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c0b8:	andi.l	#$FF7FFF7F,(a3)+
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c0b9:	andi.l	#$FFBFFFBF,(a3)+
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.c0bA:	andi.l	#$FFDFFFDF,(a3)+
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.c0bB:	andi.l	#$FFEFFFEF,(a3)+
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.c0bC:	andi.l	#$FFF7FFF7,(a3)+
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.c0bD:	andi.l	#$FFFBFFFB,(a3)+
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.c0bE:	andi.l	#$FFFDFFFD,(a3)+
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.c0bF:	andi.l	#$FFFEFFFE,(a3)+
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c1b0:	ori.w	#$8000,(a3)+
	andi.l	#$7FFF7FFF,(a3)+
	andi.w	#$7FFF,(a3)
	bra   .loop
.c1b1:	ori.w	#$4000,(a3)+
	andi.l	#$BFFFBFFF,(a3)+
	andi.w	#$BFFF,(a3)
	bra   .loop
.c1b2:	ori.w	#$2000,(a3)+
	andi.l	#$DFFFDFFF,(a3)+
	andi.w	#$DFFF,(a3)
	bra   .loop
.c1b3:	ori.w	#$1000,(a3)+
	andi.l	#$EFFFEFFF,(a3)+
	andi.w	#$EFFF,(a3)
	bra   .loop
.c1b4:	ori.w	#$800,(a3)+
	andi.l	#$F7FFF7FF,(a3)+
	andi.w	#$F7FF,(a3)
	bra   .loop
.c1b5:	ori.w	#$400,(a3)+
	andi.l	#$FBFFFBFF,(a3)+
	andi.w	#$FBFF,(a3)
	bra   .loop
.c1b6:	ori.w	#$200,(a3)+
	andi.l	#$FDFFFDFF,(a3)+
	andi.w	#$FDFF,(a3)
	bra   .loop
.c1b7:	ori.w	#$100,(a3)+
	andi.l	#$FEFFFEFF,(a3)+
	andi.w	#$FEFF,(a3)
	bra   .loop
.c1b8:	ori.w	#$80,(a3)+
	andi.l	#$FF7FFF7F,(a3)+
	andi.w	#$FF7F,(a3)
	bra   .loop
.c1b9:	ori.w	#$40,(a3)+
	andi.l	#$FFBFFFBF,(a3)+
	andi.w	#$FFBF,(a3)
	bra   .loop
.c1bA:	ori.w	#$20,(a3)+
	andi.l	#$FFDFFFDF,(a3)+
	andi.w	#$FFDF,(a3)
	bra   .loop
.c1bB:	ori.w	#$10,(a3)+
	andi.l	#$FFEFFFEF,(a3)+
	andi.w	#$FFEF,(a3)
	bra   .loop
.c1bC:	ori.w	#$8,(a3)+
	andi.l	#$FFF7FFF7,(a3)+
	andi.w	#$FFF7,(a3)
	bra   .loop
.c1bD:	ori.w	#$4,(a3)+
	andi.l	#$FFFBFFFB,(a3)+
	andi.w	#$FFFB,(a3)
	bra   .loop
.c1bE:	ori.w	#$2,(a3)+
	andi.l	#$FFFDFFFD,(a3)+
	andi.w	#$FFFD,(a3)
	bra   .loop
.c1bF:	ori.w	#$1,(a3)+
	andi.l	#$FFFEFFFE,(a3)+
	andi.w	#$FFFE,(a3)
	bra   .loop
.c2b0:	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)+
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c2b1:	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)+
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c2b2:	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)+
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c2b3:	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)+
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c2b4:	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)+
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c2b5:	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)+
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c2b6:	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)+
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c2b7:	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)+
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c2b8:	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)+
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c2b9:	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)+
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.c2bA:	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)+
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.c2bB:	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)+
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.c2bC:	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)+
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.c2bD:	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)+
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.c2bE:	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)+
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.c2bF:	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)+
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c3b0:	ori.l	#$80008000,(a3)+
	andi.l	#$7FFF7FFF,(a3)
	bra   .loop
.c3b1:	ori.l	#$40004000,(a3)+
	andi.l	#$BFFFBFFF,(a3)
	bra   .loop
.c3b2:	ori.l	#$20002000,(a3)+
	andi.l	#$DFFFDFFF,(a3)
	bra   .loop
.c3b3:	ori.l	#$10001000,(a3)+
	andi.l	#$EFFFEFFF,(a3)
	bra   .loop
.c3b4:	ori.l	#$08000800,(a3)+
	andi.l	#$F7FFF7FF,(a3)
	bra   .loop
.c3b5:	ori.l	#$04000400,(a3)+
	andi.l	#$FBFFFBFF,(a3)
	bra   .loop
.c3b6:	ori.l	#$02000200,(a3)+
	andi.l	#$FDFFFDFF,(a3)
	bra   .loop
.c3b7:	ori.l	#$01000100,(a3)+
	andi.l	#$FEFFFEFF,(a3)
	bra   .loop
.c3b8:	ori.l	#$00800080,(a3)+
	andi.l	#$FF7FFF7F,(a3)
	bra   .loop
.c3b9:	ori.l	#$00400040,(a3)+
	andi.l	#$FFBFFFBF,(a3)
	bra   .loop
.c3bA:	ori.l	#$00200020,(a3)+
	andi.l	#$FFDFFFDF,(a3)
	bra   .loop
.c3bB:	ori.l	#$00100010,(a3)+
	andi.l	#$FFEFFFEF,(a3)
	bra   .loop
.c3bC:	ori.l	#$00080008,(a3)+
	andi.l	#$FFF7FFF7,(a3)
	bra   .loop
.c3bD:	ori.l	#$00040004,(a3)+
	andi.l	#$FFFBFFFB,(a3)
	bra   .loop
.c3bE:	ori.l	#$00020002,(a3)+
	andi.l	#$FFFDFFFD,(a3)
	bra   .loop
.c3bF:	ori.l	#$00010001,(a3)+
	andi.l	#$FFFEFFFE,(a3)
	bra   .loop
.c4b0:	andi.l	#$7FFF7FFF,(a3)+
	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)
	bra   .loop
.c4b1:	andi.l	#$BFFFBFFF,(a3)+
	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)
	bra   .loop
.c4b2:	andi.l	#$DFFFDFFF,(a3)+
	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)
	bra   .loop
.c4b3:	andi.l	#$EFFFEFFF,(a3)+
	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)
	bra   .loop
.c4b4:	andi.l	#$F7FFF7FF,(a3)+
	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)
	bra   .loop
.c4b5:	andi.l	#$FBFFFBFF,(a3)+
	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)
	bra   .loop
.c4b6:	andi.l	#$FDFFFDFF,(a3)+
	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)
	bra   .loop
.c4b7:	andi.l	#$FEFFFEFF,(a3)+
	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)
	bra   .loop
.c4b8:	andi.l	#$FF7FFF7F,(a3)+
	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)
	bra   .loop
.c4b9:	andi.l	#$FFBFFFBF,(a3)+
	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)
	bra   .loop
.c4bA:	andi.l	#$FFDFFFDF,(a3)+
	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)
	bra   .loop
.c4bB:	andi.l	#$FFEFFFEF,(a3)+
	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)
	bra   .loop
.c4bC:	andi.l	#$FFF7FFF7,(a3)+
	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)
	bra   .loop
.c4bD:	andi.l	#$FFFBFFFB,(a3)+
	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)
	bra   .loop
.c4bE:	andi.l	#$FFFDFFFD,(a3)+
	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)
	bra   .loop
.c4bF:	andi.l	#$FFFEFFFE,(a3)+
	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)
	bra   .loop
.c5b0:	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)
	bra   .loop
.c5b1:	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)
	bra   .loop
.c5b2:	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)
	bra   .loop
.c5b3:	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)
	bra   .loop
.c5b4:	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)
	bra   .loop
.c5b5:	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)
	bra   .loop
.c5b6:	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)
	bra   .loop
.c5b7:	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)
	bra   .loop
.c5b8:	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)
	bra   .loop
.c5b9:	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)
	bra   .loop
.c5bA:	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)
	bra   .loop
.c5bB:	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)
	bra   .loop
.c5bC:	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)
	bra   .loop
.c5bD:	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)
	bra   .loop
.c5bE:	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)
	bra   .loop
.c5bF:	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)
	bra   .loop
.c6b0:	andi.w	#$7FFF,(a3)+
	ori.l	#$80008000,(a3)+
	andi.w	#$7FFF,(a3)
	bra   .loop
.c6b1:	andi.w	#$BFFF,(a3)+
	ori.l	#$40004000,(a3)+
	andi.w	#$BFFF,(a3)
	bra   .loop
.c6b2:	andi.w	#$DFFF,(a3)+
	ori.l	#$20002000,(a3)+
	andi.w	#$DFFF,(a3)
	bra   .loop
.c6b3:	andi.w	#$EFFF,(a3)+
	ori.l	#$10001000,(a3)+
	andi.w	#$EFFF,(a3)
	bra   .loop
.c6b4:	andi.w	#$F7FF,(a3)+
	ori.l	#$08000800,(a3)+
	andi.w	#$F7FF,(a3)
	bra   .loop
.c6b5:	andi.w	#$FBFF,(a3)+
	ori.l	#$04000400,(a3)+
	andi.w	#$FBFF,(a3)
	bra   .loop
.c6b6:	andi.w	#$FDFF,(a3)+
	ori.l	#$02000200,(a3)+
	andi.w	#$FDFF,(a3)
	bra   .loop
.c6b7:	andi.w	#$FEFF,(a3)+
	ori.l	#$01000100,(a3)+
	andi.w	#$FEFF,(a3)
	bra   .loop
.c6b8:	andi.w	#$FF7F,(a3)+
	ori.l	#$00800080,(a3)+
	andi.w	#$FF7F,(a3)
	bra   .loop
.c6b9:	andi.w	#$FFBF,(a3)+
	ori.l	#$00400040,(a3)+
	andi.w	#$FFBF,(a3)
	bra   .loop
.c6bA:	andi.w	#$FFDF,(a3)+
	ori.l	#$00200020,(a3)+
	andi.w	#$FFDF,(a3)
	bra   .loop
.c6bB:	andi.w	#$FFEF,(a3)+
	ori.l	#$00100010,(a3)+
	andi.w	#$FFEF,(a3)
	bra   .loop
.c6bC:	andi.w	#$FFF7,(a3)+
	ori.l	#$00080008,(a3)+
	andi.w	#$FFF7,(a3)
	bra   .loop
.c6bD:	andi.w	#$FFFB,(a3)+
	ori.l	#$00040004,(a3)+
	andi.w	#$FFFB,(a3)
	bra   .loop
.c6bE:	andi.w	#$FFFD,(a3)+
	ori.l	#$00020002,(a3)+
	andi.w	#$FFFD,(a3)
	bra   .loop
.c6bF:	andi.w	#$FFFE,(a3)+
	ori.l	#$00010001,(a3)+
	andi.w	#$FFFE,(a3)
	bra   .loop
.c7b0:	ori.l	#$80008000,(a3)+
	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)
	bra   .loop
.c7b1:	ori.l	#$40004000,(a3)+
	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)
	bra   .loop
.c7b2:	ori.l	#$20002000,(a3)+
	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)
	bra   .loop
.c7b3:	ori.l	#$10001000,(a3)+
	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)
	bra   .loop
.c7b4:	ori.l	#$08000800,(a3)+
	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)
	bra   .loop
.c7b5:	ori.l	#$04000400,(a3)+
	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)
	bra   .loop
.c7b6:	ori.l	#$02000200,(a3)+
	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)
	bra   .loop
.c7b7:	ori.l	#$01000100,(a3)+
	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)
	bra   .loop
.c7b8:	ori.l	#$00800080,(a3)+
	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)
	bra   .loop
.c7b9:	ori.l	#$00400040,(a3)+
	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)
	bra   .loop
.c7bA:	ori.l	#$00200020,(a3)+
	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)
	bra   .loop
.c7bB:	ori.l	#$00100010,(a3)+
	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)
	bra   .loop
.c7bC:	ori.l	#$00080008,(a3)+
	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)
	bra   .loop
.c7bD:	ori.l	#$00040004,(a3)+
	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)
	bra   .loop
.c7bE:	ori.l	#$00020002,(a3)+
	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)
	bra   .loop
.c7bF:	ori.l	#$00010001,(a3)+
	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)
	bra   .loop
.c8b0:	andi.l	#$7FFF7FFF,(a3)+
	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)
	bra   .loop
.c8b1:	andi.l	#$BFFFBFFF,(a3)+
	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)
	bra   .loop
.c8b2:	andi.l	#$DFFFDFFF,(a3)+
	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)
	bra   .loop
.c8b3:	andi.l	#$EFFFEFFF,(a3)+
	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)
	bra   .loop
.c8b4:	andi.l	#$F7FFF7FF,(a3)+
	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)
	bra   .loop
.c8b5:	andi.l	#$FBFFFBFF,(a3)+
	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)
	bra   .loop
.c8b6:	andi.l	#$FDFFFDFF,(a3)+
	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)
	bra   .loop
.c8b7:	andi.l	#$FEFFFEFF,(a3)+
	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)
	bra   .loop
.c8b8:	andi.l	#$FF7FFF7F,(a3)+
	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)
	bra   .loop
.c8b9:	andi.l	#$FFBFFFBF,(a3)+
	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)
	bra   .loop
.c8bA:	andi.l	#$FFDFFFDF,(a3)+
	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)
	bra   .loop
.c8bB:	andi.l	#$FFEFFFEF,(a3)+
	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)
	bra   .loop
.c8bC:	andi.l	#$FFF7FFF7,(a3)+
	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)
	bra   .loop
.c8bD:	andi.l	#$FFFBFFFB,(a3)+
	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)
	bra   .loop
.c8bE:	andi.l	#$FFFDFFFD,(a3)+
	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)
	bra   .loop
.c8bF:	andi.l	#$FFFEFFFE,(a3)+
	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)
	bra   .loop
.c9b0:	ori.w	#$8000,(a3)+
	andi.l	#$7FFF7FFF,(a3)+
	ori.w	#$8000,(a3)
	bra   .loop
.c9b1:	ori.w	#$4000,(a3)+
	andi.l	#$BFFFBFFF,(a3)+
	ori.w	#$4000,(a3)
	bra   .loop
.c9b2:	ori.w	#$2000,(a3)+
	andi.l	#$DFFFDFFF,(a3)+
	ori.w	#$2000,(a3)
	bra   .loop
.c9b3:	ori.w	#$1000,(a3)+
	andi.l	#$EFFFEFFF,(a3)+
	ori.w	#$1000,(a3)
	bra   .loop
.c9b4:	ori.w	#$800,(a3)+
	andi.l	#$F7FFF7FF,(a3)+
	ori.w	#$800,(a3)
	bra   .loop
.c9b5:	ori.w	#$400,(a3)+
	andi.l	#$FBFFFBFF,(a3)+
	ori.w	#$400,(a3)
	bra   .loop
.c9b6:	ori.w	#$200,(a3)+
	andi.l	#$FDFFFDFF,(a3)+
	ori.w	#$200,(a3)
	bra   .loop
.c9b7:	ori.w	#$100,(a3)+
	andi.l	#$FEFFFEFF,(a3)+
	ori.w	#$100,(a3)
	bra   .loop
.c9b8:	ori.w	#$80,(a3)+
	andi.l	#$FF7FFF7F,(a3)+
	ori.w	#$80,(a3)
	bra   .loop
.c9b9:	ori.w	#$40,(a3)+
	andi.l	#$FFBFFFBF,(a3)+
	ori.w	#$40,(a3)
	bra   .loop
.c9bA:	ori.w	#$20,(a3)+
	andi.l	#$FFDFFFDF,(a3)+
	ori.w	#$20,(a3)
	bra   .loop
.c9bB:	ori.w	#$10,(a3)+
	andi.l	#$FFEFFFEF,(a3)+
	ori.w	#$10,(a3)
	bra   .loop
.c9bC:	ori.w	#$8,(a3)+
	andi.l	#$FFF7FFF7,(a3)+
	ori.w	#$8,(a3)
	bra   .loop
.c9bD:	ori.w	#$4,(a3)+
	andi.l	#$FFFBFFFB,(a3)+
	ori.w	#$4,(a3)
	bra   .loop
.c9bE:	ori.w	#$2,(a3)+
	andi.l	#$FFFDFFFD,(a3)+
	ori.w	#$2,(a3)
	bra   .loop
.c9bF:	ori.w	#$1,(a3)+
	andi.l	#$FFFEFFFE,(a3)+
	ori.w	#$1,(a3)
	bra   .loop
.cAb0:	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)
	bra   .loop
.cAb1:	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)
	bra   .loop
.cAb2:	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)
	bra   .loop
.cAb3:	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)
	bra   .loop
.cAb4:	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)
	bra   .loop
.cAb5:	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)
	bra   .loop
.cAb6:	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)
	bra   .loop
.cAb7:	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)
	bra   .loop
.cAb8:	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)
	bra   .loop
.cAb9:	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)
	bra   .loop
.cAbA:	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)
	bra   .loop
.cAbB:	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)
	bra   .loop
.cAbC:	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)
	bra   .loop
.cAbD:	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)
	bra   .loop
.cAbE:	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)
	bra   .loop
.cAbF:	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)
	bra   .loop
.cBb0:	ori.l	#$80008000,(a3)+
	andi.w	#$7FFF,(a3)+
	ori.w	#$8000,(a3)
	bra   .loop
.cBb1:	ori.l	#$40004000,(a3)+
	andi.w	#$BFFF,(a3)+
	ori.w	#$4000,(a3)
	bra   .loop
.cBb2:	ori.l	#$20002000,(a3)+
	andi.w	#$DFFF,(a3)+
	ori.w	#$2000,(a3)
	bra   .loop
.cBb3:	ori.l	#$10001000,(a3)+
	andi.w	#$EFFF,(a3)+
	ori.w	#$1000,(a3)
	bra   .loop
.cBb4:	ori.l	#$08000800,(a3)+
	andi.w	#$F7FF,(a3)+
	ori.w	#$800,(a3)
	bra   .loop
.cBb5:	ori.l	#$04000400,(a3)+
	andi.w	#$FBFF,(a3)+
	ori.w	#$400,(a3)
	bra   .loop
.cBb6:	ori.l	#$02000200,(a3)+
	andi.w	#$FDFF,(a3)+
	ori.w	#$200,(a3)
	bra   .loop
.cBb7:	ori.l	#$01000100,(a3)+
	andi.w	#$FEFF,(a3)+
	ori.w	#$100,(a3)
	bra   .loop
.cBb8:	ori.l	#$00800080,(a3)+
	andi.w	#$FF7F,(a3)+
	ori.w	#$80,(a3)
	bra   .loop
.cBb9:	ori.l	#$00400040,(a3)+
	andi.w	#$FFBF,(a3)+
	ori.w	#$40,(a3)
	bra   .loop
.cBbA:	ori.l	#$00200020,(a3)+
	andi.w	#$FFDF,(a3)+
	ori.w	#$20,(a3)
	bra   .loop
.cBbB:	ori.l	#$00100010,(a3)+
	andi.w	#$FFEF,(a3)+
	ori.w	#$10,(a3)
	bra   .loop
.cBbC:	ori.l	#$00080008,(a3)+
	andi.w	#$FFF7,(a3)+
	ori.w	#$8,(a3)
	bra   .loop
.cBbD:	ori.l	#$00040004,(a3)+
	andi.w	#$FFFB,(a3)+
	ori.w	#$4,(a3)
	bra   .loop
.cBbE:	ori.l	#$00020002,(a3)+
	andi.w	#$FFFD,(a3)+
	ori.w	#$2,(a3)
	bra   .loop
.cBbF:	ori.l	#$00010001,(a3)+
	andi.w	#$FFFE,(a3)+
	ori.w	#$1,(a3)
	bra   .loop
.cCb0:	andi.l	#$7FFF7FFF,(a3)+
	ori.l	#$80008000,(a3)
	bra   .loop
.cCb1:	andi.l	#$BFFFBFFF,(a3)+
	ori.l	#$40004000,(a3)
	bra   .loop
.cCb2:	andi.l	#$DFFFDFFF,(a3)+
	ori.l	#$20002000,(a3)
	bra   .loop
.cCb3:	andi.l	#$EFFFEFFF,(a3)+
	ori.l	#$10001000,(a3)
	bra   .loop
.cCb4:	andi.l	#$F7FFF7FF,(a3)+
	ori.l	#$08000800,(a3)
	bra   .loop
.cCb5:	andi.l	#$FBFFFBFF,(a3)+
	ori.l	#$04000400,(a3)
	bra   .loop
.cCb6:	andi.l	#$FDFFFDFF,(a3)+
	ori.l	#$02000200,(a3)
	bra   .loop
.cCb7:	andi.l	#$FEFFFEFF,(a3)+
	ori.l	#$01000100,(a3)
	bra   .loop
.cCb8:	andi.l	#$FF7FFF7F,(a3)+
	ori.l	#$00800080,(a3)
	bra   .loop
.cCb9:	andi.l	#$FFBFFFBF,(a3)+
	ori.l	#$00400040,(a3)
	bra   .loop
.cCbA:	andi.l	#$FFDFFFDF,(a3)+
	ori.l	#$00200020,(a3)
	bra   .loop
.cCbB:	andi.l	#$FFEFFFEF,(a3)+
	ori.l	#$00100010,(a3)
	bra   .loop
.cCbC:	andi.l	#$FFF7FFF7,(a3)+
	ori.l	#$00080008,(a3)
	bra   .loop
.cCbD:	andi.l	#$FFFBFFFB,(a3)+
	ori.l	#$00040004,(a3)
	bra   .loop
.cCbE:	andi.l	#$FFFDFFFD,(a3)+
	ori.l	#$00020002,(a3)
	bra   .loop
.cCbF:	andi.l	#$FFFEFFFE,(a3)+
	ori.l	#$00010001,(a3)
	bra   .loop
.cDb0:	ori.w	#$8000,(a3)+
	andi.w	#$7FFF,(a3)+
	ori.l	#$80008000,(a3)
	bra   .loop
.cDb1:	ori.w	#$4000,(a3)+
	andi.w	#$BFFF,(a3)+
	ori.l	#$40004000,(a3)
	bra   .loop
.cDb2:	ori.w	#$2000,(a3)+
	andi.w	#$DFFF,(a3)+
	ori.l	#$20002000,(a3)
	bra   .loop
.cDb3:	ori.w	#$1000,(a3)+
	andi.w	#$EFFF,(a3)+
	ori.l	#$10001000,(a3)
	bra   .loop
.cDb4:	ori.w	#$800,(a3)+
	andi.w	#$F7FF,(a3)+
	ori.l	#$08000800,(a3)
	bra   .loop
.cDb5:	ori.w	#$400,(a3)+
	andi.w	#$FBFF,(a3)+
	ori.l	#$04000400,(a3)
	bra   .loop
.cDb6:	ori.w	#$200,(a3)+
	andi.w	#$FDFF,(a3)+
	ori.l	#$02000200,(a3)
	bra   .loop
.cDb7:	ori.w	#$100,(a3)+
	andi.w	#$FEFF,(a3)+
	ori.l	#$01000100,(a3)
	bra   .loop
.cDb8:	ori.w	#$80,(a3)+
	andi.w	#$FF7F,(a3)+
	ori.l	#$00800080,(a3)
	bra   .loop
.cDb9:	ori.w	#$40,(a3)+
	andi.w	#$FFBF,(a3)+
	ori.l	#$00400040,(a3)
	bra   .loop
.cDbA:	ori.w	#$20,(a3)+
	andi.w	#$FFDF,(a3)+
	ori.l	#$00200020,(a3)
	bra   .loop
.cDbB:	ori.w	#$10,(a3)+
	andi.w	#$FFEF,(a3)+
	ori.l	#$00100010,(a3)
	bra   .loop
.cDbC:	ori.w	#$8,(a3)+
	andi.w	#$FFF7,(a3)+
	ori.l	#$00080008,(a3)
	bra   .loop
.cDbD:	ori.w	#$4,(a3)+
	andi.w	#$FFFB,(a3)+
	ori.l	#$00040004,(a3)
	bra   .loop
.cDbE:	ori.w	#$2,(a3)+
	andi.w	#$FFFD,(a3)+
	ori.l	#$00020002,(a3)
	bra   .loop
.cDbF:	ori.w	#$1,(a3)+
	andi.w	#$FFFE,(a3)+
	ori.l	#$00010001,(a3)
	bra   .loop
.cEb0:	andi.w	#$7FFF,(a3)+
	ori.l	#$80008000,(a3)+
	ori.w	#$8000,(a3)
	bra   .loop
.cEb1:	andi.w	#$BFFF,(a3)+
	ori.l	#$40004000,(a3)+
	ori.w	#$4000,(a3)
	bra   .loop
.cEb2:	andi.w	#$DFFF,(a3)+
	ori.l	#$20002000,(a3)+
	ori.w	#$2000,(a3)
	bra   .loop
.cEb3:	andi.w	#$EFFF,(a3)+
	ori.l	#$10001000,(a3)+
	ori.w	#$1000,(a3)
	bra   .loop
.cEb4:	andi.w	#$F7FF,(a3)+
	ori.l	#$08000800,(a3)+
	ori.w	#$800,(a3)
	bra   .loop
.cEb5:	andi.w	#$FBFF,(a3)+
	ori.l	#$04000400,(a3)+
	ori.w	#$400,(a3)
	bra   .loop
.cEb6:	andi.w	#$FDFF,(a3)+
	ori.l	#$02000200,(a3)+
	ori.w	#$200,(a3)
	bra   .loop
.cEb7:	andi.w	#$FEFF,(a3)+
	ori.l	#$01000100,(a3)+
	ori.w	#$100,(a3)
	bra   .loop
.cEb8:	andi.w	#$FF7F,(a3)+
	ori.l	#$00800080,(a3)+
	ori.w	#$80,(a3)
	bra   .loop
.cEb9:	andi.w	#$FFBF,(a3)+
	ori.l	#$00400040,(a3)+
	ori.w	#$40,(a3)
	bra   .loop
.cEbA:	andi.w	#$FFDF,(a3)+
	ori.l	#$00200020,(a3)+
	ori.w	#$20,(a3)
	bra   .loop
.cEbB:	andi.w	#$FFEF,(a3)+
	ori.l	#$00100010,(a3)+
	ori.w	#$10,(a3)
	bra   .loop
.cEbC:	andi.w	#$FFF7,(a3)+
	ori.l	#$00080008,(a3)+
	ori.w	#$8,(a3)
	bra   .loop
.cEbD:	andi.w	#$FFFB,(a3)+
	ori.l	#$00040004,(a3)+
	ori.w	#$4,(a3)
	bra   .loop
.cEbE:	andi.w	#$FFFD,(a3)+
	ori.l	#$00020002,(a3)+
	ori.w	#$2,(a3)
	bra   .loop
.cEbF:	andi.w	#$FFFE,(a3)+
	ori.l	#$00010001,(a3)+
	ori.w	#$1,(a3)
	bra   .loop
.cFb0:	ori.l	#$80008000,(a3)+
	ori.l	#$80008000,(a3)
	bra   .loop
.cFb1:	ori.l	#$40004000,(a3)+
	ori.l	#$40004000,(a3)
	bra   .loop
.cFb2:	ori.l	#$20002000,(a3)+
	ori.l	#$20002000,(a3)
	bra   .loop
.cFb3:	ori.l	#$10001000,(a3)+
	ori.l	#$10001000,(a3)
	bra   .loop
.cFb4:	ori.l	#$08000800,(a3)+
	ori.l	#$08000800,(a3)
	bra   .loop
.cFb5:	ori.l	#$04000400,(a3)+
	ori.l	#$04000400,(a3)
	bra   .loop
.cFb6:	ori.l	#$02000200,(a3)+
	ori.l	#$02000200,(a3)
	bra   .loop
.cFb7:	ori.l	#$01000100,(a3)+
	ori.l	#$01000100,(a3)
	bra   .loop
.cFb8:	ori.l	#$00800080,(a3)+
	ori.l	#$00800080,(a3)
	bra   .loop
.cFb9:	ori.l	#$00400040,(a3)+
	ori.l	#$00400040,(a3)
	bra   .loop
.cFbA:	ori.l	#$00200020,(a3)+
	ori.l	#$00200020,(a3)
	bra   .loop
.cFbB:	ori.l	#$00100010,(a3)+
	ori.l	#$00100010,(a3)
	bra   .loop
.cFbC:	ori.l	#$00080008,(a3)+
	ori.l	#$00080008,(a3)
	bra   .loop
.cFbD:	ori.l	#$00040004,(a3)+
	ori.l	#$00040004,(a3)
	bra   .loop
.cFbE:	ori.l	#$00020002,(a3)+
	ori.l	#$00020002,(a3)
	bra   .loop
.cFbF:	ori.l	#$00010001,(a3)+
	ori.l	#$00010001,(a3)
	bra   .loop

	DATA
.bp4_c0:	dc.l	.c0b0,.c0b1,.c0b2,.c0b3,.c0b4,.c0b5,.c0b6,.c0b7,.c0b8,.c0b9,.c0bA,.c0bB,.c0bC,.c0bD,.c0bE,.c0bF
.bp4_c1:	dc.l	.c1b0,.c1b1,.c1b2,.c1b3,.c1b4,.c1b5,.c1b6,.c1b7,.c1b8,.c1b9,.c1bA,.c1bB,.c1bC,.c1bD,.c1bE,.c1bF
.bp4_c2:	dc.l	.c2b0,.c2b1,.c2b2,.c2b3,.c2b4,.c2b5,.c2b6,.c2b7,.c2b8,.c2b9,.c2bA,.c2bB,.c2bC,.c2bD,.c2bE,.c2bF
.bp4_c3:	dc.l	.c3b0,.c3b1,.c3b2,.c3b3,.c3b4,.c3b5,.c3b6,.c3b7,.c3b8,.c3b9,.c3bA,.c3bB,.c3bC,.c3bD,.c3bE,.c3bF
.bp4_c4:	dc.l	.c4b0,.c4b1,.c4b2,.c4b3,.c4b4,.c4b5,.c4b6,.c4b7,.c4b8,.c4b9,.c4bA,.c4bB,.c4bC,.c4bD,.c4bE,.c4bF
.bp4_c5:	dc.l	.c5b0,.c5b1,.c5b2,.c5b3,.c5b4,.c5b5,.c5b6,.c5b7,.c5b8,.c5b9,.c5bA,.c5bB,.c5bC,.c5bD,.c5bE,.c5bF
.bp4_c6:	dc.l	.c6b0,.c6b1,.c6b2,.c6b3,.c6b4,.c6b5,.c6b6,.c6b7,.c6b8,.c6b9,.c6bA,.c6bB,.c6bC,.c6bD,.c6bE,.c6bF
.bp4_c7:	dc.l	.c7b0,.c7b1,.c7b2,.c7b3,.c7b4,.c7b5,.c7b6,.c7b7,.c7b8,.c7b9,.c7bA,.c7bB,.c7bC,.c7bD,.c7bE,.c7bF
.bp4_c8:	dc.l	.c8b0,.c8b1,.c8b2,.c8b3,.c8b4,.c8b5,.c8b6,.c8b7,.c8b8,.c8b9,.c8bA,.c8bB,.c8bC,.c8bD,.c8bE,.c8bF
.bp4_c9:	dc.l	.c9b0,.c9b1,.c9b2,.c9b3,.c9b4,.c9b5,.c9b6,.c9b7,.c9b8,.c9b9,.c9bA,.c9bB,.c9bC,.c9bD,.c9bE,.c9bF
.bp4_c10:	dc.l	.cAb0,.cAb1,.cAb2,.cAb3,.cAb4,.cAb5,.cAb6,.cAb7,.cAb8,.cAb9,.cAbA,.cAbB,.cAbC,.cAbD,.cAbE,.cAbF
.bp4_c11:	dc.l	.cBb0,.cBb1,.cBb2,.cBb3,.cBb4,.cBb5,.cBb6,.cBb7,.cBb8,.cBb9,.cBbA,.cBbB,.cBbC,.cBbD,.cBbE,.cBbF
.bp4_c12:	dc.l	.cCb0,.cCb1,.cCb2,.cCb3,.cCb4,.cCb5,.cCb6,.cCb7,.cCb8,.cCb9,.cCbA,.cCbB,.cCbC,.cCbD,.cCbE,.cCbF
.bp4_c13:	dc.l	.cDb0,.cDb1,.cDb2,.cDb3,.cDb4,.cDb5,.cDb6,.cDb7,.cDb8,.cDb9,.cDbA,.cDbB,.cDbC,.cDbD,.cDbE,.cDbF
.bp4_c14:	dc.l	.cEb0,.cEb1,.cEb2,.cEb3,.cEb4,.cEb5,.cEb6,.cEb7,.cEb8,.cEb9,.cEbA,.cEbB,.cEbC,.cEbD,.cEbE,.cEbF
.bp4_c15:	dc.l	.cFb0,.cFb1,.cFb2,.cFb3,.cFb4,.cFb5,.cFb6,.cFb7,.cFb8,.cFb9,.cFbA,.cFbB,.cFbC,.cFbD,.cFbE,.cFbF
.bp4_couleurs:	dc.l	.bp4_c0,.bp4_c1,.bp4_c2,.bp4_c3,.bp4_c4,.bp4_c5,.bp4_c6,.bp4_c7,.bp4_c8,.bp4_c9,.bp4_c10,.bp4_c11,.bp4_c12,.bp4_c13,.bp4_c14,.bp4_c15
