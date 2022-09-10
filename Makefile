index.html: index.adoc
	bundle exec asciidoctor-revealjs index.adoc

.PHONY: watch
watch:
	ls style.css *.adoc | \
		entr bundle exec asciidoctor-revealjs -t index.adoc

.PHONY: serve
serve:
	@echo "Running on http://127.0.0.1:8080"
	@ruby -run -e httpd . -p 8080 -b 127.0.0.1
