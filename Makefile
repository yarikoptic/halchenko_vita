proj=resume.ps resume.pdf resume.html resume.txt
trash+= $(proj:.ps={.bbl,.blg,.dvi,.idx,.ilg,.ind,.toc,.pdf,.aux,.out,.log})

#stuff to install also
dist=resume.tex ltoh.pl ltoh.specs res.cls

include ../../Makefile.common

%.html: %.tex
	perl ltoh.pl $<

%.txt: %.html
	lynx --dump $< > $@


install: $(proj)
	cp $(proj) $(dist) ~/www/resume

