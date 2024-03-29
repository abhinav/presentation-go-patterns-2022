SHELL := /bin/bash

SPEAKER_NOTES ?=
CLOUDFLARE_WA_TOKEN ?=
ASCIIDOCTOR = bundle exec asciidoctor-revealjs
ASCIIDOCTOR_ARGS = \
	   -r asciidoctor-diagram \
	   -r ./lib/analytics.rb \
	   -a mmdc=$(shell pwd)/node_modules/.bin/mmdc \
	   -a imagesdir=images \
	   -a docinfo=shared \
	   -t

ifneq ($(SPEAKER_NOTES),)
ASCIIDOCTOR_ARGS += -a revealjs_showNotes=separate-page
endif

ifneq ($(CLOUDFLARE_WA_TOKEN),)
ASCIIDOCTOR_ARGS += -a cloudflare-wa-token=$(CLOUDFLARE_WA_TOKEN)
endif

index.html: index.adoc
	$(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc

.PHONY: site
site:
	@rm -rf _site && mkdir -p _site/reveal.js/plugin
	$(ASCIIDOCTOR) -D _site $(ASCIIDOCTOR_ARGS) index.adoc
	cp -R css _site/css
	cp -R fonts _site/fonts
	cp $(shell git ls-files images | grep -v gitignore) _site/images
	cp -R reveal.js/dist _site/reveal.js/dist
	cp -R reveal.js/plugin/{highlight,notes} _site/reveal.js/plugin

.PHONY: watch
watch:
	while sleep 1; do \
		ls *.adoc | entr -d $(ASCIIDOCTOR) $(ASCIIDOCTOR_ARGS) index.adoc; \
	done

.PHONY: serve
serve:
	@echo "Running on http://127.0.0.1:8080"
	@ruby -run -e httpd . -p 8080 -b 127.0.0.1
