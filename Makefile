proj=resume.ps resume.ps.gz resume.pdf resume.html resume.txt
#resume.djvu
trash+= $(proj:.ps={.bbl,.blg,.dvi,.idx,.ilg,.ind,.toc,.pdf,.aux,.out,.log})

#stuff to install also
dist=resume.tex ltoh.pl ltoh.specs res.cls

USE_PDFTEX=1

%.txt: %.html
	lynx --dump $< >| $@


include ../common/Makefile.common


all:: $(proj)

halchenko_vita.pdf: halchenko_vita.bbl Makefile
#biosketch.bbl::
	[ -e halchenko_vita.bbl ] && \
      sed -i \
         -e '/URL *$$/{N;s,\n,,g}' \
         -e 's/\(Y.~O. Halchenko\)/\\textbf{\1}/g'  \
         -e '/ ISSN /d' \
         -e '/URL.*\(doi\.org\|cell\.com\|pubmed\|frontiersin\|poldracklab\)/d' halchenko_vita.bbl || :

%.tex: Makefile

%.u.tex: %.tex  res.cls
	sed -e 's/\\url/\\href{URL}/g' -e 's/\\ / /g' $^ >| $@

%.u.html: %.u.tex
	perl ltoh.pl $<

%.html: %.u.html
	sed -e 's/"\([^"]*\)@/"mailto:\1{a}/g' \
		-e 's/>\([^>]*\)@/>\1{a}/g' \
		-e 's/\[parsep[^]]*\]//g' \
		$^ \
	 >| $@

.PHONY: install
install: $(proj)
	scp $(proj) $(dist) www.onerussian.com:www/resume

clean::
	rm -f *.u.{html,tex}
