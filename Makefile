.PHONY: image clean push
all: image

-include local.mk

P4_VERSION ?= 19.1
P4_BASEIMAGE ?= centos@sha256:a799dd8a2ded4a83484bbae769d97655392b3f86533ceb7dd96bbac929809f3c
DOCKER_REPO ?= ambakshi
IMAGES=perforce-base perforce-proxy perforce-server perforce-git-fusion \
	   perforce-swarm perforce-sampledepot perforce-p4web
DOCKER_BUILD_ARGS ?= --build-arg P4_BASEIMAGE=$(P4_BASEIMAGE) --build-arg http_proxy=$(http_proxy) --build-arg P4_VERSION=$(P4_VERSION)
NOCACHE ?= 0

ifeq "$(NOCACHE)" '1'
DOCKER_BUILD_ARGS += --no-cache
endif


.PHONY:  $(IMAGES)

# Include local settings (like http_proxy)
-include local.mk

perforce-proxy: perforce-base
perforce-server: perforce-base
perforce-proxy: perforce-base
perforce-git-fusion: perforce-server
perforce-sampledepot: perforce-server
perforce-swarm: perforce-base
perforce-p4web: perforce-base

rebuild:
	$(MAKE) clean
	docker pull centos:7
	$(MAKE) NOCACHE=1

%/id_rsa.pub: id_rsa.pub
	cp $< $@

id_rsa:
	ssh-keygen -q -f $@ -N ""

id_rsa.pub: id_rsa
	ssh-keygen -y -f $< > $@

define DOCKER_build

.PHONY: $(1) $(1)-clean

image: $(1)
clean: $(1)-clean

$(1): $(1)/Dockerfile
	@echo "===================="
	@echo "Building $(DOCKER_REPO)/$(1) ..."
	docker build $$(DOCKER_BUILD_ARGS) -t $(1) $(1)
	docker tag $(1) $(DOCKER_REPO)/$(1)

$(1)-clean:
	-docker rmi $(DOCKER_REPO)/$(1) 2>/dev/null

endef

$(foreach image,$(IMAGES),$(eval $(call DOCKER_build,$(image))))

