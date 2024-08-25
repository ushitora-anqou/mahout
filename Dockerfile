FROM ocaml/opam:debian-11-ocaml-5.2

ENV DEBIAN_FRONTEND=noninteractive

USER root

USER opam
WORKDIR /home/opam/mahout
RUN opam-2.1 update

COPY --chown=opam mahout.opam .
RUN opam-2.1 install . --deps-only
COPY --chown=opam . .
RUN opam-2.1 install . --deps-only

RUN eval $(opam-2.1 env) && dune build bin/main.exe

FROM ubuntu:22.04

WORKDIR /root/
COPY --from=0 /home/opam/mahout/_build/default/bin/main.exe ./mahout

ENTRYPOINT ["/root/mahout"]
CMD ["controller"]
