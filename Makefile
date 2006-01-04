proj=resume.ps resume.ps.gz resume.pdf resume.html resume.txt resume.djvu
trash+= $(proj:.ps={.bbl,.blg,.dvi,.idx,.ilg,.ind,.toc,.pdf,.aux,.out,.log})

#stuff to install also
dist=resume.tex ltoh.pl ltoh.specs res.cls

include ../../Makefile.common

%.html: %.tex
	perl ltoh.pl $<
	perl -pi -e 's/@/{a}/g' resume.html

%.txt: %.html
	lynx --dump $< > $@


install: $(proj)
	scp $(proj) $(dist) washoe.rutgers.edu:www/resume
