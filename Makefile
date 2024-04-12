CHART_TESTING_VERSION:=3.10.1

.PHONY: build
build:
	dune build bin/main.exe

.PHONY: run
run:
	OCAMLRUNPARAM=b dune exec bin/main.exe controller

.PHONY: test
test:
	OCAMLRUNPARAM=b dune runtest

.PHONY: build-image
build-image:
	docker build . -t mahout:dev

.PHONY: setup-mahout
setup-mahout:
	kubectl delete -f config/test-pod.yaml || true
	kubectl delete -f config/mahout.anqou.net_mastodons.yaml || true
	minikube image rm mahout:dev
	$(MAKE) build-image
	docker save mahout:dev -o mahout_dev.img
	minikube image load mahout_dev.img
	rm mahout_dev.img
	kubectl apply -f config/mahout.anqou.net_mastodons.yaml || true
	kubectl apply -f config/test-pod.yaml || true
	sleep 3
	kubectl apply -f config/test-pod.yaml || true
	kubectl logs deploy/mastodon-operator -f

.PHONY: ct-lint
ct-lint:
	docker run \
		--rm \
		--user $(shell id -u $(USER)) \
		--workdir=/data \
		--volume $(shell pwd):/data \
		quay.io/helmpack/chart-testing:v$(CHART_TESTING_VERSION) \
		ct lint --all --validate-maintainers=false

.PHONY: setup-dev
setup-dev:
	opam switch create . 5.1.1 --no-install
	opam install . --deps-only --with-test
