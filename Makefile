SHELL := /bin/bash

ASCIIDOCTOR = bundle exec asciidoctor-revealjs
ASCIIDOCTOR_ARGS = \
	   -r asciidoctor-diagram \
	   -a mmdc=$(shell pwd)/node_modules/.bin/mmdc \
	   -a imagesdir=images \
	   -a revealjs_plugin_zoom=disabled \
	   -a docinfo=shared \
	   -t

index.html: index.adoc
	$(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc

.PHONY: site
site:
	@rm -rf _site && mkdir -p _site/reveal.js/plugin
	$(ASCIIDOCTOR) -D _site $(ASCIIDOCTOR_ARGS) index.adoc
	cp -R css _site/css
	cp -R fonts _site/fonts
	cp -R reveal.js/dist _site/reveal.js/dist
	cp -R reveal.js/plugin/{highlight,notes} _site/reveal.js/plugin

.PHONY: watch
watch:
	ls *.adoc | entr $(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc

.PHONY: serve
serve:
	@echo "Running on http://127.0.0.1:8080"
	@ruby -run -e httpd . -p 8080 -b 127.0.0.1
