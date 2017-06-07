all:
	happy -gca ParAMPL.y
	alex -g LexAMPL.x
	ghc --make TestAMPL.hs -o TestAMPL

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocAMPL.* LexAMPL.* ParAMPL.* LayoutAMPL.* SkelAMPL.* PrintAMPL.* TestAMPL.* AbsAMPL.* TestAMPL ErrM.* SharedString.* ComposOp.* AMPL.dtd XMLAMPL.* Makefile*
	

