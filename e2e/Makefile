KIND_VERSION:=0.20.0
KUBERNETES_VERSION:=1.27.3
WD:=$(dir $(lastword $(MAKEFILE_LIST)))
BIN:=$(WD)/_bin
KIND:=$(BIN)/kind-$(KIND_VERSION)
KIND_CLUSTER_NAME=mahout-test-cluster
KUBECTL:=$(BIN)/kubectl-$(KUBERNETES_VERSION)
IMAGE=mahout:dev

$(BIN):
	mkdir -p $(BIN)

$(KIND):
	wget -O $(KIND) https://github.com/kubernetes-sigs/kind/releases/download/v$(KIND_VERSION)/kind-linux-amd64
	chmod a+x $(KIND)

$(KUBECTL):
	wget -O $(KUBECTL) https://storage.googleapis.com/kubernetes-release/release/v$(KUBERNETES_VERSION)/bin/linux/amd64/kubectl
	chmod a+x $(KUBECTL)

.PHONY: setup
setup: $(KIND) $(KUBECTL)

.PHONY: build-image
build-image:
	cd $(WD)/.. && docker build . -t $(IMAGE)

.PHONY: clean-cluster
clean-cluster:
	$(KIND) delete cluster -n $(KIND_CLUSTER_NAME)

.PHONY: create-cluster
create-cluster: setup build-image
	$(MAKE) clean-cluster
	$(KIND) create cluster -n $(KIND_CLUSTER_NAME) --image kindest/node:v$(KUBERNETES_VERSION)
	$(KIND) load docker-image $(IMAGE) -n $(KIND_CLUSTER_NAME)
	$(KUBECTL) apply -f $(WD)/manifests/mahout.anqou.net_mastodons.yaml
	$(KUBECTL) wait --for condition="established" crd mastodons.mahout.anqou.net
	$(KUBECTL) apply -f $(WD)/manifests/serviceaccount.yaml
	$(KUBECTL) apply -f $(WD)/manifests/clusterrole.yaml
	$(KUBECTL) apply -f $(WD)/manifests/clusterrolebinding.yaml
	$(KUBECTL) apply -f $(WD)/manifests/operator.yaml
	$(KUBECTL) apply -f $(WD)/manifests/secret-env.yaml
	$(KUBECTL) apply -f $(WD)/manifests/mastodon.yaml

.PHONY: test
test:
	KUBECONFIG=$(HOME)/.kube/config dune exec ./main.exe
