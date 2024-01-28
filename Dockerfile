FROM ocaml/opam:debian-11-ocaml-5.0

ENV DEBIAN_FRONTEND=noninteractive

USER root
#RUN apt-get update && apt-get install -y \
#    libssl-dev libpcre2-dev pkg-config libgmp-dev libffi-dev libsodium-dev libopus-dev \
#    && rm -rf /var/lib/apt/lists/*

USER opam
WORKDIR /home/opam/mahout
RUN opam-2.1 update

COPY --chown=opam mahout.opam .
RUN opam-2.1 install . --deps-only
COPY --chown=opam . .
RUN opam-2.1 install . --deps-only

RUN eval $(opam-2.1 env) && dune build bin/main.exe

FROM ubuntu:22.04

#RUN apt-get update && apt-get install -y \
#    libsqlite3-dev \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/
COPY --from=0 /home/opam/mahout/_build/default/bin/main.exe ./mahout

ENTRYPOINT ["/root/mahout"]
CMD ["controller"]
