SOURCE=satzung.tex
TARGET=satzung.pdf

satzung:
	pdflatex satzung.tex

distclean:
	rm *.pdf *.log *.toc *.aux *.out *.synctex.gz

clean:
	rm *.log *.toc *.aux *.out *.synctex.gz

pdf:
	make satzung
	make clean

default: satzung
