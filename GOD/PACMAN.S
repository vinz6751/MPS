; L'animation va consister … faire circuler des fant“mes de maniŠre
; al‚atoire sur l'‚cran, il s'‚viteront et ‚viteront aussi les
; lettres ELITE et un PACMAN un peu plus rapide les chassera

	     RSRESET
Fantome_x	     rs.w 1
Fantome_y	     rs.w 1
Fantome_dx     rs.w 1
Fantome_dy     rs.w 1
Fantome_sizeof rs.b 1


	SECTION TEXT
PacmanInit
PacmanDeinit
	rts
	
PacmanAnimation
	rts	
	

	SECTION DATA
fantome1	ds.b Fantome_sizeof
fantome2	ds.b Fantome_sizeof
fantome3	ds.b Fantome_sizeof
fantome4	ds.b Fantome_sizeof
fantome5	ds.b Fantome_sizeof
fantome6	ds.b Fantome_sizeof
	
	SECTION BSS