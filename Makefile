.PHONY: clean

all: 
	latexmk

clean:
	latexmk -C
