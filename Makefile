SOURCE=satzung.tex
TARGET=satzung.pdf
BUILDDIR = out

default: $(TARGET)
all: $(TARGET)

$(TARGET):
	if [ ! -d $(BUILDDIR) ]; then mkdir $(BUILDDIR); fi
	latexmk -output-directory=$(BUILDDIR) -pdf -pdflatex="pdflatex" $(SOURCE)
	cp $(BUILDDIR)/$(TARGET) $(TARGET)

.PHONY: clean
clean:
	if [ -d $(BUILDDIR) ]; then rm --recursive ./$(BUILDDIR); fi

.PHONY: distclean
distclean: clean
	if [ -f $(TARGET) ]; then rm $(TARGET); fi
