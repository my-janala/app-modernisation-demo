SHELL := /bin/bash

PROFILE ?= konveyor-demo
CPUS ?= 4
MEMORY ?= 8192
DISK ?= 40g
NAMESPACE ?= my-konveyor-operator
KCTX ?= $(PROFILE)
OPERATOR_MANIFEST ?= https://operatorhub.io/install/konveyor-operator.yaml
OLM_CRDS ?= https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/crds.yaml
OLM_OLM ?= https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/olm.yaml

.PHONY: setup minikube-start enable-addons install-olm install-konveyor wait-konveyor port-forward teardown clean

setup: minikube-start enable-addons install-olm install-konveyor wait-konveyor

minikube-start:
	minikube start --cpus=$(CPUS) --memory=$(MEMORY) --disk-size=$(DISK) -p $(PROFILE)

enable-addons:
	minikube addons enable ingress -p $(PROFILE)
	-minikube addons enable olm -p $(PROFILE)

install-olm:
	kubectl --context $(KCTX) apply -f $(OLM_CRDS)
	kubectl --context $(KCTX) apply -f $(OLM_OLM)

install-konveyor:
	kubectl --context $(KCTX) apply -f $(OPERATOR_MANIFEST)

wait-konveyor:
	@for dep in tackle-operator tackle-ui tackle-hub; do \
		bash -c 'set -euo pipefail; \
		until kubectl --context $(KCTX) -n $(NAMESPACE) get deployment/$$dep >/dev/null 2>&1; do \
			sleep 5; \
		 done; \
		kubectl --context $(KCTX) -n $(NAMESPACE) wait --for=condition=Available deployment/$$dep --timeout=300s'; \
	done

port-forward:
	kubectl --context $(KCTX) -n $(NAMESPACE) port-forward svc/tackle-ui 8080:8080

teardown:
	-@kubectl --context $(KCTX) delete -f $(OPERATOR_MANIFEST)
	-@kubectl --context $(KCTX) delete namespace $(NAMESPACE)
	minikube delete -p $(PROFILE)

clean:
	-@kubectl --context $(KCTX) -n $(NAMESPACE) delete tackle --all 2>/dev/null || true
