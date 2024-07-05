KIND_VERSION:=0.23.0
KUBERNETES_VERSION?=1.30.0
HELM_VERSION:=3.15.2
WD:=$(dir $(lastword $(MAKEFILE_LIST)))
BIN:=$(WD)/_bin
KIND:=$(BIN)/kind-$(KIND_VERSION)
KIND_CLUSTER_NAME=mahout-test-cluster
KUBECTL:=$(BIN)/kubectl-$(KUBERNETES_VERSION)
HELM:=$(BIN)/helm-$(HELM_VERSION)
IMAGE=mahout:dev

$(BIN):
	mkdir -p $(BIN)

$(KIND): | $(BIN)
	wget -O $(KIND) https://github.com/kubernetes-sigs/kind/releases/download/v$(KIND_VERSION)/kind-linux-amd64
	chmod a+x $(KIND)

$(KUBECTL): | $(BIN)
	wget -O $(KUBECTL) https://storage.googleapis.com/kubernetes-release/release/v$(KUBERNETES_VERSION)/bin/linux/amd64/kubectl
	chmod a+x $(KUBECTL)

$(HELM): | $(BIN)
	curl -sSLf https://get.helm.sh/helm-v$(HELM_VERSION)-linux-amd64.tar.gz \
		| tar xvz -C $(BIN) --strip-components 1 linux-amd64/helm
	mv $(BIN)/helm $@

KUBECONFIG := $(shell pwd)/.kubeconfig
.PHONY: $(KUBECONFIG)
$(KUBECONFIG): | $(KIND)
	$(KIND) export kubeconfig --name $(KIND_CLUSTER_NAME) --kubeconfig=$@

.PHONY: setup
setup: $(KIND) $(KUBECTL) $(HELM)

.PHONY: build-image
build-image:
	cd $(WD)/.. && docker build . -t $(IMAGE)

.PHONY: clean-cluster
clean-cluster:
	$(KIND) delete cluster -n $(KIND_CLUSTER_NAME)

.PHONY: create-cluster
create-cluster:
	$(MAKE) setup
	$(MAKE) build-image
	$(MAKE) clean-cluster
	$(KIND) create cluster -n $(KIND_CLUSTER_NAME) --image kindest/node:v$(KUBERNETES_VERSION)
	$(KIND) load docker-image $(IMAGE) -n $(KIND_CLUSTER_NAME)
	$(MAKE) $(KUBECONFIG)
	$(KUBECTL) create namespace mahout
	$(KUBECTL) create namespace e2e
	$(KUBECTL) apply -f $(WD)/manifests/secret-env.yaml
	$(KUBECTL) apply -f $(WD)/manifests/toolbox.yaml
	$(KUBECTL) apply -f $(WD)/manifests/postgres.yaml
	$(KUBECTL) apply -f $(WD)/manifests/redis.yaml

.PHONY: helm-install-mahout
helm-install-mahout:
	KUBECONFIG=$(KUBECONFIG) $(HELM) install --namespace mahout mahout ../charts/mahout/ -f values.yaml

.PHONY: test
test:
	$(MAKE) create-cluster
	$(MAKE) helm-install-mahout
	bash -o pipefail -c "OCAMLRUNPARAM=b KUBECONFIG=$(HOME)/.kube/config KUBECTL=$(KUBECTL) dune exec ./e2e.exe | jq"

.PHONY: logs-deploy-mahout
logs-deploy-mahout:
	$(KUBECTL) logs -n mahout deploy/mahout
