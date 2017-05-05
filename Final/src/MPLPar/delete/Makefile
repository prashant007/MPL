all:
	happy -gca ParMPL.y
	alex -g LexMPL.x
	ghc --make TestMPL.hs -o TestMPL

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocMPL.* LexMPL.* ParMPL.* LayoutMPL.* SkelMPL.* PrintMPL.* TestMPL.* AbsMPL.* TestMPL ErrM.* SharedString.* ComposOp.* MPL.dtd XMLMPL.* Makefile*
	

