proj=resume.ps resume.pdf resume.html resume.txt
trash+= $(proj:.ps={.bbl,.blg,.dvi,.idx,.ilg,.ind,.toc,.pdf,.aux,.out,.log}) 

include ../../Makefile.common

%.html: %.tex
	perl ltoh.pl $<

%.txt: %.html
	lynx --dump $< > $@


install: $(proj)
	cp $(proj) ~/public_html/

