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
	minikube image rm mahout:dev
	$(MAKE) build-image
	docker save mahout:dev -o mahout_dev.img
	minikube image load mahout_dev.img
	rm mahout_dev.img
	kubectl apply -f config/test-pod.yaml
	sleep 3
	kubectl logs test-pod -f
