.PHONY: build
build:
	dune build bin/main.exe

.PHONY: run
run:
	OCAMLRUNPARAM=b dune exec bin/main.exe controller

.PHONY: test
test:
	OCAMLRUNPARAM=b dune runtest
