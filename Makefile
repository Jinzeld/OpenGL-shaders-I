sample:		sample.cpp
		g++ -framework OpenGL -framework GLUT bmptotexture.cpp loadobjmtlfiles.cpp sample.cpp -o sample -I. -Wno-deprecated