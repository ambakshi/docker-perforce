.PHONY: image clean push
all: image

DOCKER_REPO ?= ambakshi
IMAGES=perforce-base perforce-proxy perforce-server perforce-git-fusion \
	   perforce-swarm perforce-sampledepot perforce-p4web

.PHONY:  $(IMAGES)

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
	$(MAKE) all DOCKER_BUILD_ARGS='--no-cache'

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
	docker build -t $(DOCKER_REPO)/$(1) $(DOCKER_BUILD_ARGS) $(1)

$(1)-clean:
	-docker rmi $(DOCKER_REPO)/$(1) 2>/dev/null

endef

$(foreach image,$(IMAGES),$(eval $(call DOCKER_build,$(image))))

