.PHONY: all clean

all: graphs/jobs-over-triples.tex graphs/jobs-over-entities.tex
	latexmk -pdf

graphs/jobs-over-triples.tex graphs/jobs-over-entities.tex: graphs/jobs.gp graphs/jobs.tsv
	gnuplot $<

clean:
	latexmk -C
	$(RM) graphs/jobs-over-triples.tex graphs/jobs-over-entities.tex
