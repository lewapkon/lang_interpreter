all:
	happy -gca ParSimplego.y
	alex -g LexSimplego.x
	ghc --make TestSimplego.hs -o TestSimplego

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocSimplego.* LexSimplego.* ParSimplego.* LayoutSimplego.* SkelSimplego.* PrintSimplego.* TestSimplego.* AbsSimplego.* TestSimplego ErrM.* SharedString.* ComposOp.* simplego.dtd XMLSimplego.* Makefile*
	

