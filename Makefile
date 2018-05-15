all:
	cd src && ghc --make Interpreter.hs -o ../interpret

clean:
	-rm -f **/*.log **/*.aux **/*.hi **/*.o **/*.dvi **/*.bak interpret

distclean: clean
	-rm -f **/DocSimplego.* **/LexSimplego.* **/ParSimplego.* **/LayoutSimplego.* **/TestSimplego.* **/AbsSimplego.* interpret **/ErrM.* **/SharedString.* **/ComposOp.* **/simplego.dtd **/XMLSimplego.* **/Makefile*
