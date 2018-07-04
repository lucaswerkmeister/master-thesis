.PHONY: all clean

all:
	latexmk -pdf

clean:
	latexmk -C
