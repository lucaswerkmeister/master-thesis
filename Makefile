.PHONY: all clean

all: graphs/jobs-over-triples.tex graphs/jobs-over-entities.tex
	latexmk -pdf

graphs/jobs-without-outliers.tsv: graphs/jobs.tsv
	awk 'BEGIN { FS = "\\t" } $$1 != "humans-most-sitelinks-limit-50" && $$1 != "mammal-taxa-limit-20000"' $< > $@

graphs/jobs-over-entities.tex graphs/jobs-without-outliers-over-entities.tex \
graphs/jobs-over-triples.tex graphs/jobs-without-outliers-over-triples.tex \
graphs/jobs-over-P31s.tex graphs/jobs-without-outliers-over-P31s.tex \
graphs/jobs-over-classes.tex graphs/jobs-without-outliers-over-classes.tex \
: graphs/jobs.gp graphs/jobs.tsv graphs/jobs-without-outliers.tsv
	gnuplot $<

clean:
	latexmk -C
	$(RM) graphs/*.tex
