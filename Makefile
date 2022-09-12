ASCIIDOCTOR = bundle exec asciidoctor-revealjs
ASCIIDOCTOR_ARGS = \
	   -r asciidoctor-diagram \
	   -a mmdc=$(shell pwd)/node_modules/.bin/mmdc \
	   -a imagesdir=images \
	   -t

index.html: index.adoc
	$(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc

.PHONY: watch
watch:
	ls *.adoc | entr $(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc

.PHONY: serve
serve:
	@echo "Running on http://127.0.0.1:8080"
	@ruby -run -e httpd . -p 8080 -b 127.0.0.1
