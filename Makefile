SHELL := /bin/bash

PROFILE ?= konveyor-demo
CPUS ?= 4
MEMORY ?= 8192
DISK ?= 40g
NAMESPACE ?= my-konveyor-operator
KCTX ?= $(PROFILE)
# Toggle to reapply upstream OLM manifests (defaults to relying on minikube addon)
INSTALL_OLM_MANUALLY ?= false
OPERATOR_MANIFEST ?= https://operatorhub.io/install/konveyor-operator.yaml
# Pin to a known-good OLM release to avoid oversized annotations in latest manifests
OLM_VERSION ?= v0.25.0
OLM_CRDS ?= https://github.com/operator-framework/operator-lifecycle-manager/releases/download/$(OLM_VERSION)/crds.yaml
OLM_OLM ?= https://github.com/operator-framework/operator-lifecycle-manager/releases/download/$(OLM_VERSION)/olm.yaml

.PHONY: setup minikube-start enable-addons install-olm install-konveyor wait-tackle-crd apply-tackle wait-konveyor port-forward teardown clean

setup: minikube-start enable-addons install-olm install-konveyor wait-tackle-crd apply-tackle wait-konveyor

minikube-start:
	minikube start --cpus=$(CPUS) --memory=$(MEMORY) --disk-size=$(DISK) -p $(PROFILE)

enable-addons:
	minikube addons enable ingress -p $(PROFILE)
	-minikube addons enable olm -p $(PROFILE)

install-olm:
	@if [ "$(INSTALL_OLM_MANUALLY)" = "true" ]; then \
		echo "Applying OLM manifests from $(OLM_VERSION)"; \
		kubectl --context $(KCTX) apply -f $(OLM_CRDS); \
		kubectl --context $(KCTX) apply -f $(OLM_OLM); \
	else \
		echo "Skipping manual OLM install; relying on minikube addon (set INSTALL_OLM_MANUALLY=true to override)"; \
	fi

install-konveyor:
	kubectl --context $(KCTX) apply -f $(OPERATOR_MANIFEST)

wait-tackle-crd:
	@echo "Waiting for tackles.tackle.konveyor.io CRD to be available..."
	@retries=60; \
	while [ $$retries -gt 0 ]; do \
		if kubectl --context $(KCTX) get crd tackles.tackle.konveyor.io >/dev/null 2>&1; then \
			echo "✓ Tackle CRD ready"; \
			exit 0; \
		fi; \
		sleep 5; \
		retries=$$((retries - 1)); \
	done; \
	echo "Timed out waiting for tackles.tackle.konveyor.io"; \
	exit 1

apply-tackle:
	kubectl --context $(KCTX) apply -f assets/tackle-cr.yaml

wait-konveyor:
	@for dep in tackle-operator tackle-ui tackle-hub; do \
		echo "Waiting for deployment/$$dep..."; \
		until kubectl --context $(KCTX) -n $(NAMESPACE) get deployment/$$dep >/dev/null 2>&1; do \
			sleep 5; \
		done; \
		kubectl --context $(KCTX) -n $(NAMESPACE) wait --for=condition=Available deployment/$$dep --timeout=300s; \
	done

port-forward:
	kubectl --context $(KCTX) -n $(NAMESPACE) port-forward svc/tackle-ui 8080:8080

teardown:
	-@kubectl --context $(KCTX) delete -f $(OPERATOR_MANIFEST)
	-@kubectl --context $(KCTX) delete namespace $(NAMESPACE)
	minikube delete -p $(PROFILE)

clean:
	-@kubectl --context $(KCTX) -n $(NAMESPACE) delete tackle --all 2>/dev/null || true
