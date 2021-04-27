.PHONY: image clean push
all: image

-include local.mk

include envfile

DOCKER_REPO ?= ambakshi
DOCKER ?= docker
CENTOS8 = centos@sha256:5528e8b1b1719d34604c87e11dcd1c0a20bedf46e83b5632cdeac91b8c04efc1
BASEOS = ubuntu@sha256:538529c9d229fb55f50e6746b119e899775205d62c0fc1b7e679b30d02ecb6e8

IMAGES=perforce-proxy perforce-server perforce-sampledepot perforce-swarm perforce-p4web
DOCKER_BUILD_ARGS += --build-arg http_proxy=$(http_proxy) \
					 --build-arg https_proxy=$(https_proxy) \
					 --build-arg no_proxy=$(no_proxy) \
					 --build-arg P4D_VERSION=$(P4D_VERSION) \
					 --build-arg P4_VERSION=$(P4_VERSION) \
					 --build-arg SWARM_VERSION=$(SWARM_VERSION) \
					 --build-arg BASEOS=$(BASEOS)

.PHONY:  $(IMAGES)

all: perforce-server perforce-sampledepot perforce-swarm

perforce-proxy perforce-server perforce-sampledepot perforce-p4web perforce-swarm:
	$(DOCKER) build --target $@ -t $@ $(DOCKER_BUILD_ARGS) .
	$(DOCKER) tag $@ $@:$(P4D_VERSION)

rebuild:
	$(MAKE) clean
	$(MAKE) all CLEAN_ARGS='--no-cache'

clean:
	$(DOCKER) rmi $(IMAGES)

id_rsa:
	ssh-keygen -q -f $@ -N ""

id_rsa.pub: id_rsa
	ssh-keygen -y -f $< > $@

network:
	$(DOCKER) network create -d bridge --opt com.docker.network.bridge.enable_icc=true --opt com.docker.network.bridge.enable_ip_masquerade=true p4net
