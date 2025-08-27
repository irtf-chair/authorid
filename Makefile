TD=./text-diagram/text-diagram/text-diagram.js
NODE=/usr/local/bin/node
LADDER=$(NODE) ladder.js
DIAGRAMS=
DRAFT=draft-irtf-authorid.xml
TARGETS=$(DRAFT:%.xml=%.txt) $(DRAFT:%.xml=%.html) $(DRAFT:%.xml=%.pdf) 

All: $(TARGETS)

$(TARGETS): $(DIAGRAMS)

%.txt:%.xml
	xml2rfc --bom $<


%.html:%.xml
	xml2rfc --html $<


%.pdf:%.xml
	xml2rfc --pdf $<

%.txt:%.diagram
	-make $(NODE) td.js
	$(LADDER) <$< >$@

$(TD):
	git submodule init
	git submodule update

td.js: td-pre.js $(TD) td-post.js
	cat td-pre.js $(TD) td-post.js > $@


/usr/local/bin/node:
	brew install node

clean: 
	rm -f $(TARGETS) $(DIAGRAMS)




