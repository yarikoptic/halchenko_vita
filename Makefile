proj=resume.ps resume.ps.gz resume.pdf resume.html resume.txt resume.djvu
trash+= $(proj:.ps={.bbl,.blg,.dvi,.idx,.ilg,.ind,.toc,.pdf,.aux,.out,.log})

#stuff to install also
dist=resume.tex ltoh.pl ltoh.specs res.cls

include ../../Makefile.common

%.tex: Makefile

%.u.tex: %.tex
	sed -e 's/\\url/\\href{URL}/g' -e 's/\\ / /g' $^ >| $@

%.u.html: %.u.tex
	perl ltoh.pl $<

%.html: %.u.html
	sed -e 's/"\([^"]*\)@/"mailto:\1{a}/g' \
		-e 's/>\([^>]*\)@/>\1{a}/g' $^ \
	 >| $@

%.txt: %.html
	lynx --dump $< >| $@

.PHONY: install
install: $(proj)
	scp $(proj) $(dist) washoe.rutgers.edu:www/resume

clean::
	rm -f *.u.{html,tex}
